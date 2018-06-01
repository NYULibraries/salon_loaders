FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential
RUN apt-get install -y redis-tools

COPY Gemfile Gemfile.lock ./
RUN bundle config --global github.https true
RUN gem install bundler -v 1.16.1 && bundle install --jobs 20 --retry 5

COPY . .
