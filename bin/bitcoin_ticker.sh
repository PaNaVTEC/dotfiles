gdaxTicker () {
  local res
  res=$(curl -s "https://api.gdax.com/products/BTC-$1/ticker")
  jq -r .ask <<< "$res"
}

krakenTicker () {
  local res
  res=$(curl -s "https://api.kraken.com/0/public/Ticker?pair=XXBTZ$1")
  jq -r ".result.XXBTZ$1.c[0]" <<< "$res"
}

printf "%.2f € | $ %.2f" "$(gdaxTicker EUR)" "$(gdaxTicker USD)"
