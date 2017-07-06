#!/usr/bin/env bash
for file in $(find . -type f -name "*")
do
  sudo sed -i 's/\/opt\/anaconda1anaconda2anaconda3/\/usr/g' $file
  echo "modified $file"
done