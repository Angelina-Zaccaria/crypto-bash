#!/bin/bash

read -p "To run each command for Part 3, hit ENTER"

OLDIFS="$IFS"
IFS=$'\n'

commands=()
while IFS= read -r line; do commands+=($line); done < commands.txt

for command in "${commands[@]}"
do
	read -p "$ $command"
	eval "$command"
done
IFS="$OLDIFS"

