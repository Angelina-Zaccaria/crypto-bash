# Part 5: Hash Functions
Students learn how to perform hashing, generate message authentication codes, and generate pseudorandom bytes using command line OpenSSL.

## Hash Functions
Hash functions are one-way transformations that produce randomized output strings of the same length, no matter how long the input is. Hashes are useful for many tasks such as performing message authentication and storing passwords. 

From the terminal, you can perform hashing, digital signatures, and verification using the `openssl dgst` command. We will briefly demonstrate how to hash a file using this tool. For a full list of the available hash algorithms and operations, you can read the command description using `man dgst`.

Switch to the `part5` directory (`cd ../../part5`).

The example below performs a hash using SHA512. 
```
$ echo "This is the sample text" > plaintext.txt 
$ openssl dgst -sha512 plaintext.txt 
SHA512(plaintext.txt)= 
1fb205ad281bfdc3a71377964afd9db2094f718f894102576bc5e2a9350c880a32c01d7c dd7c4e89f3f4b7f68852fb52b0d644b092f99a82f72e17ad3f47d65b 
```
The output is the message digest in hexadecimal (not Base64 encoding). You can also print the output in binary form or colon-separated hex. To save the output to a file, include the `-out` filename option.

## Message Authentication Codes
You can use the `openssl dgst` command to perform Message Authentication Code (MAC) operations as well. A message authentication code (also known as a tag) is used to confirm that the message came from a given sender and has not been modified in transit. The sender of the message sends both the message and the tag, which is encrypted with a shared secret key. If the sender does not know the secret key, the hash value is different and the message is not successfully authenticated.

The example below generates a tag using HMAC (hash-based message authentication code). 
```
$ openssl dgst -sha256 -hmac "My secret key" plaintext.txt
HMAC-SHA256(plaintext.txt)= 4494a151fffad44ce7b96975790d71eb8ce87883e52da1c4cce14d42d0112791
```

You can also do this with the `mac` function, which is new in OpenSSL 3.0. You can see that the computed tags are the same:
```
$ openssl mac -digest SHA256 -macopt key:"My secret key" -in plaintext.txt HMAC
4494A151FFFAD44CE7B96975790D71EB8CE87883E52DA1C4CCE14D42D0112791
```

MAC operations are different from digital signatures - MAC values are generated and verified using the same secret key, whereas digital signatures are generated with the sender's private key and verified with the sender's public key.

The shared key used here or in any symmetric algorithm could be a passphrase, or the combination of the sender’s private key and recipient’s public key or sender’s public key and recipient’s private key, both of which would form the same shared key. This is called a Diffie-Hellman key exchange, and a demonstration of this in command line OpenSSL can be found [here](https://sandilands.info/sgordon/diffie-hellman-secret-key-exchange-with-openssl).

## Pseudorandom Number Generation
Pseudorandom number generation is very important to consider when attempting to create cryptographically secure systems. OpenSSL has a built-in cryptographically-secure pseudorandom number generator (CSPRNG), which can be accessed from the terminal using `openssl rand`. This command takes an argument `num` that specifies how many pseudorandom bytes to produce, and the generator is seeded using the Linux files `$HOME/.rnd` or `.rnd` in addition to any files passed in using the `-rand` option.
```
$ openssl rand -out num.txt -hex 32 
$ cat num.txt 
bb7d44caf4c90362957f500b9302fd4a471f043f46994997418673a1d3805407 
```
Note that the command tries to write a new `$HOME/.rnd` or `.rnd` file if it obtains enough seeding, but this is not always the case. The default output for `openssl rand` will be in binary, but you can also convert it to Base64 or hex encoding using the option flags. 

You can learn more about CSPRNGs and how they work [here](https://realpython.com/python-random/#csprngs-in-python). This resource thoroughly explains the pros and cons of different options for randomly generating data in Python.

## → [Part 6: Exercise 2: Authentication Server](../part6/part6.md)
