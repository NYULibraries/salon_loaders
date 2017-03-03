# Permalinks Loaders

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
