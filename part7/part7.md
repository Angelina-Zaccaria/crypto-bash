# Part 7: Exercise 3: Algorithm Runtime Comparison Demo
Students apply the knowledge from previous parts and advance their bash skills to analyze the runtimes of different encryption algorithm commands.

## Exercise 3: Compare Runtimes of Different Symmetric and Asymmetric Algorithms
Use command line OpenSSL to compare the runtimes of different symmetric and asymmetric encryption algorithms. First, generate a plaintext file that is 10 MB in length. It doesn’t matter what text you use. Next, use the Linux command `time` to track how long each symmetric algorithm takes to encrypt your plaintext, and how long each asymmetric algorithm takes to perform a signature on the same file. 

You can write a script if you want, or just type the commands in the terminal. Try to determine the fastest/slowest symmetric and asymmetric algorithms and the impact of different variables (message/key size) on the runtime. If you take the approach of writing a script with the output being written to a CSV file, you can analyze your results in Excel according to the following guide.

## Guide to using PivotTables in Excel:
* Highlight the columns you want to use as fields
  * Symmetric: encryption algorithm, message size, key size, elapsed real time 
  * Asymmetric: signature algorithm, message size, elapsed real time
* Insert > PivotTable > OK
* Check off field of primary importance (encryption/signature algorithm) and drag and drop it to Rows section (there is Filters, Columns, Rows, Values)
* Add other values (time, message and/or key size) 
  * Time can be under Values, message/key size should be under Rows or Columns
* Select a time value cell, right click, Sort, Smallest to Largest / Largest to Smallest to analyze results

## Example observations:
* Symmetric (using [enc_log.csv](enc_log.csv))
  * AES and RC4 are fastest, ARIA and DES are slowest
  * Message size makes a big difference in elapsed real time
  * Key size doesn’t make much difference in elapsed real time
* Asymmetric (using [dgst_log.csv](dgst_log.csv))
  * MD4 and SHA1 are fastest, SHA3 and SM3 are slowest
  * Message size makes a big difference in elapsed real time
