#!/bin/sh

find ../LIBS/ -printf "%P\n" | tar -czf ../data.tgz  --no-recursion -C ../LIBS/ -T -
