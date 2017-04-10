#!/bin/bash
VSCodeCommandPath=`which code`

if [ ! -e $VSCodeCommandPath ]; then
	echo "ERROR: VS Code not installed or not added to PATH!"
	exit
fi

file=$1

if [ -z $file ]; then
	echo "ERROR: Please enter a file to read the extensions from!"
	exit
fi

if [ ! -f $file ]; then
	echo "ERROR: This file does not exist!"
	exit
fi

linesInFile=`cat $file`
linesCharacterCount=${#linesInFile}

if (( linesCharacterCount <= 0 )); then
	echo "ERROR: The selected file is empty!"
	exit
fi

echo "========================="
echo "Installing extensions..."
echo "========================="

for line in $linesInFile ; do
	if [ -z `echo $line | tr -d " \t\n\r"` ]; then
		continue
	fi
	echo "========================="
	echo "Installing $line"
	echo "----------------"
	code --install-extension $line 
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~"
done
