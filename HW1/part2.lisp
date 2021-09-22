(defun primecrawler ( file_name lower_num upper_num )
	(with-open-file 
		(str file_name
			 :direction :output
			 :if-exists :supersede
			 :if-does-not-exist :create
		)
		(format str "")
	)
	
	(loop for i from lower_num to upper_num
		do(
			progn
				(if (is-prime i)
					(with-open-file 
						(str file_name
							 :direction :output
							 :if-exists :append
							 :if-does-not-exist :create
						)
						(format str "~D is Prime~%" i )
					)
				)
				(if (is-semiprime i)
					(with-open-file 
						(str file_name
							 :direction :output
							 :if-exists :append
							 :if-does-not-exist :create
						)
						(format str "~D is Semi-prime~%" i )
					)
				)				
		)
	)
)

(defun is-prime ( num )
	
	;if(num < 2) return false
	(if (< num 2)
		(progn
			(return-from is-prime nil)
		)
	)

	;for(i = 2; i < num; i++)
	(loop for i from 2 to (- num 1)
		do(if (equal 0 (mod num i)) 
			(return-from is-prime nil)
		)
	)
	t ;return true
)

;eğer sayıdan küçük sayıyı bölen 2 sayı varsa ikiside asalsa semiprime
;eğer sayısan küçün sayıyı bölen 1 tane sayı varsa ve asalsa semiprime
(defun is-semiprime ( num )
	(setq ls '())
	
	;if(num < 2) return false
	(if (< num 2)
		(return-from is-semiprime nil)
	)	
	
	;if( is-prime(num) == t ) return false
	(if (is-prime num)
		(return-from is-semiprime nil)
	)
	
	;for(i = 2; i < num; i++)
	(loop for i from 2 to (- num 1)
		do(if (equal 0 (mod num i)) 
			(setq ls (append ls (list i)))
		)
	)
	
	(if (> (length ls) 2)
		(return-from is-semiprime nil)
	)
	
	(if (equal (length ls) 1)
		(if (is-prime (car ls))
			(return-from is-semiprime t)
		)
	)
	
	(if (equal (length ls) 2)
		(if (and ;if both first and second element of ls is prime
				(is-prime (car ls))
				(is-prime (car (cdr ls)))
			)
			(return-from is-semiprime t)
		)
	)
	
	nil
)


;verilen bir sring içerisindeki iki tam sayıyı iki elemanlı bir liste olarak return eder.
(defun take_two_int ( str )
	(setq two_int '())

	(setq word "")
	(setq result '())
	(setq size (length str))
	(loop for i from 0 to (- size 1)
		do(if (not (string= " " (aref str i))) ;if( str[i] != " " )
			;eğer gelen harf boşluk haricinde bir karakterse gelen karakteri worde ekle
			(setq word(concatenate 'string word (list (aref str i))))

			;ama eğer gelen harf boşluk ise
			(if (not (string= "" word)) ;ve eğer word boş bir string değilse
				(progn
					(setq two_int (append two_int (list (parse-integer word)))) ;two_int += (int)word
					(setq word "")
					(if (equal (length two_int) 2)
						(return-from take_two_int two_int)
					)
				)
			)

		)
	
	)
	
	(setq two_int (append two_int (list (parse-integer word)))) ;two_int += (int)word
)


;file_name dosyasındaki iki tamsayıyı okur ve 
(defun read-file ( file_name )
	
	(let ((in (open file_name :if-does-not-exist nil)))
	   (when in
		  (loop for line = (read-line in nil)
			while line do ( progn
				(close in)
				(return-from read-file (take_two_int line))
			)
		  )
	   )
	)
)

(setq bounds (read-file "boundries.txt" ))
(setq lower_bound (car bounds)) ;upper_bound = bounds[0]
(setq upper_bound (car (cdr bounds)) ) ;lower_bound = bounds[1]


(primecrawler "primedistribution.txt" lower_bound upper_bound)

;(print (is-prime 0))

; (loop for i from 2 to 100
	; do(if (is-semiprime i) 
		; (print i)
	; )
; )

