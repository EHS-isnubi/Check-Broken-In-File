#!/usr/bin/env bash
#==========================================================================================
#
# SCRIPT NAME        :     check_broken.sh
#
# AUTHOR             :     Louis GAMBART
# CREATION DATE      :     2023.03.20
# RELEASE            :     3.0.0
# USAGE SYNTAX       :     .\check_broken.sh [-d|--directory] <directory>
#
# SCRIPT DESCRIPTION :     This script is used to check if a file contains the string "broken" in .req files
#
#==========================================================================================
#
#                 - RELEASE NOTES -
# v1.0.0  2022.12.14 - Louis GAMBART - Initial version
# v1.1.0  2022.12.15 - Louis GAMBART - Add check to control only .req files
# v2.0.0  2022.12.16 - Louis GAMBART - Complete change to be more optimized
# v3.0.0  2023.08.29 - Louis GAMBART - Rework to follow my template
# v3.0.1  2023.08.29 - Louis GAMBART - Add option to pass the path to check
#
#==========================================================================================


#####################
#                   #
#  I - COLOR CODES  #
#                   #
#####################

No_Color='\033[0m'      # No Color
Red='\033[0;31m'        # Red
Yellow='\033[0;33m'     # Yellow
Green='\033[0;32m'      # Green
Blue='\033[0;34m'       # Blue



####################
#                  #
#  II - VARIABLES  #
#                  #
####################

SCRIPT_NAME="check_broken.sh"


#####################
#                   #
#  III - FUNCTIONS  #
#                   #
#####################

print_help () {
    # Print help message
    echo -e """
    ${Green} SYNOPSIS
        ${SCRIPT_NAME} [-d|--directory] <directory> [-hv]

     DESCRIPTION
        This script is used to check if a file contains the string \"broken\" in .req files

     OPTIONS
        -d, --directory    Path to the directory to check
        -h, --help         Print the help message
        -v, --version      Print the script version
    ${No_Color}
    """
}


print_version () {
    # Print version message
    echo -e """
    ${Green}
    version       ${SCRIPT_NAME} 3.0.0
    author        Louis GAMBART (https://louis-gambart.fr)
    license       GNU GPLv3.0
    script_id     0
    """
}


check_file () {
    # Check if the file contains the string "broken"
    # $1: path to check

    ls "$1"/*.req > cur.txt
    for file in $(cat cur.txt old.txt | sort -h | uniq -u)
    do
      echo "$file" >> old.txt
      if grep -q "broken" "$file"
        then
          echo "File $file is broken"
      fi
    done
    rm cur.txt
}


#########################
#                       #
#  IV - SCRIPT OPTIONS  #
#                       #
#########################

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -d|--directory)
            DIRECTORY="$2"
            shift
            shift
            ;;
        -h|--help)
            print_help
            exit 0
            ;;
        -v|--version)
            print_version
            exit 0
            ;;
        *)
            echo -e "${Red}ERR - Unknown option: $key${No_Color}"
            print_help
            exit 0
            ;;
    esac
    shift
done


#####################
#                   #
#  V - MAIN SCRIPT  #
#                   #
#####################

echo -e "${Blue}Starting the script...${No_Color}\n"

if [[ -z "$DIRECTORY" ]]; then
    echo -e "${Red}ERR - No directory specified${No_Color}"
    print_help
    exit 1
else
    if [[ "${DIRECTORY: -1}" == "/" ]]; then
        DIRECTORY="${DIRECTORY::-1}"
    fi
    echo -e -n "${Yellow}Checking the directory $DIRECTORY...${No_Color}"
    check_file "$DIRECTORY"
    echo -e "${Green} OK${No_Color}\n"
fi

echo -e "${Blue}...Script finished${No_Color}"