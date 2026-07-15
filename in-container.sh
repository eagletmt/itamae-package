#!/bin/bash -xe
if id -un ${BUILDBOT_UID:-1999} > /dev/null 2>&1; then
  userdel $(id -un ${BUILDBOT_UID:-1999})
fi
useradd -u ${BUILDBOT_UID:-1999} -m buildbot
chown buildbot:buildbot /home/buildbot

mkdir -p /build/itamae
tar xf /work/source.tar* -C /build/itamae

if [ ! -e /work/out ]; then
  mkdir -p /work/out
  chown -R buildbot:buildbot /work/out
fi

cd /build/itamae
./prepare.sh
chown -R buildbot:buildbot /build
su buildbot -c 'bash -xe ./build.sh'
chown ${BUILDBOT_UID:-1999}:${BUILDBOT_GID:-1999} /work/out/*
