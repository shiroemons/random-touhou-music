FROM ruby:3.1.2

WORKDIR /app

COPY . /app

RUN bundle install

EXPOSE 4567

CMD ["ruby", "app.rb", "-o", "0.0.0.0"]