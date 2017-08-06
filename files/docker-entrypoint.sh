#!/bin/sh

set -e

# replace environment variables in cpu miner conig
p2 -t /cpuminer-conf.json.j2 > /cpuminer-conf.json

# start the cpu miner
exec /cpuminer