#!/bin/bash

## VIASH START
par_mode='value'
par_duration='20'
par_disk_size='100MB'
par_memory_size='100MB'
par_output='stress.out'
## VIASH END

if [[ "$par_mode" == "memory" ]]; then
  echo "Memory stress test"
  stress-ng --class memory --all 1
elif [[ "$par_mode" == "time" ]]; then
  echo "Time stress test"
  stress-ng --matrix 1 -t 1m
elif [[ "$par_mode" == "disk" ]]; then
  echo "Disk stress test"
  dd if=/dev/zero of=$par_output bs=$par_disk_size count=1
else
  echo "Unknown stress test"
  exit 1
fi
