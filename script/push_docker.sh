#!/bin/sh

docker tag salon_loaders nyulibraries/salon_loaders:latest
docker tag salon_loaders nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}
docker tag salon_loaders nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}-${CIRCLE_SHA1}

docker push nyulibraries/salon_loaders:latest
docker push nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}
docker push nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_}-${CIRCLE_SHA1}
