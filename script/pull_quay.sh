#!/bin/sh -ex

docker pull quay.io/nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_} || quay.io/docker pull nyulibraries/salon_loaders:latest
