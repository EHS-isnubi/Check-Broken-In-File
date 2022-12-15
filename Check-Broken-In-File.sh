#!/usr/bin/env bash
#==========================================================================================
#
# SCRIPT NAME        :     Check-Broken-In-File.sh
#
# AUTHOR             :     Louis GAMBART
# CREATION DATE      :     2022.12.14
# RELEASE            :     v1.0.0
# USAGE SYNTAX       :     .\Check-Broken-In-File.sh
#
# SCRIPT DESCRIPTION :     This script is used to check if a file contains the string "broken" in .req files
#
#==========================================================================================
#
#                 - RELEASE NOTES -
# v1.0.0  2022.12.14 - Louis GAMBART - Initial version
# v1.1.0  2022.12.15 - Louis GAMBART - Add check to control only .req files
#
#==========================================================================================
source config.sh
for file in *
do
  file_date=$(stat -c %y "$file")
  file_date=${file_date:0:19}
  if [[ $file_date > $last_run ]] && [[ $file == *.req ]]
    then
      if grep -q "broken" "$file"
        then
          echo "File $file is broken"
      fi
  fi
done
current_datetime=$(date +%Y-%m-%d\ %H:%M:%S)
sed -i "s/last_run=.*/last_run='$current_datetime'/" config.sh