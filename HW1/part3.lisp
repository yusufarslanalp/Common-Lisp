(defun collatz ( num )
	(setq result (list num))

	(if (< num 1)
		(return-from collatz (setq result (append result (list "lower then 1 is not evaluated"))) )
	)

	(loop while (/= num  1) 
	  do (if (equal (mod num 2) 0)
		 (progn
			(setq num (/ num 2)) ;num = num *2
			(setq result (append result (list num))) ;result.add( num )
		 )
		 (progn
			(setq num (+ (* num 3) 1)) ; num = (num*3)+1
			(setq result (append result (list num))) ;result.add( num )
		 )
		 
	  
	  )
	)
	result
)

;
(defun take_nums ( str )
	(setq nums '())

	(setq word "")
	(setq size (length str))
	(loop for i from 0 to (- size 1)
		do(if (not (string= " " (aref str i))) ;if( str[i] != " " )
			;eğer gelen harf boşluk haricinde bir karakterse gelen karakteri worde ekle
			(setq word(concatenate 'string word (list (aref str i))))
			
			;ama eğer gelen harf boşluk ise
			(if (not (string= "" word)) ;ve eğer word boş bir string değilse
				(progn 
					(setq nums (append nums (list (parse-integer word)))) ;nums += (int)word
					(setq word "")
					(if (equal (length nums) 5)
						(return-from take_nums nums)
					)
				)			
			)			
		)
	
	)
	
	(if (not (string= "" word)) ;eğer word boş bir string değilse
		(setq nums (append nums (list (parse-integer word)))) ;nums += (int)word
		(return-from take_nums nums) ;else
	
	)	
)

;returns nums list
(defun read-file ( file_name )
	
	(let ((in (open file_name :if-does-not-exist nil)))
	   (when in
		  (loop for line = (read-line in nil)
			while line do ( progn
				(close in)
				(return-from read-file (take_nums line))
			)
		  )
	   )
	)
)


;parametre olarak bir tamsayı listesi ve dosya adı alır
;aldığı listedeki her elemanın collatz dizisini aldığı dosyaya yazar. 
(defun list-to-collatz ( nums file_name )

	(with-open-file 
		(str file_name
			 :direction :output
			 :if-exists :supersede
			 :if-does-not-exist :create
		)
		(format str "")
	)
	
	
	(setq size (length nums))
	
	(loop for i from 0 to (- size 1)
		do(setq collatz_seq (collatz (nth i nums)))
		do(with-open-file 
				(str file_name
					 :direction :output
					 :if-exists :append
					 :if-does-not-exist :create
				)
				(format str "~D: " (car collatz_seq) )
		)
		do(setq collatz_seq_size (length collatz_seq))
		do(loop for j from 0 to (- collatz_seq_size 1)
			do(with-open-file 
				(str file_name
					 :direction :output
					 :if-exists :append
					 :if-does-not-exist :create
				)
				(format str "~D " (nth j collatz_seq) )
			)
		
		)
		do(with-open-file 
			(str file_name
				 :direction :output
				 :if-exists :append
				 :if-does-not-exist :create
			)
			(format str "~%" )
		)
	)
)

(setq numbers ( read-file "integer_inputs.txt" ))
(list-to-collatz numbers "collatz_outputs.txt" )


;(print ( read-file "integer_inputs.txt" ))
;(print (collatz 17))
