;to test my homework run this file and write g++ input.txt
;IMPORTANT NOTE: don't use tab in input.txt because lexer doesn't accept tab character.
;In my languga you can:
;->define recursive function
;->call recursive functun
;->use arithmetik operators

;IMPORTANT NOTE: I already have an input.txt you can use it to test my homework
;IMPORTANT NOTE: don't consider NIL s in result they are because of comment lines
;yusuf abdullah ARSLANALP 151044046

(load "gpp_lexer.lisp")

(defun take_load (str)
	(let ((in (open (string-right-trim "\")"  (string-trim "(load \"" str)) :if-does-not-exist nil)))
	   (when in
		  (loop for line = (read-line in nil)
			while line do (dfa line)
		  )
		  (close in)
	   )
	)
)


(defun my_and (n1 n2)
	(if (and (or (equal n1 1) (equal n1 0)) (or (equal n2 1) (equal n2 0)) )
		(if (and (equal n1 1) (equal n2 1))
			1
			0
		)
		(progn
			(print "----------------------")
			;(print n1)
			(print "RROR in my_and function")
		)
	)
	
)

(setq fn_tokens_map (make-hash-table :test 'equal)) ;function names to tokens
(setq fn_values_map (make-hash-table :test 'equal))	;function name to values
(setq function_tokens '()) ;temp value
(setq function_values '()) ;temp value
(setq scope_map (make-hash-table :test 'equal)) ;variable name to variable value
(setq index_num 0)

(defun parameters_in_defun()
	(loop while (not (equal (car keywords) "OP_CP"))
		do (setq function_tokens (append function_tokens '("OP_OP" "IDENTIFIER" "IDENTIFIER" "VALUE" "OP_CP")))
		do (setq function_values (append function_values '("(" "defvar")))
		do (setq function_values (append function_values (list (car val_of_kws) )));;;;;;;;;;;;;;;;;;;;;
		do (setq function_values (append function_values '("will_be_taken" ")")))
		
		do (setq keywords (cdr keywords))
		do (setq val_of_kws (cdr val_of_kws))	
	)

)

(defun insert_func ( function_name scope)

	(setq keywords (cdr keywords)) ;removes function name
	(setq val_of_kws (cdr val_of_kws))

	(setq index_num 3)
	
	;while(keywords[0] != OP_CP)
	(loop while (not (equal (car keywords) "OP_CP"))
		do(setf (nth index_num (gethash function_name fn_values_map)) (evaluate num1 num2 scope));???is function code setted with parameters: yes
		do (setq index_num (+ index_num 5))
	)
	
	(setq keywords (append (gethash function_name fn_tokens_map) keywords))
	(setq val_of_kws (append (gethash function_name fn_values_map) val_of_kws))

)

(defun take_until_cph ()
	(setq phr_num 0)
	(loop while (>= phr_num 0)
		do(if	(equal (car keywords) "OP_OP")
			(setq phr_num (+ phr_num 1))
		)
		do(if	(equal (car keywords) "OP_CP")
			(setq phr_num (- phr_num 1))
		)
		do(if (not (equal phr_num -1))
			(progn
				(setq function_tokens (append function_tokens (list (car keywords))))
				(setq function_values (append function_values (list (car val_of_kws))))
				(setq keywords (cdr keywords))
				(setq val_of_kws (cdr val_of_kws))			
			)
		)
	)


)

;delete first expression
(defun delete_fex()
	
	(setq phr_num 0)
	(cond
		(
			(equal (car keywords) "IDENTIFIER")
			(progn
				(setq keywords (cdr keywords))
				(setq val_of_kws (cdr val_of_kws))			
			)
		)
		(
			(equal (car keywords) "VALUE")
			(progn
				(setq keywords (cdr keywords))
				(setq val_of_kws (cdr val_of_kws))			
			)
		)
		(
			(equal (car keywords) "OP_OP")
			(progn
				(setq keywords (cdr keywords)) ;delete first op_op parantez
				(setq val_of_kws (cdr val_of_kws))				
				(loop while (>= phr_num 0)
					do(if	(equal (car keywords) "OP_OP")
						(setq phr_num (+ phr_num 1))
					)
					do(if	(equal (car keywords) "OP_CP")
						(setq phr_num (- phr_num 1))
					)
					
					do(setq keywords (cdr keywords)) ;delete
					do(setq val_of_kws (cdr val_of_kws))						
					
					
				)
				;(setq keywords (cdr keywords)) ;delete last op_cp parantez
				;(setq val_of_kws (cdr val_of_kws))
			)
		)
		(
			t
			(print "error in delete_fex function")
		)
	
	)
)

;find next expresiion index
(defun find_next_ei()
	(setq next_ei_index 1)
	(setq phr_num 0)
	(cond
		(
			(equal (car keywords) "IDENTIFIER")
			1
		)
		(
			(equal (car keywords) "VALUE")
			1
		)
		(
			(equal (car keywords) "OP_OP")
			(progn			
				(loop while (>= phr_num 0)
					do(if	(equal (nth next_ei_index keywords) "OP_OP")
						(setq phr_num (+ phr_num 1))
						(setq next_ei_index (+ next_ei_index 1))
					)
					do(if	(equal (nth next_ei_index keywords) "OP_CP")
						(setq phr_num (- phr_num 1))
						(setq next_ei_index (+ next_ei_index 1))
					)
				)
				(setq next_ei_index (+ next_ei_index 1))
				next_ei_index
			)
		)
		(
			t
			(print "error in find_next_ei function")			
		)
	
	)


)

;delete second expression
(defun delete_next( index )
	(setq phr_num 0)
	(cond
		(
			(equal (nth index keywords) "IDENTIFIER")
			(progn
				(setq keywords (remove-nth index keywords))
				(setq val_of_kws (remove-nth index val_of_kws))			
			)
		)
		(
			(equal (nth index keywords) "VALUE")
			(progn
				(setq keywords (remove-nth index keywords))
				(setq val_of_kws (remove-nth index val_of_kws))				
			)
		)
		(
			(equal (nth index keywords) "OP_OP")
			(progn
				(setq keywords (remove-nth index keywords))
				(setq val_of_kws (remove-nth index val_of_kws))				
				(loop while (>= phr_num 0)
					do(if	(equal (nth index keywords) "OP_OP")
						(setq phr_num (+ phr_num 1))
					)
					do(if	(equal (nth index keywords) "OP_CP")
						(setq phr_num (- phr_num 1))
					)
					
					do(setq keywords (remove-nth index keywords))
					do(setq val_of_kws (remove-nth index val_of_kws))							
					
				)
				;(setq keywords (remove-nth index keywords))
				;(setq val_of_kws (remove-nth index val_of_kws))	
			)
		)
		(
			t
			(print "error in delete_fex function")
		)
	
	)
)



(defun defvar_set () ;checks if the next ixpression is defvar or set
	(and (equal (car (cdr keywords)) "IDENTIFIER")
		(or
			(equal (car (cdr val_of_kws)) "set")
			(equal (car (cdr val_of_kws)) "defvar")
		)
	)

)

;val_of_kws value of keywords
(defun evaluate (num1 num2 scope)

	(cond
		(	;if keywords[0]==COMMENT
			(equal (car keywords) "COMMENT")
			(progn
				(setq keywords (cdr keywords))
				(setq val_of_kws (cdr val_of_kws))
				nil
			)
		
		)	
		(	;if keywords[0]==VALUE
			(equal (car keywords) "VALUE")
			(progn
				(if (equal (numberp (car val_of_kws)) nil)
					(setq num1 (parse-integer (car val_of_kws))) ;if val_of_kws[0] is not an integer
					(setq num1 (car val_of_kws)) ;if val_of_kws[0] is an integer
				)
				(setq keywords (cdr keywords))
				(setq val_of_kws (cdr val_of_kws))
				num1
			)
		
		)
		(	;if keywords[0]==IDENTIFIER
			(equal (car keywords) "IDENTIFIER")
			(progn
				(setq num1 (gethash (car val_of_kws) scope))
				(setq keywords (cdr keywords))
				(setq val_of_kws (cdr val_of_kws))
				num1			
			)
			
			
			
		)
		(	;if keywords[0]==OP_OP
			(equal (car keywords) "OP_OP")
			(progn
				(setq keywords (cdr keywords)) ;remove open paranthes
				(setq val_of_kws (cdr val_of_kws))				
				(cond
					(	;if
						(equal (car keywords) "KW_AND" )
						(progn			
							(setq keywords (cdr keywords)) ;removes KW_AND
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(logand num1 num2)
						)
					)
					(	;if
						(equal (car keywords) "KW_OR" )
						(progn			
							(setq keywords (cdr keywords)) ;removes KW_AND
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(logior num1 num2)
						)
					)
					(	;if
						(equal (car keywords) "KW_NOT" )
						(progn			
							(setq keywords (cdr keywords)) ;removes KW_NOT
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(print "here") (print num1)
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(not num1)
						)
					)
					(	;if
						(equal (car keywords) "OP_PLUS" )
						(progn				
							(setq keywords (cdr keywords)) ;removes OP_PLUS
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(+ num1 num2)
						)
					)
					(	;if
						(equal (car keywords) "OP_MINUS" )
						(progn				
							(setq keywords (cdr keywords)) ;removes OP_MINUS
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(- num1 num2)
						)
					)
					(	;if
						(equal (car keywords) "OP_MULT" )
						(progn				
							(setq keywords (cdr keywords)) ;removes OP_MULT
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(* num1 num2)
						)
					)					
					(	;if
						(equal (car keywords) "OP_DIV" )
						(progn				
							(setq keywords (cdr keywords)) ;removes OP_DIV
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(/ num1 num2)
						)
					)
					(	;if
						(equal (car keywords) "KW_EQUAL" )
						(progn				
							(setq keywords (cdr keywords)) ;removes KW_EQUAL
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							(if (equal num1 num2)
								1
								0
							)
						)
					)
					(	;if
						(equal (car keywords) "KW_LIST" )
						(progn
							(setq num1 '())
							(setq keywords (cdr keywords)) ;removes KW_LIST
							(setq val_of_kws (cdr val_of_kws))
							
							
							(loop while (not (equal (car keywords) "OP_CP"))
								do(setq num1 (append num1 (list (evaluate num1 num2 scope))))
							)							

							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							num1
						)
					)					
					(	;if
						(equal (car keywords) "KW_IF" )
						(progn
							
							(setq keywords (cdr keywords)) ;removes KW_IF
							(setq val_of_kws (cdr val_of_kws))
							(setq num1 (evaluate num1 num2 scope))
							(if (equal num1 1)
								(delete_next (find_next_ei))
								(delete_fex)
								
							)
							;(print keywords)
							(setq num2 (evaluate num1 num2 scope))
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))					
								)
								(print "ERROR2")
							)
							num2
						)
					)
					(	;if
						(equal (car keywords) "KW_DEFFUN" )
						(progn
							
							(setq keywords (cdr keywords))
							(setq val_of_kws (cdr val_of_kws))
							(if (equal (car keywords) "IDENTIFIER" )
								(progn
									(setq function_name (car val_of_kws))
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))							
								)
								(print "ERROR3 in defun")
							)
							(if (equal (car keywords) "OP_OP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))							
								)
								(print "ERROR4 in defun")
							)
							(setq function_tokens '())
							(setq function_values '())
							(parameters_in_defun)
							(if (equal (car keywords) "OP_CP" )
								(progn
									(setq keywords (cdr keywords))
									(setq val_of_kws (cdr val_of_kws))							
								)
								(print "ERROR5 in defun")
							)
							(take_until_cph)
							(setq keywords (cdr keywords))
							(setq val_of_kws (cdr val_of_kws))	
							(setf (gethash function_name fn_tokens_map) function_tokens)
							(setf (gethash function_name fn_values_map) function_values)
							0
						
						)
					)

					
					(
						;if keywords[0]==defvar or keywords[0]==set
						(equal (car keywords) "IDENTIFIER")
						(if (or (equal (car val_of_kws) "defvar") (equal (car val_of_kws) "set") ) 
							(progn
								(setq keywords (cdr keywords)) ;remove defvar or set
								(setq val_of_kws (cdr val_of_kws))
								(setq num2 (car val_of_kws)) ;num2 = var_name
								(setq keywords (cdr keywords)) ;remove var_name
								(setq val_of_kws (cdr val_of_kws))
								(setq num1 (evaluate num1 num2 scope))
								(setf (gethash num2 scope) num1)
								(setq keywords (cdr keywords)) ;remove close parantez
								(setq val_of_kws (cdr val_of_kws))
								scope
							)
							
							;function call
							;if val_of_kws[0] a key for fn_values_map
							(if	(not (equal (gethash (car val_of_kws) fn_values_map) nil)) ;
								(progn

									(insert_func (car val_of_kws) scope)
									(loop while (not (equal (car keywords) "OP_CP"))
										do(if (defvar_set)
											(setq scope (evaluate num1 num2 scope))
											(setq num1 (evaluate num1 num2 scope))
										)
									)
									(setq keywords (cdr keywords)) ;remove open parantez
									(setq val_of_kws (cdr val_of_kws))
									num1
								)
								(progn
									(setq keywords nil)
									(print "undefined identifier")
									nil
								)
							)
						)
					)
				)
			)
		)
		(t 
			(progn
				;(print (car keywords))
				(princ "SYNTAX_ERROR probably near ")
				(princ (car keywords))
				(cl-user::quit)
				;(setq keywords nil)
			)
		)
	)
)

(setq num1 'a)
(setq num2 'a)

(defun gppinterpreter ( inputp_type )
	
	(cond
		(
			(string= inputp_type "g++")
			(progn
				(setq input_string (read-line))
				(loop while (not (string= input_string "(exit)"))
					
					do(progn ;normal input
						(dfa input_string)
						(loop while (not (equal keywords nil))
							do(if (defvar_set)
									(setq scope_map (evaluate num1 num2 scope_map))
									(progn
										;(print "HEREEEE")
										(print (evaluate num1 num2 scope_map))
									)
							)
							(terpri)

						)						
					
					)
					
					do(setq input_string (read-line))
				)
			)
		
		)
		(	;if takes just a file
			(and (string= "g" (aref inputp_type 0)) (string= "+" (aref inputp_type 1)) (string= "+" (aref inputp_type 2)) (string= " " (aref inputp_type 3)))
			(let ((in (open (string-trim "g++ " inputp_type) :if-does-not-exist nil)))
				(progn
					(when in
					  (loop for line = (read-line in nil)
						while line do (dfa line)
					  )
					  (close in)
					)				

					(loop while (not (equal keywords nil))
						do(if (defvar_set)
								(setq scope_map (evaluate num1 num2 scope_map))
								(print (evaluate num1 num2 scope_map))
						)

					)
					(terpri)
				
				
				)
			)
		)
	)
)


;(print *args*)
;(setq ip_type (read-line))

(setq arguments *args*)
(if ( null arguments )
	(setq ip_type "g++")
	(setq ip_type (concatenate 'string "g++ " (car arguments)))
	
)

(gppinterpreter ip_type)



