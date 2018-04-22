#!/usr/bin/env bash

pushd ~ > /dev/null

if [ $1 == "wsl" ]; then
  mkdir -p /mnt/c/home/downloads
  ln -fs /mnt/c/home/downloads
  mkdir -p /mnt/c/home/yph
  ln -fs /mnt/c/home/yph winhome
  cd winhome
fi

git clone git@github.com:yupinghu/config.git

if [ $1 == "wsl" ]; then
  cd ~
  ln -fs winhome/config
fi

popd > /dev/null
