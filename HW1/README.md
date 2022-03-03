# Programming Languages HW1

The homework PDF is in the repository

## Part1

### Description
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

For example: for given the input file that contains 2 and 10 we expect your output as follows:
