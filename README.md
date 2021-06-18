# Random touhou music

## 概要

東方同人音楽流通 Apple Music、YouTube Music、SpotifyとAmazon Musicの東方楽曲をランダムで選曲してくれるWebアプリ

## Webアプリ

- Apple Music
  - http://random.touhou-search.com/
  - http://random.touhou-search.com/apple_music
  - http://random.touhou-search.com/apple_music/songs_count

- YouTube Music
  - http://random.touhou-search.com/youtube_music
  - http://random.touhou-search.com/youtube_music/songs_count

- Spotify
  - http://random.touhou-search.com/spotify
  - http://random.touhou-search.com/spotify/songs_count

- Amazon Music
  - http://random.touhou-search.com/amazon_music
  - http://random.touhou-search.com/amazon_music/songs_count


## 使い方

- setup
  ```sh
  bundle install
  ```

- server起動
  ```sh
  bundle exec ruby app.rb
  ```
  - http://localhost:4567/
  - http://localhost:4567/apple_music
  - http://localhost:4567/apple_music/songs_count
  - http://localhost:4567/youtube_music
  - http://localhost:4567/youtube_music/songs_count
  - http://localhost:4567/spotify
  - http://localhost:4567/spotify/songs_count
  - http://localhost:4567/amazon_music
  - http://localhost:4567/amazon_music/songs_count

- server停止
  - `Ctrl+C`

## 機能

- Apple Musicの東方楽曲をランダムで選曲する
- YouTube Musicの東方楽曲をランダムで選曲する
- Spotifyの東方楽曲をランダムで選曲する
- Amazon Musicの東方楽曲をランダムで選曲する

## 作成者

[@shiroemons](https://twitter.com/shiroemons)

## ライセンス

[MIT License](https://opensource.org/licenses/MIT)