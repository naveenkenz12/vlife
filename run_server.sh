#!/bin/sh

#cd ../src/vlife/
echo "\nsetting up server\n"
export ASSET_HOST="127.0.0.1"
export ASSET_PORT=8080
export SECRET="K3ydjJYHjVbRws5PnbVtwsa25tpBDFw_iNWJ6w=="
export KEY="TICN3MI355BLA9FZDYCY"
echo "\nrunning server on 0.0.0.0:3000"
rails server -b 0.0.0.0