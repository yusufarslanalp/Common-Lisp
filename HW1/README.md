# Programming Languages HW1

The homework PDF is in the repository

## Part1

part1.lisp will read a file called “nested_list.txt” and converts it into a single list without any sub-lists. Output will be written into a file called “flattened_list.txt”.

### Input (nested_list.txt)
```
1 2 3 (4 5 (12 11 9 6) 4 8 (77 53(47)) (12 15 18))
```
### Output (flattened_list.txt)
```
1 2 3 4 5 12 11 9 6 4 8 77 53 47 12 15 18
```

## Part2
This part called primecrawler. This program will read two integers from a file called “boundries.txt”. Then finds primes and semi-primes between the two integers (Both ends are included) (Semi-prime number is a number that have only two prime divisor). And prints the results into a file called, “primedistribution.txt”. 

### Input (boundries.txt)
2 10

### Output (primedistribution.txt)
2 is Prime
3 is Prime
4 is Semi-prime
5 is Prime
6 is Semi-prime
7 is Prime
9 is Semi-prime
10 is Semi-prime

## Part3
This part reads at most 5 integers (File may contain fewer numbers) from a given file called “integer_inputs.txt”. For each integer you calculates the collatz sequence and prints the results into a file called “collatz_outputs.txt”.

### Input (integer_inputs.txt)
```
6 8 17
```


### Output (collatz_outputs.txt)
```
6: 6 3 10 5 16 8 4 2 1 
8: 8 4 2 1 
17: 17 52 26 13 40 20 10 5 16 8 4 2 1
```


## Part4
This part will calculate the Huffman codes for a given paragraph from a file called “paragraph.txt”. For each character (including whitespaces) in the paragraph the program will construct the Huffman tree and determine the Huffman codes. For each character you will print the character and the codes into a file called “huffman_codes.txt”. Note codes in the files should be ordered according to their length. (Shorter codes should appear at the top of the file)

[click here for huffman code wiki page](https://en.wikipedia.org/wiki/Huffman_coding)

### Input (paragraph.txt)

```
Gödel’s incompleteness theorems are among the most important results in modern logic. These discoveries revolutionized the understanding of mathematics and logic, and had dramatic implications for the philosophy of mathematics. There have also ...
```

### Output (huffman_codes.txt)
```
e: 011
space: 110
r: 0000
n: 0010
a: 0011
o: 0101
i: 1000
s: 1010
t: 1111
   .
   .
   .
newline: 111011011000
C: 111011011001
```
