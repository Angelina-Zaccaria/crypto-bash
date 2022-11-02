# Part 4: Bash Basics & Exercise 1: Key Exchange
Students learn bash scripting basics and apply the cryptography techniques used in parts 2 and 3 to write client and server bash scripts that perform a key exchange.

## Bash Basics

Bash scripting is very useful for executing a series of commands without having to type them into the terminal, as shown in the script used in Part 3. The way I see it, bash is kind of like Python but a little weirder, and once you understand the syntax you can do pretty much anything.

You can open the file `bash-basics.sh` in a text exitor (ex. gedit, nano, or vim) using a command such as `gedit bash-basics.sh` from within the `part4` directory and follow along there as well. 

Quick sidebar on text editor options:
* **gedit** - most user-friendly code editor, opens a separate window
* **nano** - simple editor within the Terminal
* **vim** - less user-friendly editor within the Terminal, useful to know

Bash files have the file extension `.sh` and start with `#!/bin/bash`
```bash
#!/bin/bash

# this is a comment

# print something to console
echo "Hello there"

# create a variable
name="John Smith"

# use variable contents
echo "Hello there, $name"

# output the result of a command to a file instead of printing to console
echo "Hi, $name" > greetings.txt

# output contents of a file to the console
cat greetings.txt

# assign a variable to the result of a command
contents_of_greetings=$(cat greetings.txt)
echo "contents_of_greetings: $contents_of_greetings"

# create and iterate through list - it is important not to put a space before/after =
item_list=( "item1" "item2" "item3" )
for item in "${item_list[@]}"
do
	echo $item
done

# while loop
while true; do
	# get user input
	read -p "Please input a word: " word
	
	# if/then statement
	if [ "$word" = "cryptography" ]
	then
		echo "The word you entered was cryptography"
		# while loop exits only when the entered word is cryptography
		break
	else
		echo "The word you entered was not cryptography"
	fi
done

# pipe the results of one command into another
echo "message" | openssl enc -e -aes-128-cbc -k "key" -pbkdf2

# evaluate command within echo string
echo "message piped into encryption piped into decryption: $(echo "message" | openssl enc -e -aes-128-cbc -kfile greetings.txt -pbkdf2 | openssl enc -d -aes-128-cbc -kfile greetings.txt -pbkdf2)"
```
### Creating client/server connections
Use `netcat` to create client/server connections. Open up two terminal windows side by side.

Run the following command on your "server" side:
```bash
echo "Connection successful" | nc -l -N 1234
```
* `-l` means this is the listening socket/server side waiting for a connection  
* `1234` is the port number on localhost - you can pick any port number not in use  
* `-N` means the network socket shuts down after EOF (end of file) on the input. You'll want to use this flag thoughout this exercise.

In your second terminal window (connecting socket/"client" side), run the following command:
```bash
nc -N localhost 1234
```
Now anything you type in the client-side terminal will be shown on the listening socket until you kill the connecting socket with `Ctrl + c`.
If you want the client to send a message to the server upon connection, your client-side command could look like this instead:
```bash
echo "greetings" | nc -N localhost 1234
```

### Running bash scripts
* To run this bash script, run this command in the terminal: `./bash-basics.sh`  
* If you get a permission denied error, run this command: `chmod +x bash-basics.sh`  
* Use `Ctrl + c` to kill a bash script

To find out more about a command and any flags it might use, type `man insert_command_here` into the terminal, and you can exit by entering `q`

## Exercise 1: Client/Server Key Exchange
In this exercise, you will be writing two bash scripts that perform a key exchange. The first script will create a client that connects to a server and sends a symmetric key that has been encrypted with the server’s public key. The second script creates the server, which will receive the message from the client, decrypt the data using its private key, and then send a new message to the client that is encrypted using the symmetric key it received. The client should be able to successfully decrypt the new message sent by the server. Use RSA as the public key algorithm, but the choice of symmetric key algorithm is up to you. You can hard code the symmetric key or generate it with `openssl rand -base64 128`.

You can use OpenSSL terminal commands for the cryptographic functions, such as the symmetric algorithms discussed in [Part 2](../part2.md) and the asymmetric/public key algorithms discussed in [Part 3](../part3/part3.md). All the background knowledge you will need for this exercise has already been discussed. 

Start with the skeleton code with comments explaining what you should be doing where in `client-side/client.sh` and `server-side/server.sh`. Any files you generate will then be kept in the two separate directories.

## → [Part 5: Hash Functions](../part5/part5.md)
