# Salon Loaders

[![CircleCI](https://circleci.com/gh/NYULibraries/salon_loaders.svg?style=svg)](https://circleci.com/gh/NYULibraries/salon_loaders)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/salon_loaders/badge.svg)](https://coveralls.io/github/NYULibraries/salon_loaders)

## Usage

Generate JSON from libguides:

```
rake salon_loaders:libguides:json
```

or generate a txt file for automatic loading into redis:

```
rake salon_loaders:libguides:txt
```

The same tasks are available for Xerxes:

```
rake salon_loaders:xerxes:json
rake salon_loaders:xerxes:txt
```

You can also interact with the permalink abstractions directly:

```
xerxes_permalinks = SalonLoaders::Sources::Xerxes.new
xerxes_permalinks.each do |permalink|
  p permalink.key
  p permalink.url
end
```
