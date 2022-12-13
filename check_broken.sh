#!/usr/bin/env bash
source config.sh
for file in *
do
  file_date=$(stat -c %y "$file")
  file_date=${file_date:0:19}
  if [[ $file_date > $last_run ]]
    then
      if grep -q "broken" "$file"
        then
          echo "File $file is broken"
      fi
  fi
done
current_datetime=$(date +%Y-%m-%d\ %H:%M:%S)
sed -i "s/last_run=.*/last_run='$current_datetime'/" config.sh