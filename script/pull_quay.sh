#!/bin/bash -ex

docker pull quay.io/nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_} || docker pull quay.io/nyulibraries/salon_loaders:latest
