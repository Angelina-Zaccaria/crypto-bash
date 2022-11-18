#!/bin/bash

# this is a comment

# print something to console
echo "Hello there"

# create a variable - it is important not to put a space before/after =
name="John Smith"

# use variable contents
echo "Hello there, $name"

# output the result of a command to a file instead of printing to console
echo "Hi, $name" > greetings.txt

# output contents of a file to the console
cat greetings.txt

# print file contents to console with additional info - good for debugging
echo "Contents of greetings.txt: $(cat greetings.txt)"

# assign a variable to the result of a command
contents_of_greetings=$(cat greetings.txt)
echo "contents_of_greetings: $contents_of_greetings"

# pipe the results of one command into another
echo "message" | openssl enc -e -aes-128-cbc -k "key" -pbkdf2

# evaluate complex command within echo string
echo "message piped into encryption piped into decryption: $(echo "message" | openssl enc -e -aes-128-cbc -kfile greetings.txt -pbkdf2 | openssl enc -d -aes-128-cbc -kfile greetings.txt -pbkdf2)"

# while loop - don't forget done at the end
while true
do
	# get user input, write to variable
	read -p "Please input a word: " word
	
	# if/then statement - don't forget fi at the end
	if [ "$word" = "cryptography" ]
	then
		echo "The word you entered was cryptography"
		# while loop exits only when the entered word is cryptography
		break
	else
		echo "The word you entered was not cryptography"
	fi
done

# create and iterate through list - it is important not to put a space before/after =, must have spaces before/after each item
item_list=( "item1" "item2" "item3" )
for item in "${item_list[@]}"
do
	echo $item
done

# use netcat to create client/server connections
# -l means this is the listening socket waiting for a connection - must be created before the connecting socket
# -N means the network socket shuts down after EOF (end of file) on the input. If you just run nc -N localhost 1234 in the second terminal window, then anything you type in the terminal will be shown on the listening socket until you kill the connecting socket with Ctrl + c
# 1234 is the port number on localhost, you can pick any port number not in use
echo 'Open another terminal window and run this command: echo "whatever you want to write" | nc -N localhost 1234'
# the message `Connection successful` is sent to the terminal that connects to the listening socket
echo "Connection successful" | nc -l -N 1234

# to run this bash script, run this command in the terminal: ./bash-basics.sh

# if you get a permission denied error, run this command: chmod +x bash-basics.sh

# use Ctrl + c to kill a bash script

# to find out more about a command and any flags it might use, type `man insert_command_here` into the terminal, and you can exit by entering q

