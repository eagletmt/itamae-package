#!/bin/bash -xe

for x in xenial bionic focal jammy noble resolute buster bookworm; do
  ./build.sh ${x}
done
