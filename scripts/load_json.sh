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
  $SALON_LOAD_URL
unset TOKEN
