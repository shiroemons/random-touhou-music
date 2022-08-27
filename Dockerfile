FROM ruby:3.1.2

RUN gem install bundler:2.3.11

WORKDIR /app
COPY . /app

RUN bundle install

EXPOSE 4567