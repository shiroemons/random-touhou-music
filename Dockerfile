FROM ruby:3.3.1-alpine3.19

RUN apk add --upgrade ruby-dev make gcc libc-dev
RUN gem install bundler:2.5.7

WORKDIR /app
COPY . /app

ENV RUBY_YJIT_ENABLE 1

RUN bundle install

EXPOSE 4567

CMD ["ruby", "app.rb"]
