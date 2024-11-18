FROM ruby:3.2.6-alpine

ENV INSTALL_PATH /app
ENV BUILD_PACKAGES ruby-dev build-base git
ENV RUN_PACKAGES curl

RUN addgroup -g 1000 -S docker && \
  adduser -u 1000 -S -G docker docker

WORKDIR $INSTALL_PATH
RUN chown docker:docker .

COPY --chown=docker:docker Gemfile Gemfile.lock ./
RUN apk add --no-cache $BUILD_PACKAGES $RUN_PACKAGES \
  && bundle config --local github.https true \
  && gem install bundler -v '2.5.23' && bundle install --jobs 20 --retry 5 \
  && rm -rf /root/.bundle && rm -rf /root/.gem \
  && rm -rf /usr/local/bundle/cache \
  && chown -R docker:docker /usr/local/bundle

RUN mkdir coverage && chown docker:docker coverage

USER docker

COPY --chown=docker:docker . .

CMD [ "script/load_json.sh" ]
