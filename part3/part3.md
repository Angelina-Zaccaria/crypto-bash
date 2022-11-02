# Part 3: Asymmetric (Public Key) Cryptography
Students learn how to generate private and public keys for asymmetric encryption using command line OpenSSL and practice performing encryption and decryption with these keys.

## Asymmetric Cryptography
Asymmetric cryptography, also commonly referred to as public key cryptography, is extremely useful because it solves the key distribution issues common in symmetric cryptography and and can provide authentication through digital signatures. Each person creates a key pair, which is composed of a private key (which you cannot share ever) and a public key (which can be shared with anyone). 

Here are a few use cases of public key cryptography:
* If Alice wants to send a message to Bob that only Bob can read, she can encrypt her plaintext message using Bob's public key. Only Bob can decrypt this message using his private key. When Bob responds to Alice, he encrypts his message using Alice's public key. Now only Alice can then decrypt this message with her own private key.
* Bob can send a message to Alice and create a digital signature by encrypting the message using his private key. Bob sends both the message and the digital signature to Alice, who can decrypt this signature using Bob's private key to verify that the message is indeed from Bob and was not modified in transit.

Symmetric encryption algorithms are faster and require less resources than asymmetric algorithms and are therefore better for encrypting large amounts of data quickly. As a result, asymmetric cryptography is often used to conduct a secure key exchange for later use with symmetric algorithms. 

