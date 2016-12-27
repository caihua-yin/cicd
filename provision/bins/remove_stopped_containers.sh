#!/bin/bash
docker ps -a | grep Exited | awk '{print $1}' | while read line; do docker rm -v $line; done
