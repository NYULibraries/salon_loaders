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
LIB_GUIDES_CLIENT_ID={CLIENT_ID} LIB_GUIDES_CLIENT_SECRET={SECRET} \
  rake salon_loaders:libguides:txt
```

#### Debugging

Spit out some debugging info to find out why some records aren't being loaded properly:

```
DEBUG=1 LIB_GUIDES_CLIENT_ID={CLIENT_ID} LIB_GUIDES_CLIENT_SECRET={SECRET} \
  rake salon_loaders:libguides:json
```

Output:

```
I, [2018-04-09T12:48:54.303421 #9284]  INFO -- : Could not load resource: LibGuides ID: XX01; LibGuides URL: https://persistent.inst.edu/ID; LibGuides library review: lib review test
I, [2018-04-09T12:48:54.303694 #9284]  INFO -- : 1000 permalinks created
I, [2018-04-09T12:48:54.304589 #9284]  INFO -- : 1 resources unreadable
```
