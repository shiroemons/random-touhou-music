require 'json'
require 'sinatra'

APPLE_MUSIC_SONGS = JSON.parse(File.read("data/apple_music_songs.json")).freeze
APPLE_MUSIC_TSA_SONGS = JSON.parse(File.read("data/apple_music_tsa_songs.json")).freeze
SPOTIFY_SONGS = JSON.parse(File.read("data/spotify_songs.json")).freeze
SPOTIFY_TSA_SONGS = JSON.parse(File.read("data/spotify_tsa_songs.json")).freeze
YOUTUBE_MUSIC_SONGS = JSON.parse(File.read("data/youtube_music_songs.json")).freeze
YOUTUBE_MUSIC_TSA_SONGS = JSON.parse(File.read("data/youtube_music_tsa_songs.json")).freeze
LINE_MUSIC_SONGS = JSON.parse(File.read("data/line_music_songs.json")).freeze
LINE_MUSIC_TSA_SONGS = JSON.parse(File.read("data/line_music_tsa_songs.json")).freeze
AMAZON_MUSIC_SONGS = JSON.parse(File.read("data/amazon_music_songs.json")).freeze

set :bind, '0.0.0.0'
set :host_authorization, { permitted_hosts: ['random.touhou-search.com', 'random-touhou-music.fly.dev', 'localhost', '127.0.0.1'] }

get ['/', '/apple_music'] do
  song = APPLE_MUSIC_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/apple_music/songs_count' do
  "#{APPLE_MUSIC_SONGS.size}曲"
end

get '/apple_music/team_shanghai_alice' do
  song = APPLE_MUSIC_TSA_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/spotify' do
  song = SPOTIFY_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/spotify/songs_count' do
  "#{SPOTIFY_SONGS.size}曲"
end

get '/spotify/team_shanghai_alice' do
  song = SPOTIFY_TSA_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/youtube_music' do
  song = YOUTUBE_MUSIC_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/youtube_music/songs_count' do
  "#{YOUTUBE_MUSIC_SONGS.size}曲"
end

get '/youtube_music/team_shanghai_alice' do
  song = YOUTUBE_MUSIC_TSA_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/line_music' do
  song = LINE_MUSIC_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/line_music/songs_count' do
  "#{LINE_MUSIC_SONGS.size}曲"
end

get '/line_music/team_shanghai_alice' do
  song = LINE_MUSIC_TSA_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/amazon_music' do
  song = AMAZON_MUSIC_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/amazon_music/songs_count' do
  "#{AMAZON_MUSIC_SONGS.size}曲"
end
