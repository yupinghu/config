# config
yph's dotfiles and new machine setup scripts

## Basic info

Clone this to `~/config` and run `setup.sh <platform>`, where `<platform>` is
either `osx` or `ubuntu`.

This script is smart enough to skip steps that appear to already have been
performed so it's safe to run multiple times (e.g. to apply new settings after
the script has been changed).

If you have machine-specific stuff to add to your environment, put it in
`env-more.sh` in this directory.

You might ask: if this script is supposed to set up a fresh machine, how do I
clone without git? To which I say, shut up and get git first. :)
