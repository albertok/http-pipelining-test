#!/bin/bash

PORT=$1
NUM_PARALLEL=$2
NUM_REPS=$3

worker() {
  ID=$1
  echo starting $ID
  for ((I=0; $I < $NUM_REPS; I=$I+1)); do
    nc 127.0.0.1 -q 10 $PORT < test_requests.txt > /dev/null
  done
  echo exiting $ID
}

for ((I=0; $I < $NUM_PARALLEL; I=$I+1)); do
  worker $I &
done

time wait
