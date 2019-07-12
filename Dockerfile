FROM ruby:2.6.3-alpine

ENV INSTALL_PATH /app
ENV BUILD_PACKAGES ruby-dev build-base git
ENV RUN_PACKAGES curl

RUN addgroup -g 1000 -S docker && \
  adduser -u 1000 -S -G docker docker

WORKDIR $INSTALL_PATH
RUN chown docker:docker .

RUN apk --no-cache --upgrade add --upgrade bzip2=~1.0.6-r7

COPY --chown=docker:docker Gemfile Gemfile.lock ./
RUN apk add --no-cache $BUILD_PACKAGES $RUN_PACKAGES \
  && bundle config --local github.https true \
  && gem install bundler -v '1.16.6' && bundle install --jobs 20 --retry 5 \
  && rm -rf /root/.bundle && rm -rf /root/.gem \
  && rm -rf /usr/local/bundle/cache \
  && apk del $BUILD_PACKAGES \
  && chown -R docker:docker /usr/local/bundle

RUN mkdir coverage && chown docker:docker coverage

USER docker

COPY --chown=docker:docker . .

CMD [ "scripts/load_json.sh" ]
