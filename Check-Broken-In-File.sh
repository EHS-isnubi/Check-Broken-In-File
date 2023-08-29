#!/usr/bin/env bash
#==========================================================================================
#
# SCRIPT NAME        :     Check-Broken-In-File.sh
#
# AUTHOR             :     Louis GAMBART
# CREATION DATE      :     2022.12.14
# RELEASE            :     v2.0.0
# USAGE SYNTAX       :     .\Check-Broken-In-File.sh
#
# SCRIPT DESCRIPTION :     This script is used to check if a file contains the string "broken" in .req files
#
#==========================================================================================
#
#                 - RELEASE NOTES -
# v1.0.0  2022.12.14 - Louis GAMBART - Initial version
# v1.1.0  2022.12.15 - Louis GAMBART - Add check to control only .req files
# v2.0.0  2022.12.16 - Louis GAMBART - Complete change to be more optimized
#
#==========================================================================================

ls ./*.req > cur.txt
for file in $(cat cur.txt old.txt | sort -h | uniq -u)
do
  echo "$file" >> old.txt
  if grep -q "broken" "$file"
    then
      echo "File $file is broken"
  fi
done
rm cur.txt