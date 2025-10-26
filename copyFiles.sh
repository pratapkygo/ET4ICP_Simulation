#!/bin/sh

# ET4ICP - Copy Directory Script
# Copies relevant files and directories into ${USER} home space

SRC_DIR1="${PWD}/ET4ICP_BICMOS5/"
SRC_DIR2="${PWD}/implant/"

DIR1="${STDB}/ET4ICP_BICMOS5/"
DIR2="${HOME}/implant"

if [ -d "$DIR1" ]; then
	echo "		${DIR1} exists"
	read -p "		Overwrite? (y/n): " choice
	case "$choice" in
		y|Y )
			echo "		Overwriting ${SRC_DIR1} to ${DIR1} ..."
			rm -rf ${DIR1}
			cp -r ${SRC_DIR1} ${DIR1}
			;;
		n|N )
			;;
		* )
			echo "		Invalid Choice"
			echo ""
			;;
	esac
else
	echo "		${DIR1} does not exist. Creating ..."
	cp -r ${SRC_DIR1} ${DIR1}
fi

if [ -d "$DIR2" ]; then
	echo "		${DIR2} exists"
	read -p "		Overwrite? (y/n): " choice
	case "$choice" in
		y|Y )
			echo "		Overwriting ${SRC_DIR2} to ${DIR2} ..."
			rm -rf ${DIR2}
			cp -r ${SRC_DIR2} ${DIR2}
			;;
		n|N )
			;;
		* )
			echo "		Invalid Choice"
			echo ""
			;;
	esac
else
	echo "		${DIR2} does not exist. Creating ..."
	cp -r ${SRC_DIR2} ${DIR2}
fi
