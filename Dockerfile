FROM ruby:2.5.1-alpine

ENV INSTALL_PATH /app
ENV BUILD_PACKAGES ruby-dev build-base git
ENV RUN_PACKAGES curl

RUN addgroup -g 1000 -S docker && \
  adduser -u 1000 -S -G docker docker

WORKDIR $INSTALL_PATH

COPY --chown=docker:docker Gemfile Gemfile.lock ./
RUN apk add --no-cache $BUILD_PACKAGES $RUN_PACKAGES \
  && bundle config --global github.https true \
  && bundle config --global disable_shared_gems true \
  && gem install bundler && bundle install --jobs 20 --retry 5 \
  && apk del $BUILD_PACKAGES \
  && chown -R docker:docker ./ \
  && chown -R docker:docker /usr/local/bundle

COPY --chown=docker:docker . .

USER docker

ENV BUNDLE_PATH /usr/local/bundle

RUN bundle config --global github.https true

CMD scripts/load_json.sh
