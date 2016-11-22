#!/bin/sh

cd ../src/vlife/
echo "deleting previous data if any\n"
rake db:drop
echo "\ncreating database\n"
rake db:create
echo "\ncreating relations\n"
rake db:migrate
echo "\npopulating database\n"
rake db:populate
echo "\ndone\n"
echo "now run runserver.sh to run server\n"