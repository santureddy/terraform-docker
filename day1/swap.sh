#!/bin/bash
set -eux
a=10
b=20

a=$((a+b)) 
b=$((a-b))
a=$((a-b))

echo "values are a=${a} b=${b}"