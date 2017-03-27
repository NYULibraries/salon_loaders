# Permalinks Loaders

[![CircleCI](https://circleci.com/gh/NYULibraries/permalinks_loaders.svg?style=svg)](https://circleci.com/gh/NYULibraries/permalinks_loaders)
[![Coverage Status](https://coveralls.io/repos/github/NYULibraries/permalinks_loaders/badge.svg)](https://coveralls.io/github/NYULibraries/permalinks_loaders)

```
xerxes_permalinks = PermalinksLoaders::Sources::Xerxes.new
xerxes_permalinks.each do |permalink|
  p permalink.key
  p permalink.url
end
```

```
# rake permalinks_loaders:convert:xerxes => xerxes.txt
set NYU12345 http://jstor.org
set NYU22345 https://ezproxy.library.nyu.edu/login?url=http://proquest.com
```
