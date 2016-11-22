#!/bin/sh

#cd ../src/vlife/
echo "\nsetting up server\n"
export ASSET_HOST="192.168.0.113"
export ASSET_PORT="8080"
export ASSET_SECRET="K3ydjJYHjVbRws5PnbVtwsa25tpBDFw_iNWJ6w=="
export ASSET_KEY="TICN3MI355BLA9FZDYCY"
echo "\nrunning server on 0.0.0.0:3000"
rails server -b 0.0.0.0