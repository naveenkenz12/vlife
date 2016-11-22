#!/bin/sh

cd ../src/vlife/
echo "creating database\n"
rake db:create
echo "\ncreating relations\n"
rake db:migrate
echo "\npopulating database\n"
rake db:populate
echo "\ndone\n"
echo "now run runserver.sh to run server\n"