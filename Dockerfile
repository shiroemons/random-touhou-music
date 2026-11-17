# syntax=docker/dockerfile:1

# ベースイメージは digest で固定する（Renovate が tag と digest をまとめて更新する）
FROM ruby:4.0.9-alpine@sha256:8ad6909db16ad53b5dc90bb8cc157e5fdd89ba1172798316b95cfd2a61f14b1e AS base

WORKDIR /app

ENV LANG=C.UTF-8 \
    RUBY_YJIT_ENABLE=1

# ベースイメージ公開後に出た OS パッケージの修正を取り込む
RUN apk upgrade --no-cache

# Gemfile.lock の BUNDLED WITH と同じバージョンの Bundler を入れる
COPY Gemfile.lock ./
RUN gem install bundler --no-document \
      -v "$(awk '/^BUNDLED WITH$/ { getline; print $1 }' Gemfile.lock)"

# ------------------------------------------------------------
# 開発用（docker compose で使う。ソースは bind mount する）
# ------------------------------------------------------------
FROM base AS development

ENV RACK_ENV=development \
    APP_ENV=development

RUN apk add --no-cache build-base

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install

COPY . .

EXPOSE 4567
CMD ["bundle", "exec", "ruby", "app.rb"]

# ------------------------------------------------------------
# 本番用 gem のビルド（コンパイラはこのステージにだけ入れる）
# ------------------------------------------------------------
FROM base AS build

ENV BUNDLE_FROZEN=true \
    BUNDLE_WITHOUT=development

RUN apk add --no-cache build-base

COPY Gemfile Gemfile.lock .ruby-version ./
RUN bundle install --jobs 4 \
    && rm -rf "${GEM_HOME}"/cache \
    && find "${GEM_HOME}"/gems -type d -name ext -prune -exec rm -rf {} +

# ------------------------------------------------------------
# 本番用（最終ステージ。fly deploy はこのステージを使う）
# ------------------------------------------------------------
FROM base AS production

ENV RACK_ENV=production \
    APP_ENV=production \
    BUNDLE_FROZEN=true \
    BUNDLE_WITHOUT=development

RUN addgroup -S app && adduser -S -G app app

COPY --from=build /usr/local/bundle /usr/local/bundle

# 必要なファイルだけを root 所有でコピーし、実行ユーザーからは書き換えられないようにする
COPY Gemfile Gemfile.lock .ruby-version config.ru app.rb ./
COPY config ./config
COPY data ./data

USER app

EXPOSE 4567
CMD ["bundle", "exec", "puma"]
