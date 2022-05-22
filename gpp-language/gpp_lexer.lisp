;Yusuf Abdullah ARSLANALP 151044046
;NOTE: I have a dfa in my folder.(DFA.jpeg)
;I have an input in input.txt file.
;To test this program you can directly run the program.
;Or you can change content of input.txt file
;NOTE: The lexer can dedect some errors. These are:
;leading zero in a value
;an identifier can not start with a digit
;no character permitted other then [a,z], [A,Z] and [0,9] 

(setq keywords '())
(setq val_of_kws '())



(defun is_char(x)
	(setq int_x (char-int x))
	(setq upper_a (char-int #\A))
	(setq upper_z (char-int #\Z))
	(setq lower_a (char-int #\a))
	(setq lower_z (char-int #\z))
	(if (or
			(and
				(>= int_x lower_a)
				(<= int_x lower_z)
			)
			(and
				(>= int_x upper_a)
				(<= int_x upper_z)
			)
		)
		t
		nil
	)
)

(defun is_digit(x)
	(setq int_x (char-int x))
	(if (and (>= int_x (char-int #\0)) (<= int_x (char-int #\9)))
		t
		nil
	)
)

(defun is_op(x)
	(setq int_x (char-int x))
	(if (or (equal x #\+) (equal x #\-) (equal x #\/) (equal x #\*)
			(equal x #\() (equal x #\)) (equal x #\") (equal x #\,)
		)
		t
		nil
	)
)

;takes an operator as string and return a string.
(defun str_op (x)
	(cond
			( (equal x "+") "OP_PLUS")
			( (equal x "-") "OP_MINUS")
			( (equal x "/") "OP_DIV")
			( (equal x "*") "OP_MULT")
			( (equal x "(") "OP_OP")
			( (equal x ")") "OP_CP")
			( (equal x "**") "OP_DBLMULT")
			( (equal x "\"") "OP_OC")
			( (equal x ",") "OP_COMMA")			
			( t nil)
	)
)

;takes an keyword as string and return a string.
(defun is_keyword (x)
	(cond
			( (equal x "and") "KW_AND")
			( (equal x "or") "KW_OR")
			( (equal x "not") "KW_NOT") 
			( (equal x "equal") "KW_EQUAL")
			( (equal x "less") "KW_LESS")
			( (equal x "nil") "KW_NIL")
			( (equal x "list") "KW_LIST")
			( (equal x "append") "KW_APPEND")
			( (equal x "concat") "KW_CONCAT")
			;( (equal x "set") "KW_SET")
			( (equal x "deffun") "KW_DEFFUN")
			( (equal x "for") "KW_FOR")
			( (equal x "if") "KW_IF")
			( (equal x "exit") "KW_EXIT")
			( (equal x "load") "KW_LOAD")
			( (equal x "disp") "KW_DISP")
			( (equal x "true") "KW_TRUE")
			( (equal x "false") "KW_FALSE")			
			( t nil)
	)
)

;prints token with its kind(keyword, identifier or value)
(defun calc_token( word state )
	(if(not (equal word ""))
		(cond ;this cond print last token

				(	;if word is a keyword
					(is_keyword word)
					(progn 
						;(print word)
						;(print (is_keyword word))
						(setq keywords (append keywords (list (is_keyword word))))
						(setq val_of_kws (append val_of_kws (list word)))
						;(format t "~A: ~A" (is_keyword word) word)
						;(terpri)
						(setq word "")
					)										
				)
				(
					(equal state "identifier")
					(progn
						;(print word)
						;(print "IDENTIFIER")
						(setq keywords (append keywords (list "IDENTIFIER")))
						(setq val_of_kws (append val_of_kws (list word)))
						;(format t "IDENTIFIER: ~A" word)
						;(terpri)
					)									
				)
				
				(
					(equal state "value")
					(progn
						;(print word)
						;(print "VALUE")
						(setq keywords (append keywords (list "VALUE")))
						(setq val_of_kws (append val_of_kws (list word)))
						;(format t "VALUE: ~A" word)
						;(terpri)										
					)
				)
				(
					(equal state "zero")
					(progn
						;(print word)
						;(print "VALUE")
						(setq keywords (append keywords (list "VALUE")))
						(setq val_of_kws (append val_of_kws (list word)))
						;(format t "VALUE: ~A" word)
						;(terpri)										
					)
				)				
		)
	)
)

(defun dfa (line)
	;states are: initial
	(setq state "initial")
	(setq word "")

	(setq size (length line))
	(loop for i from 0 to (- size 1)
		do(cond	
			(	;if( line[i] == char and state == initial )
				(and (is_char (aref line i)) (equal state "initial") ) 
				(progn
					(setq word (concatenate 'string word (list (aref line i)))) ;word += line[i]
					(setq state "identifier")
				)
			)
			(	;if(state == identifier and (line[i] == digit || line[i] == char))
				(and (or (is_char (aref line i)) (is_digit (aref line i))) (equal state "identifier") ) 
				(progn
					(setq word (concatenate 'string word (list (aref line i)))) ;word += line[i]
					(setq state "identifier")
				)
			)
			(	;if( line[i] == 0 and state == initial )
				(and (equal (aref line i) #\0) (equal state "initial") ) 
				(progn
					(setq word "0")
					(setq state "zero")
				)
				
			
			)
			(	;if( line[i] == digit and state == zero )
				(and (is_digit (aref line i)) (equal state "zero") ) ;line[i] == digit and state == zero
				(progn
					(setq word "")
					(print "ERROR: probably a value has a leading zero")
					(terpri)
					;break
				)
			)
			(	;if( line[i] == digit and state == initial )
				(and (is_digit (aref line i)) (equal state "initial") )
				(setq word (concatenate 'string word (list (aref line i)))) ;word += line[i]
				(setq state "value")
			)
			(	;if( line[i] == digit and state == value )
				(and (is_digit (aref line i)) (equal state "value") ) ;line[i] == digit and state == value
				(setq word (concatenate 'string word (list (aref line i)))) ;word += line[i]
			)
			(	;if(line[i]==" ")
				(equal (aref line i) #\space)
				(calc_token word state)
				(setq word "")
				(setq state "initial")
			)
			(	;if line[i] == op
				(is_op (aref line i))
				(progn
					(calc_token word state)
					(setq word "")
					(setq state "initial")
					(if(equal #\* (aref line i))
						(if(equal #\* (aref line (+ 1 i)))
							(progn
								(setq i (+ i 1))
								(setq word (concatenate 'string word (list #\*)))
							)
						)
					)						
					(setq word (concatenate 'string word (list (aref line i))))

					(setq keywords (append keywords (list (str_op word))))
					(setq val_of_kws (append val_of_kws (list word)))
					
					;(format t "~A: ~A" (str_op word) word)
					;(terpri)
					(setq word "")
				
				)
			)
			(	;if line[i] == ;
				(equal (aref line i) #\;)
				(if(equal (aref line (+ i 1)) #\;)
					(progn
						(calc_token word state)
						(setq word ";")
						(setq state "initial")

						(setq keywords (append keywords (list "COMMENT")))
						(setq val_of_kws (append val_of_kws (list word)))						

						;(print "COMMENT")
						(terpri)
						(setq word "")
						(return-from dfa) ;terminates function
					)
					(print "ERROR")
				
				
				)
			)
			(	
				t ;else
				(progn
					(format t "ERROR: =something wrong near ~A~%" word)
					(setq word "")
					(return)
				)
			)
			
		)	
	)
	;this three line takes last token from input line.
	(calc_token word state)
	(setq word "")
	(setq state "initial")
)

(defun remove-by-position (pred lst)
  (labels ((walk-list (pred lst idx)
             (if (null lst)
                 lst
                 (if (funcall pred idx)
                     (walk-list pred (cdr lst) (1+ idx))
                     (cons (car lst) (walk-list pred (cdr lst) (1+ idx)))))))
    (walk-list pred lst 1)))

(defun remove-nth (n list)
  (remove-by-position (lambda (i) (= i (+ n 1))) list))



