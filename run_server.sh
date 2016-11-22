#!/bin/sh

cd ../src/vlife/
echo "\nsetting up server\n"
export ASSET_HOST="127.0.0.1"
export ASSET_PORT=8080
export SECRET="xxxx"
export KEY="xxxx"
echo "\nrunning server on 0.0.0.0:3000"
rails server -b 0.0.0.0