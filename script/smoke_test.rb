# frozen_string_literal: true

# 全経路が正しく動くかを HTTP で確かめるスモークテスト。Ruby の標準ライブラリだけで動く。
# CI では本番と同じ Docker イメージに対して、デプロイ後は本番環境に対して実行する。
#
# 使い方:
#   ruby script/smoke_test.rb http://localhost:4568
#   ruby script/smoke_test.rb https://random.touhou-search.com --skip-host-authorization
#
# 確かめること:
#   - 各経路が 302 で、対応するデータファイルに入っている曲の URL へリダイレクトする
#   - 曲数が、データファイルの件数と一致する
#   - /up が OK を返す
#   - 存在しないパスは 404 で、development モードの 404 ページを出さない
#   - 許可していないホストからのアクセスは 403 で、ヘルスチェック用の /up だけは通る

require 'json'
require 'net/http'
require 'openssl'
require 'optparse'
require 'uri'

class SmokeTest
  # スモークテスト用の HTTP クライアント
  class Client
    CONNECTION_ERRORS = [SystemCallError, IOError, Net::OpenTimeout, Net::ReadTimeout, OpenSSL::SSL::SSLError].freeze

    def initialize(base_url)
      @base = URI(base_url)
    end

    def to_s = @base.to_s

    def get(path, host: nil)
      uri = @base + path
      request = Net::HTTP::Get.new(uri)
      request['Host'] = host if host
      Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https', open_timeout: 5, read_timeout: 10) do |http|
        http.request(request)
      end
    end

    def ready?
      get('/up').code == '200'
    rescue *CONNECTION_ERRORS
      false
    end
  end

  DATA_DIR = File.expand_path('../data', __dir__)

  # サービスごとの全曲データと原作曲データ（Amazon Music は原作曲の経路がない）
  SERVICES = {
    'apple_music' => ['apple_music_songs.json', 'apple_music_tsa_songs.json'],
    'spotify' => ['spotify_songs.json', 'spotify_tsa_songs.json'],
    'youtube_music' => ['youtube_music_songs.json', 'youtube_music_tsa_songs.json'],
    'line_music' => ['line_music_songs.json', 'line_music_tsa_songs.json'],
    'amazon_music' => ['amazon_music_songs.json', nil],
  }.freeze

  # ランダムに選ばれるので、各経路を複数回リクエストして確かめる
  REDIRECT_SAMPLES = 3
  FOREIGN_HOST = 'evil.example.com'
  # Fly.io のヘルスチェックは内部 IP の Host ヘッダーで届く
  INTERNAL_HOST = '172.19.0.2:4567'

  def initialize(base_url, host_authorization:, wait:)
    @client = Client.new(base_url)
    @host_authorization = host_authorization
    @wait = wait
    @songs = {}
    @checks = 0
    @failures = []
  end

  def run
    puts "スモークテスト: #{@client}"
    wait_until_ready
    check_health
    check_services
    check_not_found
    check_host_authorization if @host_authorization
    report
  end

  private

  def wait_until_ready
    deadline = Time.now + @wait
    until @client.ready?
      abort "#{@client} が #{@wait} 秒以内に応答しませんでした" if Time.now > deadline
      sleep 1
    end
  end

  def check_health
    res = get('/up')
    expect('GET /up は 200 で OK を返す', res.code == '200' && body(res) == 'OK', res)
  end

  def check_services
    SERVICES.each do |service, (songs_file, tsa_file)|
      check_redirect("/#{service}", songs_file)
      check_redirect("/#{service}/team_shanghai_alice", tsa_file) if tsa_file
      check_songs_count(service, songs_file)
    end
    check_redirect('/', SERVICES['apple_music'].first)
  end

  def check_redirect(path, file)
    urls = songs(file).to_set { |song| song['url'] }
    REDIRECT_SAMPLES.times do
      res = get(path)
      expect("GET #{path} は #{file} の曲へ 302 でリダイレクトする",
             res.code == '302' && urls.include?(res['location']), res)
    end
  end

  def check_songs_count(service, file)
    path = "/#{service}/songs_count"
    expected = "#{songs(file).size}曲"
    res = get(path)
    expect("GET #{path} は「#{expected}」を返す", res.code == '200' && body(res) == expected, res)
  end

  def check_not_found
    res = get('/__smoke_test_not_found__')
    expect('存在しないパスは 404 を返し、development モードの 404 ページを出さない',
           res.code == '404' && !body(res).include?('Sinatra'), res)
  end

  def check_host_authorization
    res = get('/spotify', host: FOREIGN_HOST)
    expect("許可していないホスト（#{FOREIGN_HOST}）からのアクセスは 403 になる", res.code == '403', res)

    res = get('/up', host: INTERNAL_HOST)
    expect("Host: #{INTERNAL_HOST} でも /up は 200 を返す（Fly.io のヘルスチェック）", res.code == '200', res)

    res = get('/', host: INTERNAL_HOST)
    expect("Host: #{INTERNAL_HOST} でも /up 以外は 403 になる", res.code == '403', res)
  end

  def songs(file)
    @songs[file] ||= JSON.parse(File.read(File.join(DATA_DIR, file)))
  end

  def get(...) = @client.get(...)

  def body(res)
    res.body.to_s.dup.force_encoding(Encoding::UTF_8)
  end

  def expect(description, passed, res)
    @checks += 1
    if passed
      puts "ok   #{description}"
    else
      @failures << description
      puts "FAIL #{description}"
      puts "     status=#{res.code} location=#{res['location'].inspect} body=#{body(res)[0, 100].inspect}"
    end
  end

  def report
    puts
    puts "#{@checks} 件中 #{@checks - @failures.size} 件成功、#{@failures.size} 件失敗"
    exit(@failures.empty? ? 0 : 1)
  end
end

# CI のログでエラー出力と順序が入れ替わらないようにする
$stdout.sync = true

options = { host_authorization: true, wait: 60 }
parser = OptionParser.new do |opts|
  opts.banner = 'Usage: ruby script/smoke_test.rb BASE_URL [--skip-host-authorization] [--wait SECONDS]'
  opts.on('--skip-host-authorization',
          '許可していないホストが拒否されるかの確認を省く（本番は Fly.io のプロキシが任意の Host ヘッダーを届けないため）') do
    options[:host_authorization] = false
  end
  opts.on('--wait SECONDS', Integer, '/up が応答するまで待つ秒数（既定 60）') { |seconds| options[:wait] = seconds }
end
parser.parse!
abort parser.banner unless ARGV.size == 1

SmokeTest.new(ARGV.first, **options).run
