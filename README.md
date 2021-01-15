# Random touhou music

東方同人音楽流通 Apple Musicの東方楽曲をランダム選択(リダイレクト)するプログラム。

## 独自ドメイン

- Apple Music
http://random.touhou-search.com/

- YouTube Music
http://random.touhou-search.com/youtube_music

## heroku

- Apple Music
https://random-touhou-music.herokuapp.com/

- YouTube Music
https://random-touhou-music.herokuapp.com/youtube_music

## 開発環境

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