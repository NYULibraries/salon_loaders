#!/bin/sh -ex

docker pull nyulibraries/salon_loaders:${CIRCLE_BRANCH//\//_} || docker pull nyulibraries/salon_loaders:latest
