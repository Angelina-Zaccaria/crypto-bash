#!/bin/bash

echo "Server has been started"

# 1: generate private and public keys, write to files, print file contents


# 2a: send server public key to client when the client connects to listening socket


# 5b: receive encrypted symmetric key from client, save to file, print file contents


# 6: decrypt encrypted symmetric key using server private key, output to file, print file contents


# while loop to send messages to client


	# 7: input message to send to client, save to variable


	# 8: pipe contents of message variable into command to encrypt with symmetric key (-base64), save result of this command to variable, print variable contents
	
  
	# 9a: send contents of encrypted message variable to client


	# 11b: server-side exit sequence - delete files and exit the loop if message is "cease and desist"

