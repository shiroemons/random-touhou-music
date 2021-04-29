require 'json'
require 'sinatra'

APPLE_MUSIC_SONGS = JSON.parse(File.read("data/apple_music_songs.json")).freeze
YOUTUBE_MUSIC_SONGS = JSON.parse(File.read("data/youtube_music_songs.json")).freeze
SPOTIFY_SONGS = JSON.parse(File.read("data/spotify_songs.json")).freeze

get ['/', '/apple_music'] do
  song = APPLE_MUSIC_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/apple_music/songs_count' do
  "#{APPLE_MUSIC_SONGS.size}曲"
end

get '/youtube_music' do
  song = YOUTUBE_MUSIC_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/youtube_music/songs_count' do
  "#{YOUTUBE_MUSIC_SONGS.size}曲"
end

get '/spotify' do
  song = SPOTIFY_SONGS.sample
  logger.info song
  redirect song["url"]
end

get '/spotify/songs_count' do
  "#{SPOTIFY_SONGS.size}曲"
end
