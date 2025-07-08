# Random touhou music

## 概要

東方同人音楽流通 Apple Music、Spotify、YouTube Music、とLINE MUSICの東方楽曲をランダムで選曲してくれるWebアプリ

## Webアプリ

- Apple Music
  - https://random.touhou-search.com/
  - https://random.touhou-search.com/apple_music
  - https://random.touhou-search.com/apple_music/songs_count
  - https://random.touhou-search.com/apple_music/team_shanghai_alice

- Spotify
  - https://random.touhou-search.com/spotify
  - https://random.touhou-search.com/spotify/songs_count
  - https://random.touhou-search.com/spotify/team_shanghai_alice

- YouTube Music
  - https://random.touhou-search.com/youtube_music
  - https://random.touhou-search.com/youtube_music/songs_count
  - https://random.touhou-search.com/youtube_music/team_shanghai_alice

- LINE MUSIC
  - https://random.touhou-search.com/line_music
  - https://random.touhou-search.com/line_music/songs_count
  - https://random.touhou-search.com/line_music/team_shanghai_alice

## 使い方

### Docker Compose での開発

- 初回起動（ビルド + 起動 + ログ表示）
  ```sh
  make quick-start
  ```

- 通常の起動
  ```sh
  make up
  ```

- ログ確認
  ```sh
  make logs
  ```

- 停止
  ```sh
  make down
  ```

- ヘルプ表示（全コマンド確認）
  ```sh
  make help
  ```

### 利用可能なエンドポイント

- http://localhost:4567/
- http://localhost:4567/apple_music
- http://localhost:4567/apple_music/songs_count
- http://localhost:4567/apple_music/team_shanghai_alice
- http://localhost:4567/spotify
- http://localhost:4567/spotify/songs_count
- http://localhost:4567/spotify/team_shanghai_alice
- http://localhost:4567/youtube_music
- http://localhost:4567/youtube_music/songs_count
- http://localhost:4567/youtube_music/team_shanghai_alice
- http://localhost:4567/line_music
- http://localhost:4567/line_music/songs_count
- http://localhost:4567/line_music/team_shanghai_alice

### その他の便利なコマンド

- エンドポイント動作確認
  ```sh
  make test-endpoints
  ```

- アプリケーションの健康状態確認
  ```sh
  make health
  ```

- コンテナ内でシェル実行
  ```sh
  make shell
  ```

## 機能

- Apple Musicの東方楽曲をランダムで選曲する
- Spotifyの東方楽曲をランダムで選曲する
- YouTube Musicの東方楽曲をランダムで選曲する
- LINE MUSICの東方楽曲をランダムで選曲する

## デプロイ

### fly.io

- [Installing flyctl](https://fly.io/docs/getting-started/installing-flyctl/)

1. login
  ```shell
  flyctl auth login
  ```
1. deploy
  ```shell
  fly deploy
  ```

## 作成者

[@shiroemons](https://twitter.com/shiroemons)

## ライセンス

[MIT License](https://opensource.org/licenses/MIT)
