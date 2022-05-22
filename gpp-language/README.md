# Common Lisp Interpreter Implementation

For installing common lisp click [here](https://github.com/yusufarslanalp/Common-Lisp#install-clisp).

This project is a Common Lisp interpreter imlemantation with Common Lisp language. The name of this newly created language is gpp. For more information about gpp language read [this](GppSyntax.pdf) documentation.

gpp has following features as a programming language:
- Function definition (include recursive)
- Function call
- Assignment (defvar and set funtions)
- If statement
- Aritmetic operators (+, -, /, *)
- Boolean operators (and, or)
- Equal function (equal expi expi)

# Example
-  In first line for the following image we run gpp languaage in interpreter mode.
- in the second line we define a multiplication function.
- 4.line is the return value of the function definition.
- in 5.line we call previously defined function.
- 7.line is the return value of the called function.
- 8.line is a function definition. The defined function is a recursive function.
- 10.line is return value of functio definition.
- 11.line is a function call of previously defined function.
- 13.line is the return value of the callsed function.
- with 14.line we exit from the gpp interpreter.

<image src = "example.jpeg">



## Application Structure
gpp_lexer.lisp creates tokens from an input string. Lexical analysis part has done with a DFA. DFA checks syntax of the written program and creates tokens from the written program. If the written program has any syntax error then DFA terminates on the error state.

Following image is the DFA of gpp language. The implemantation of following DFA is the dfa function in the gpp_lexer.lisp file.

<image src="DFA.jpeg">

gpp_interpreter.lisp evaluates tokens. For more information about implemented language read [this](GppSyntax.pdf) documentation. The gpp can be run in REPL mode.The gpp language can read and run an input file.



# Usage

## REPL (Read Evaluate Print Loop) Mode

Following command will run gpp language in REPL mode

    '''
    clisp gpp_interpreter.lisp
    '''

Run codes in REPL mode. For example for addition to number run following command:

    '''
    (+ 2 2)
    4
    '''

## Run gpp Language From Input File

Following command will read input.txt file and run it.

    '''
    clisp gpp_interpreter.lisp input.txt
    '''
