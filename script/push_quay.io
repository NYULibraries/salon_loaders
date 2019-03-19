#!/bin/sh

docker tag salon_loaders quay.io/nyulibraries/salon_loaders:latest
docker tag salon_loaders quay.io/nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}
docker tag salon_loaders quay.io/nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}-${CIRCLE_SHA1}

docker push quay.io/nyulibraries/salon_loaders:latest
docker push quay.io/nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}
docker push quay.io/nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}-${CIRCLE_SHA1}
