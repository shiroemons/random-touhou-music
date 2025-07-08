FROM ruby:3.4.4-alpine

RUN apk add --upgrade ruby-dev make gcc libc-dev
RUN gem install bundler:2.6.9

WORKDIR /app
COPY . /app

ENV RUBY_YJIT_ENABLE=1

# Accept build argument for environment
ARG RACK_ENV=production

# Install gems based on environment
RUN if [ "$RACK_ENV" = "development" ]; then \
      bundle install; \
    else \
      bundle install --without development; \
    fi

EXPOSE 4567

CMD ["ruby", "app.rb"]
