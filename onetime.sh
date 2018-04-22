#!/usr/bin/env bash

pushd ~ > /dev/null

if [ ! -z $1 ] && [ $1 == "wsl" ]; then
  mkdir -p /mnt/c/home/downloads
  ln -fs /mnt/c/home/downloads
  mkdir -p /mnt/c/home/yph
  ln -fs /mnt/c/home/yph winhome
  ln -fs winhome/config
  cd winhome
fi

if [ ! -d config ]; then
  git clone git@github.com:yupinghu/config.git
fi

popd > /dev/null
