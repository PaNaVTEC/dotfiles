#!/bin/bash

EXTENSION_ID=$1

wget -d -O $1.crx "https://clients2.google.com/service/update2/crx?response=redirect&prodversion=38.0&x=id%3D$1%26installsource%3Dondemand%26uc"
