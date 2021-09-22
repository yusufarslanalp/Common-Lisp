(defun flattener( lis )
	( setq result '() ) ;oluşturulacak listeleri birleştirmek için boş bir lite tanımla.

	(if	(null lis ) ;parametre olarak alınan liste boş ise 'nil' return et. 
		nil 
		(progn ;parametre olarak alınan liste boş değilse aşağıdaki kod bloğunu çalıştır.
			(if	( and (atom (car lis)) ( not ( null (car lis) ) ) ) ;(car lis) atomsa ve (car lis) null değilse koşul doğru
				( setq result (append result (list (car lis))) ) ;koşul doğruysa (car lis)'i result'a append et. 	
				( setq result ( append result (flattener (car lis))) ) ;koşul yanlışsa (car lis) bir listedir.flattener fonksiyonunu çağır.
			)
			( setq result (append result (flattener (cdr lis))) ) ;listenin diğer elemanı için flattener fonksiyonunu çağır. 
			result ;içi içe listelerden arındırılmış result listesini return et.
		)
	)
)


(defun read-list( file_name )
	(let ((in (open file_name :if-does-not-exist nil)))
	   (when in
		  (loop for line = (read-line in nil)
			while line do ( return-from read-list line )
		  )
		  (close in)
	   )
	)
)

(defun string-to-list( )
	(setq str_list (read-list "nested_list.txt"))
	(setq str_list (concatenate 'string "(setq nested_list '(" str_list))
	(setq str_list (concatenate 'string str_list "))"))
	
	
	(with-open-file 
		(str "list.lisp"
			 :direction :output
			 :if-exists :supersede
			 :if-does-not-exist :create
		)
		(format str "")
	)
	
	
	
	(with-open-file 
		(str "list.lisp"
			 :direction :output
			 :if-exists :append
			 :if-does-not-exist :create
		)
		(format str str_list )
	)
				
	(load "list.lisp")		
)

(defun print-to-file( ls file_name )
	
	(with-open-file 
		(str file_name
			 :direction :output
			 :if-exists :supersede
			 :if-does-not-exist :create
		)
		(format str "")
	)	

	(setq size (length ls))
	(loop for i from 0 to (- size 1)
		do(with-open-file 
				(str file_name
					 :direction :output
					 :if-exists :append
					 :if-does-not-exist :create
				)
				(format str "~D " (nth i ls) )
		)
	)
)



;(print (flattener '(a b (c d (e)) g ) ))
(string-to-list)
(setq flattened_list (flattener nested_list))
(print-to-file flattened_list "flattened_list.txt")









