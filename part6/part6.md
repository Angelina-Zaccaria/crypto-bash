# Part 6: Exercise 2: Authentication Server
Students apply the knowledge from previous labs to implement a message authentication scenario for secure communications.

## Exercise 2: Message Authentication in a Client/Server Architecture

Write a pair of client/server programs that implements the message authentication scenario outlined in the diagram on the following page. Just as in Lab 7, you can use either bash scripting or C/C++ to develop your solution. See bash-basics.sh and Lab 8 for the background knowledge you will need to write a bash script for this exercise.

The client program (Alice) hashes a shared secret value s with some message x and sends the message with the appended hash to the server (Bob). The server program should take x and perform its own hash of s and x, then compare it to the hash value sent by the client. If the two match, the server should report a message of success. Note that we assume both parties already know s, so there’s no need to do a shared secret exchange. 

Perform this message authentication scenario 3 times using the three hash functions MD5, RipeMD160, and SHA256. If you take the approach of using C, this means you will initialize an EVP_MD_CTX three times by calling EVP_md5(), EVP_ripemd160(), and EVP_sha256(). 

Have each program print output to the screen for each step in the exchange
Use the following sample values in your submission:

x = "The meeting will be next Wednesday at 2 p.m."
s = "145exchange"
