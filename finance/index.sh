#!/usr/bin/env bash

currencyConvert() {
  curl -s "https://finance.google.com/finance/converter?a=$1&from=$2&to=$3" | sed '/res/!d;s/<[^>]*>//g'
}

currencyConvertPorcelain() {
  currencyConvert "$1" "$2" "$3" | awk -F'=' '{print $2}'
}

gbpToEur() {
  currencyConvert 1 'GBP' 'EUR'
}

gbpToUsd() {
  currencyConvert 1 'GBP' 'USD'
}
