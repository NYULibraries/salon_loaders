# /bin/bash
rake salon_loaders:libguides:json
export TOKEN=`curl -s -X POST \
  -d grant_type=client_credentials \
  -d client_id=$SALON_CLIENT_ID \
  -d client_secret=$SALON_CLIENT_SECRET \
  -d scope=admin \
  https://dev.login.library.nyu.edu/oauth/token \
  | sed 's/.*"access_token": *"\([^"]*\)".*}/\1/g'`
curl -H "Content-Type: application/json" \
  -H "Authorization: Bearer $TOKEN" \
  -X POST \
  --data-binary "@libguides.json" \
  https://persistent-dev.library.nyu.edu/reset_with_array
unset TOKEN

rake salon_loaders:libguides:json
export TOKEN=`curl -s -X POST \
  -d grant_type=client_credentials \
  -d client_id=$SALON_CLIENT_ID \
  -d client_secret=$SALON_CLIENT_SECRET \
  -d scope=admin \
  $SALON_LOGIN_TOKEN_URL \
  | sed 's/.*\"access_token\": *\"\\([^\"]*\\)\".*}/\\1/g'`
curl -H \"Content-Type: application/json\" \
  -H \"Authorization: Bearer $TOKEN\" \
  -X POST \
  --data \"@libguides.json\" \
  $SALON_HOST/arch/reset_with_array
unset TOKEN
