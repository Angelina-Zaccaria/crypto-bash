# Cheat Sheet

## Part 2: Symmetric Cryptography

Symmetric encryption:
```
openssl enc -e -aes-128-cbc -pbkdf2 -k "passphrase" -in plaintext.txt -out ciphertext.txt
openssl enc -e -aes-128-cbc -pbkdf2 -kfile key_file.pem -in plaintext.txt -out ciphertext.txt
```

Symmetric decryption:


## Part 3: Asymmetric (Public Key) Cryptography

Generate private key:
```
openssl genpkey -algorithm RSA -out private.pem
```

Generate public key from private key:
```
openssl pkey -in private.pem -pubout -out public.pem
```

Encrypt with public key:
```
openssl pkeyutl -encrypt -in plaintext.txt -inkey receiver_public.pem -out ciphertext.txt
```

Decrypt with private key:
```
openssl pkeyutl -decrypt -in ciphertext.txt -inkey receiver_private.pem -out decrypted.txt
```

## Part 4: Bash Basics

