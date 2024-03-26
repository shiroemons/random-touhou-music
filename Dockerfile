FROM ruby:3.3.0-alpine3.19

RUN gem install bundler:2.5.7

WORKDIR /app
COPY . /app

RUN bundle install

EXPOSE 4567

CMD ["ruby", "app.rb"]
