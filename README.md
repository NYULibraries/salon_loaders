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

### Xerxes <span style="color:red">_Deprecated_</span>

The same tasks are available for Xerxes, but this is discouraged method since the Xerxes IDs now live in the Libguides:

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

This relies on the `config/databases.yml` pointing to the credentials for the actual database. In this repos, the jobs assume a local database with the Xerxes production data loaded in.
