# Salon Loaders

[![CircleCI](https://circleci.com/gh/NYULibraries/salon_loaders.svg?style=svg)](https://circleci.com/gh/NYULibraries/salon_loaders)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/salon_loaders/badge.svg)](https://coveralls.io/github/NYULibraries/salon_loaders)

## Usage

### Libguides

Generate JSON from libguides:

```
LIB_GUIDES_CLIENT_ID={CLIENT_ID} LIB_GUIDES_CLIENT_SECRET={SECRET} \
  rake salon_loaders:libguides:json
```

or generate a txt file for automatic loading into redis:

```
rake salon_loaders:libguides:txt
```
