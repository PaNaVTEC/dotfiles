awsSSOExpired () {
  URL=$(aws configure get sso_start_url)
  if [ "$URL" == "" ]; then
    echo "AWS_NOT_CONFIGURED"
    exit 0
  fi

  CACHE=$(find ~/.aws/sso/cache -type f -exec grep -q "$URL" {} \; -print)
  if [ "$CACHE" == "" ]; then
    echo "AWS_NOT_LOGGED"
    exit 0
  fi

  EXPIRES=$(date +%s --date=$(jq -r '.expiresAt // empty' $CACHE))
  if [ "$(date +%s)" -ge "$EXPIRES" ]; then
    echo "AWS_NOT_LOGGED"
    exit 0
  fi

  echo "AWS_LOGGED"
}
