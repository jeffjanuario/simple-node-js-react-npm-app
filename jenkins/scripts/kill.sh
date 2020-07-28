#!/usr/bin/env sh

echo 'The following command terminates the "npm start" process using its PID'
echo '(written to ".pidfile"), all of which were conducted when "deliver.sh"'
echo 'was executed.'
set -x
kill ps | grep 'node' | head -n 1 | awk '{print $1}'
#kill $(cat .pidfile)