## Public Key Cryptography in Command Line OpenSSL 
There are four main commands in OpenSSL that handle public key cryptography:
* **genpkey** – Generate a private key or parameters to use for key creation 
* **pkey** – View details about public & private keys and convert them between different encoding formats 
* **pkeyutl** – Perform operations (encrypt, sign, verify, etc) for a supported public key algorithm
* **pkeyparam** – like pkey, but for parameter files (we won't be using this one)

## Key Generation
To start, we will learn how to generate a new RSA private key and derive the public key information from it. Go to the `part3` directory by running `cd ..` to go up a level and then `cd part3`.  

You can type in or copy/paste to run the following commands, or run `./part3.sh` to pre-populate these commands so you just have to hit `Enter`. Execute `chmod +x part3.sh` if you get a permission denied error to add execute permissions on the bash script for your user account, then try running it again.

```
$ openssl genpkey -algorithm RSA -out private.pem 
.....++++++ 
.....................++++++
$ cat private.pem 
-----BEGIN PRIVATE KEY----- 
MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAM9s+vlrKUEysUdd 
DhIwXIJFV/gn7ZeJxIMlAOUWF2NJ8aEk3f/QPPxFQoHO/9nPWPVIrSnqwKZej3cH 
... 
j6XDJR4ibv3w6HGfC0Z6WcF44d2iB+6IIwB0RpV6n0LVrOnrazKENw2DyDU5cd6A 
iiWtxT3LEsJ2TQ== 
-----END PRIVATE KEY----- 
```
This generates an RSA private key and then prints the key contents to the console. The key was encoded in PEM format, which stores the key in a Base64 encoding and includes the descriptors `-----BEGIN ...-----` and `-----END ...-----.` These lines are defined by the format’s standard and must always be present in the PEM file, including the correct number of dashes, and the files will begin with the prefix `MII` before the actual key data.  

It’s important to note that the private key we just generated is in plaintext – that is, the contents of `private.pem` are the key itself. Keeping the private key in plaintext is not recommended. We will learn how to generate an encrypted private key later on. 

Next, we will view the key components and generate a public key file to go with it. Run the following command: 
```
$ openssl pkey -in private.pem -noout -text_pub 
Public-Key: (1024 bit) 
Modulus: 
00:cf:6c:fa:f9:6b:29:41:32:b1:47:5d:0e:12:30:
5c:82:45:57:f8:27:ed:97:89:c4:83:25:00:e5:16: 
17:63:49:f1:a1:24:dd:ff:d0:3c:fc:45:42:81:ce: 
ff:d9:cf:58:f5:48:ad:29:ea:c0:a6:5e:8f:77:07: 
c2:31:99:4d:38:27:08:db:78:36:62:32:1a:ca:0b: 
4d:ad:ed:ca:ce:e4:a0:3e:5c:47:3f:e5:43:0d:c2: 
97:05:ed:b6:c0:e6:65:a0:63:25:6d:57:5c:ec:d9: 
e1:e3:bb:02:3b:82:54:6a:e4:4e:1d:d0:5a:35:a8: 
a0:2e:e9:85:68:03:6c:4b:b9 
Exponent: 65537 (0x10001) 
```
The `pkey` command, which assumes the input is a private key unless otherwise specified, shows us details of `private.pem`. Normally, the key itself would be printed, as well as details about the private key like the exponents. We suppressed this information with the `-noout` and `-text_pub` options, so only data related to the public key was printed. You can run the command again using `-text` instead of `-text_pub` to see what different information is available. 

To extract the public key to its own file, we’ll use the `-pubout` option.
```
$ openssl pkey -in private.pem -pubout -out public.pem 
$ cat public.pem 
-----BEGIN PUBLIC KEY----- 
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDPbPr5aylBMrFHXQ4SMFyCRVf4 
J+2XicSDJQDlFhdjSfGhJN3/0Dz8RUKBzv/Zz1j1SK0p6sCmXo93B8IxmU04Jwjb 
eDZiMhrKC02t7crO5KA+XEc/5UMNwpcF7bbA5mWgYyVtV1zs2eHjuwI7glRq5E4d 
0Fo1qKAu6YVoA2xLuQIDAQAB 
-----END PUBLIC KEY----- 
```
The public key is much shorter than the private key, and since it’s meant to be public there is no need to store it in an encrypted file unless you want to. 

## Encryption and Decryption
Now that we have both keys, we can perform encryption and decryption on a file. 
```
$ echo "Let's do cryptography" > plaintext.txt 
$ openssl pkeyutl -in plaintext.txt -encrypt -pubin -inkey public.pem -out ciphertext.bin 
$ cat ciphertext.bin 
a =rm i M O }) Tgmx @ 7 M ˈ ����� � � � � � � ���� ��� � �� % 0s##eg p# C �� �� � �   0 X d ϱ} � � � � � ص��x u ҈ )# # # # z >p � �� � � � � � �� 
 Z WE I E 8] # WЛ i � � � � � �� � � 
$ openssl pkeyutl -in ciphertext.bin -decrypt -inkey key1.pem -out plaintext.dec 
$ cat plaintext.dec 
Let's do cryptography 
```
With the `pkeyutl` command, we first encrypted the file using the public key, which required using the `-encrypt` and `-pubin` options. To decrypt, we had to use the private key with the `-decrypt` option. This is the procedure that would be used to send confidential data to someone without the need for a shared key exchange – only the receiver with the matching private key will be able to decrypt the data.  

## Digital Signatures
If you switch the keys, encrypting with private and decrypting with public, then this would be the procedure for a digital signature, which would use the `-sign` option rather than `-encrypt`. Digital signatures provide authentication to verify integrity, not confidentiality, since the public key is available for anyone to decrypt the data. According to the latest manual pages, `pkeyutl` only supports direct encryption and decryption with RSA. All other public key algorithms are for digital signatures or key derivation, meaning you can only use the `-sign`, `-verify`, `-verifyrecover`, or `-derive` options. 

To generate an RSA key, we didn’t have to specify any parameters – a default key size and public exponent were used. For the other asymmetric algorithms, `genpkey` requires you to give parameters, which can be done either with a parameter file or by including the options directly in the command. We’ll learn how to generate a parameter file and use it to create an encrypted private key. Run the following commands: 
```
$ openssl genpkey -genparam -algorithm EC -out ec_param.pem -pkeyopt ec_paramgen_curve:secp128r1 
$ cat ec_param.pem 
-----BEGIN EC PARAMETERS----- 
MIGXAgEBMBwGByqGSM49AQECEQD////9////////////////MDsEEP////3///// 
//////////wEEOh1ecEQefQ92CSZPCzuXtMDFQAADg1NaW5naHVhUXUMwDpEc9A2 
eQQhBBYf91KLiZstDChgfKUsW4bPWsg5W6/rE8AtopLd7XqDAhEA/////gAAAAB1 
ow0bkDihFQIBAQ== 
-----END EC PARAMETERS---- 
$ openssl genpkey -paramfile ec_param.pem -out ec_private.pem -aes-128-cbc -pass pass:hello
$ cat ec_private.pem 
-----BEGIN ENCRYPTED PRIVATE KEY----- 
MIIBPjBJBgkqhkiG9w0BBQ0wPDAbBgkqhkiG9w0BBQwwDgQInW8Qdv81d8oCAggA 
... 
QiCYj1/GeDQPzG514p3k0MWmxDN+XiUavHJPCfc5I2bZYA== 
-----END ENCRYPTED PRIVATE KEY----- 
```
We first used the `-genparam` option to signal that we’re generating a set of parameters, not a private key. Additionally, to create an Elliptic Curve (EC) key, we have to provide the name of the curve we want to use. `secp128r1` was chosen from the set of available curves listed by `openssl ecparam -list_curves`. EC requires only this parameter, which is given in the man page for `genpkey`. 

Next, we created the key using the parameter file we just generated (`-paramfile ec_param.pem`). We also encrypted the private key with AES-128 in CBC mode using the passphrase `hello`. Unlike the RSA key in the last example, the text stored in `ec_private.pem` is the encrypted version of the key. To view the unencrypted key, we can use the `pkey` command, which will prompt us for the passphrase, `hello`: 
```
$ openssl pkey -in key2.pem
Enter pass phrase for key2.pem: 
-----BEGIN PRIVATE KEY----- 
MIHoAgEAMIGjBgcqhkjOPQIBMIGXAgEBMBwGByqGSM49AQECEQD////9//////// 
... 
e3iU21ihJAMiAASvoqhaMFu8WvXDAC5XjZcW9kXHUoAsQgJR5if0YBxLYQ== 
-----END PRIVATE KEY----- 
```
You can see that the file is different from the one we viewed using cat ec_private.pem – it is the plaintext private key rather than the encrypted private key. We can use this private key to perform sign and verify operations on data, as shown below. 
```
$ openssl pkeyutl -in plaintext.txt -sign -inkey ec_private.pem -out signature1 
Enter pass phrase for ec_private.pem: 
$ cat signature1 
�� � � ��� ���� ��� �� � % # p ` # @## L 
� �k 
$ openssl pkeyutl -verify -in plaintext.txt -sigfile signature1 -inkey ec_private.pem 
Enter pass phrase for ec_private.pem: 
Signature Verified Successfully 
```
You can replace `ec_private.pem` with the previously used RSA key `private.pem` in this last command and see that the verification fails. Additionally, try to perform a signature using public key `public.pem` instead and check what output you get.  
```
$ openssl pkeyutl -verify -in plaintext.txt -sigfile signature1 -inkey private.pem
Signature Verification Failure 
4067E6BC6D70000:error:0200008A:rsa routines:RSA_padding_check_PKCS1_type_1:invalid padding:../crypto/rsa/rsa_pk1.c:75:
4067E6BC6D70000:error:02000072:rsa routines:rsa_ossl_public_decrypt:padding check failed:../crypto/rsa/rsa_ossl.c:599:
$ openssl pkeyutl -in plaintext.txt -sign -pubin -inkey public.pem -out signature2
A private key is needed for this operation
pkeyutl: Error initializing context
```

You can run the following command to clean up this directory and delete the generated files if you would like.
```
$ rm -v ciphertext.bin ec_param.pem ec_private.pem plaintext.dec plaintext.txt private.pem public.pem signature1
```
## → [Part 4: Bash Basics & Exercise 1: Key Exchange](../part4/part4.md)
