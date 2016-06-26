#!/bin/bash
#
# Separate (camera) images on directory
# to year named folders.
#
# All files must be named as "yyyy-mm-dd HH:MM:SS.jpg"
#
shopt -s nullglob
for img in *.{jpg,jpeg,png}; do
  year=${img:0:4}
  mkdir -p "$year"
  mv -iv "$img" "$year/"
done

