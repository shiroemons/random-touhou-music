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

### スモークテスト

全経路が正しく動くかを HTTP で確かめます（リダイレクト先がデータファイルの曲か、曲数、`/up`、404、ホスト制限）。
本番と同じイメージで確かめるため、Docker Compose の開発環境（development モード）ではなく本番用イメージに対して実行します。

```sh
docker build -t random-touhou-music .
docker run -d --name app -p 4568:4567 random-touhou-music
ruby script/smoke_test.rb http://localhost:4568
docker rm -f app
```

## 機能

- Apple Musicの東方楽曲をランダムで選曲する
- Spotifyの東方楽曲をランダムで選曲する
- YouTube Musicの東方楽曲をランダムで選曲する
- LINE MUSICの東方楽曲をランダムで選曲する

## デプロイ

### 自動デプロイ

週 1 回、毎週月曜 12:00 (JST) の定期実行の Test が成功すると、Deploy ワークフローが main の内容を Fly.io にデプロイします。
前回のデプロイから変更がなければデプロイしません。
Renovate が自動マージした依存関係の更新や、データの更新も、この週 1 回のデプロイで本番に反映されます。

データの更新などをすぐに反映したいときは、手動で Deploy ワークフローを実行してください（Test に通ったコミットだけがデプロイされます）。

```shell
gh workflow run deploy.yml
```

- Renovate の更新は、CI のスモークテスト（本番と同じイメージで全経路を確認）が通れば、メジャー更新も含めて自動マージされます。
  GitHub Actions の更新だけは、CI では安全性を判定できないため手動でマージします。
- gem は公開から 3 日たった版だけを取り込みます（Gemfile の `cooldown` と Renovate の `minimumReleaseAge`）。
- デプロイは bluegreen 方式で、新しいマシンがヘルスチェック（`/up`）に通ってから切り替わります。
- デプロイ後は本番 URL に対しても同じスモークテストを実行し、失敗すると GitHub から通知が届きます。

初回のみ、Fly.io のデプロイ用トークンを GitHub Secrets に登録してください。

```shell
fly tokens create deploy | gh secret set FLY_API_TOKEN
```

### 手動デプロイ（fly.io）

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
