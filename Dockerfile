FROM ruby:3.4.4-alpine

RUN apk add --upgrade ruby-dev make gcc libc-dev
RUN gem install bundler:2.6.9

WORKDIR /app
COPY . /app

ENV RUBY_YJIT_ENABLE=1

RUN bundle install

EXPOSE 4567

CMD ["ruby", "app.rb"]
