# Part 2: Symmetric Cryptography
Students become familiar with the command line tool in the OpenSSL toolkit. This part is a walk through of the terminal commands for encryption and decryption using symmetric algorithms.

## Symmetric Cryptography
Symmetric cryptography uses the same key or shared secret between two parties to send and receive messages. This requires that both parties and no one else has access to the symmetric key, which requires a secure method of key exchange (discussed in Part 3).

## Basics
Open the terminal and enter the course files directory using the command `cd crypto-bash` and then create a new directory for this lab using the command `mkdir part2`. Enter the new directory by using the command `cd part2`.

Type the command `openssl help`. You will be shown a list of standard commands and the supported ciphers, as shown below. 
```
$ openssl help
Standard commands 
asn1parse         ca                ciphers           cms               
crl               crl2pkcs7         dgst              dhparam           
dsa               dsaparam          ec                ecparam           
enc               engine            errstr            gendsa            
genpkey           genrsa            help              list              
nseq              ocsp              passwd            pkcs12            
pkcs7             pkcs8             pkey              pkeyparam         
pkeyutl           prime             rand              rehash            
req               rsa               rsautl            s_client          
s_server          s_time            sess_id           smime             
speed             spkac             srp               storeutl          
ts                verify            version           x509     
Message Digest commands (see the `dgst' command for more details) 
blake2b512        blake2s256        gost              md4               
md5               rmd160            sha1              sha224            
sha256            sha3-224          sha3-256          sha3-384          
sha3-512          sha384            sha512            sha512-224        
sha512-256        shake128          shake256          sm3  
Cipher commands (see the `enc' command for more details) 
aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb       
aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb      
aria-128-cfb1     aria-128-cfb8     aria-128-ctr      aria-128-ecb      
aria-128-ofb      aria-192-cbc      aria-192-cfb      aria-192-cfb1     
aria-192-cfb8     aria-192-ctr      aria-192-ecb      aria-192-ofb      
aria-256-cbc      aria-256-cfb      aria-256-cfb1     aria-256-cfb8     
aria-256-ctr      aria-256-ecb      aria-256-ofb      base64            
bf                bf-cbc            bf-cfb            bf-ecb            
bf-ofb            camellia-128-cbc  camellia-128-ecb  camellia-192-cbc  
camellia-192-ecb  camellia-256-cbc  camellia-256-ecb  cast              
cast-cbc          cast5-cbc         cast5-cfb         cast5-ecb         
cast5-ofb         des               des-cbc           des-cfb           
des-ecb           des-ede           des-ede-cbc       des-ede-cfb       
des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb      
des-ede3-ofb      des-ofb           des3              desx              
rc2               rc2-40-cbc        rc2-64-cbc        rc2-cbc           
rc2-cfb           rc2-ecb           rc2-ofb           rc4               
rc4-40            seed              seed-cbc          seed-cfb          
seed-ecb          seed-ofb          sm4-cbc           sm4-cfb           
sm4-ctr           sm4-ecb           sm4-ofb  
```
The available commands may differ depending on what version of OpenSSL you are using. For more details about each command, you can use `man openssl`.

Now we will encrypt and decrypt a file using the symmetric cipher algorithm AES from the terminal. First, create a new text file and print the contents to the console. 
```
$ echo "Hello World." > plaintext.txt
$ cat plaintext.txt 
Hello World. 
$ 
```

## Encryption
Next, we use the OpenSSL command `enc`. For a full list of available options and ciphers, you can type `openssl enc -help`.
```
$ openssl enc -help 
Usage: enc [options]
Valid options are:
 -help               Display this summary
 -list               List ciphers
 -ciphers            Alias for -list
 -in infile          Input file
 -out outfile        Output file
 -pass val           Passphrase source
 -e                  Encrypt
 -d                  Decrypt
 -p                  Print the iv/key
 -P                  Print the iv/key and exit
 -v                  Verbose output
 -nopad              Disable standard block padding
 -salt               Use salt in the KDF (default)
 -nosalt             Do not use salt in the KDF
 -debug              Print debug info
 -a                  Base64 encode/decode, depending on encryption flag
 -base64             Same as option -a
 -A                  Used with -[base64|a] to specify base64 buffer as a single line
 -bufsize val        Buffer size
 -k val              Passphrase
 -kfile infile       Read passphrase from file
 -K val              Raw key, in hex
 -S val              Salt, in hex
 -iv val             IV in hex
 -md val             Use specified digest to create a key from the passphrase
 -iter +int          Specify the iteration count and force use of PBKDF2
 -pbkdf2             Use password-based key derivation function 2
 -none               Don't encrypt
 -*                  Any supported cipher
 -rand val           Load the file(s) into the random number generator
 -writerand outfile  Write random data to the specified file
 -engine val         Use engine, possibly a hardware device
```
In order to perform encryption, we need to use the `-e` option flag. The cipher will be `-aes-128-cbc`, the password-based key derivation function is defined using `-pbkdf2`, and the key will be given by `-k` followed by a passphrase (or `-kfile` followed by the key file name). Finally, we want to specify our input and output files with the `-in` and `-out` options. 
```
$ openssl enc -e -aes-128-cbc -pbkdf2 -k "This is my key" -in plaintext.txt -out ciphertext.bin
$ cat ciphertext.bin 
Salted__-t0N&�䥉Rh���/
$ 
```
When you print the resulting binary output to the screen, it is mostly gibberish, except for the notice that the encryption was salted. Note that salting is the default here. A salt value is generated at random (or you can specify one using `-S val`), the salt is then appended to the plaintext password, and then the result is hashed. We can use the option `-nosalt` to encrypt without a salt value. The purpose of the salt is to prevent attacks that use precomputed hash tables, such as dictionary attacks and rainbow tables, so this option should not be used outside of testing purposes. 

We can encode the encrypted data into human-readable text with Base64 encoding, which produces alphanumeric characters and some punctuation characters. Perform the encryption again, using the `-nosalt` and `-base64` options. Please note that the file extensions (.txt, .bin, .base64, .dec) don't really matter in Linux so don't worry about file types in this case.
```
$ openssl enc -e -aes-128-cbc -pbkdf2 -nosalt -k "Unsalted key" -in plaintext.txt -out ciphertext.base64 -base64 
$ cat ciphertext.base64 
Mkf/bQh0LcG57i7e6lZEhg== 
```
The content of our encrypted file is now legible. 

## Decryption
To decrypt the file, we use the `-d` option instead and change the input and output filenames.  
```
$ openssl enc -d -aes-128-cbc -pbkdf2 -nosalt -k "Unsalted key" -in ciphertext.base64 -out plaintext.dec -base64 
$ cat plaintext.dec 
Hello World. 
$ 
```
The message is successfully decrypted. Now, try again but change the key or the cipher mode and see what happens. 

## → [Part 3: Asymmetric (Public Key) Cryptography](part3/part3.md)
