# Random touhou music

## 概要

東方同人音楽流通 Apple MusicとYouTube Musicの東方楽曲をランダムで選曲してくれるWebアプリ

## Webアプリ

- Apple Music
http://random.touhou-search.com/

- YouTube Music
http://random.touhou-search.com/youtube_music

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
  - http://localhost:4567/youtube_music

- server停止
  - `Ctrl+C`

## 機能

- Apple Musicの東方楽曲をランダムで選曲する
- YouTube Musicの東方楽曲をランダムで選曲する

## 作成者

[@shiroemons](https://twitter.com/shiroemons)

## ライセンス

[MIT License](https://opensource.org/licenses/MIT)