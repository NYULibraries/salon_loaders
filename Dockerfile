FROM ruby:2.5.1-alpine

ENV INSTALL_PATH /app
ENV BUILD_PACKAGES ruby-dev build-base
ENV RUN_PACKAGES curl git

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./
RUN bundle config --global github.https true
RUN apk add --no-cache $BUILD_PACKAGES $RUN_PACKAGES \
  && gem install bundler && bundle install --jobs 20 --retry 5 \
  && apk del $BUILD_PACKAGES

COPY . .

CMD scripts/load_json.sh
