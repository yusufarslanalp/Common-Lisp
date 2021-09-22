(setq char_list '() )
(setq char_codes '())

;char_list: ( (x 13) (e 198)....(h 7) )

;char_codes: ( (d "1101") (a "1110")....(f "110") )

;huffmen_tree: 
  ;internal node structure: ;(isim, değer, left right) ör: ("inernal" 145 (..) (..))
  ;leaf node structure: (isim, değer) ör:(s 23)
  
;bu fonksiyon bir dosyadaki tüm satırları okuyarak huffmen_tree'yi oluşturur.
(defun create-huffmen-tree (file_name)
	(setq num_of_line 0)
	(let ((in (open file_name :if-does-not-exist nil)))
	   (when in
		  (loop for line = (read-line in nil)
			while line do ( progn
								(add-line line 0)
								(setq num_of_line (+ 1 num_of_line))
						)
		  )
		  (close in)
	   )
	)
	
	(setq num_of_newline (- num_of_line 1))
	(setq char_list (append char_list (list (list #\Linefeed num_of_newline))))
	
	;(create_new_node 0)
	(setq huffmen_tree char_list)
	
	(loop while (/= (length huffmen_tree)  1) 
	  do (create_new_node 0)
	)	
	
	(setq huffmen_tree (car huffmen_tree))
	
	
	;(print huffmen_tree)
)


;char_list: ( (x 13) (e 198)....(h 7) )
;parametre olarak bir string alır ve aldığı string'e göre char_list listesini günceller.
;size: local değişken
(defun add-line ( line size )
	(setq size (length line))
	(loop for i from 0 to (- size 1)
		;do(print (aref line i))
		do( add-to-list (aref line i) 0 0 )
	)
)



;(isim, değer, left right)
;char_list: ( (x 13) (e 198)....(h 7) )
;bir karakter alır ve char_list i günceller
;size and num is local variable
(defun add-to-list ( char size num )
	(setq size (length char_list))
	(loop for i from 0 to (- size 1)
		do(
			if(string= char (car (nth i char_list))) ;if( char_list[i][0] == char )
				(progn
					(setq num (car (cdr (nth i char_list)))) ;num = char_list[i][1]
					(setf (car (cdr (nth i char_list))) (+ 1 num)) ;char_list[i][1]++
					(return-from add-to-list)
				)
			
			
		)
		;do(print (car (nth i char_list)))
	)
	
	;(print "out of loop")

	;if char is not in the char_list
	;add char to the char_list
	(setq char_list (append char_list (list (list char 1)))) ;char_list.add( '(char 1) )
)

;node dan bir node oluşturur.
(defun create_new_node ( size )
	( setq indexes (find-min-two 0 ) )
	
	( setq first_node (nth (car indexes) huffmen_tree) )
	( setq fn_value (car (cdr first_node)) )
	
	( setq second_node (nth (car (cdr indexes)) huffmen_tree) )
	( setq sn_value (car (cdr second_node)) )
	
	
	
	( setq nn_value (+ fn_value sn_value) )
	;new_node = '( "internal", fn_value+sn_value, huffmen-tree[ indexes[0] ], huffmen-tree[ indexes[1] ] )
	( setq new_node
		(list
			"internal"
			(+ fn_value sn_value)
			first_node
			second_node
		) 
	)
	
	;yeni node'u oluşturmak için kullanılan iki node'u huffmen_tree listesinden sil.
	( setf (nth (car indexes) huffmen_tree) 0 )
	( setf (nth (car (cdr indexes)) huffmen_tree) 0 )
	( setq huffmen_tree ( remove 0 huffmen_tree ) )	
	( setq huffmen_tree (append huffmen_tree (list new_node)))
	
	;(print huffmen_tree)
)

;ls listesinin içerisinde sayılar vardır.
;ls listesinde sayılar haricinde bir tane nil eleman bulunabilir.
;bu fonksiyon en küçük tamsayının indexini return eder.
(defun find-min ( ls size min1 min_index )
	(setq size (length ls)) ;char_list değişebilir

	;if(ls[0] != nil)
	(if (not (equal (car ls) nil))
		(progn
			(setq min1 (car ls))
			(setq min_index 0)
		)
		(progn
			(setq min1 (car (cdr ls)))
			(setq min_index 1)
		)
	)
	
	(loop for i from 0 to (- size 1)
		;if( ls[i] != nil )
		do(if(nth i ls) 
			;if( ls[i]<min1 )
			(if (< (nth i ls) min1 )
				(progn
					(setq min1 (nth i ls))
					(setq min_index i)				
				)
			)
		)
	)	
	
	;(print min1)
	min_index
)


;listedeki en küçük iki sayıyı bulur ve indexlerini return eder
(defun find-min-two ( size )
	(setq size (length huffmen_tree))
	(setq temp_ls '())
	
	;fill all occurences in to temp_ls 
	(loop for i from 0 to (- size 1)
		;temp_ls.add( huffmen_tree[i][1] )
		do( setq temp_ls (append temp_ls (list (car (cdr (nth i huffmen_tree))))) )
	)
	
	
	;listedeki en küçük sayının index ini bul
	;listedeki en küçük sayıyı nil yap
	(setq min1_index (find-min temp_ls 0 0 0))
	(setf (nth min1_index temp_ls) nil)
	
	;listedeki en küçük ikinci sayıyı bul
	(setq min2_index (find-min temp_ls 0 0 0))	
	
	;temp_ls[ min1_index ] = nil
	(setf (nth min1_index temp_ls) nil)
	
	;(print temp_ls)
	(list min1_index min2_index)
)



;huffmen_tree'de gezinerek her karakterin huffmen code'unu bulur.
(defun find-codes ( node code direction )

	;eğer node root node değilse code'a direction ı ekle
	(if (not (equal #\i direction))
		(setq code (concatenate 'string code (list direction)))
	)
	
	;
	(if (equal (length node) 2)
		( setq char_codes (append char_codes (list (list (car node) code))) )
		(progn
			(find-codes (nth 2 node) code #\0)
			(find-codes (nth 3 node) code #\1)
		
		)
	)
)


(defun find-min-code ( codes size min1 len min_index )
	(setq size (length codes))
	(setq min_index 0)
	(setq min1 (length (nth 1 (car codes))))

	(loop for i from 1 to (- size 1)
		do(setq len (length (nth 1 (nth i codes))))
		do(if (<  len min1 )
			(progn
				(setq min1 len)
				(setq min_index i)				
			)
		)
	)	
	
	;(print min_index)
	min_index
)

(defun sort-codes ( codes min_index)
	(setq sorted_codes '())

	;while code is not null
	(loop while codes  
	  do (progn
			(setq min_index (find-min-code codes 0 0 0 0))
			(setq sorted_codes (append sorted_codes (list (nth min_index codes))))
			(setf (nth min_index codes) 0)
			(setq codes ( remove 0 codes ))
		  )
	)
	sorted_codes

)

(defun print-codes-to-file ( input_fname output_fname )
	;char_codes: ( (d "1101") (a "1110")....(f "110") )

	( create-huffmen-tree input_fname )
	;( create-huffmen-tree input_fname )
	
	;huffmen_tree'de gezinerek her karakterin huffmen code'unu bulur.
	;char_codes listesine her kodun huffmen kodunu yazar.
	(find-codes huffmen_tree "" #\i )
	
	;char_codes listesi huffmen kod uzunluğuna göre sıralanır.
	(setq char_codes (sort-codes char_codes 0))
	
	;(print char_codes)
	
	(with-open-file 
		(str output_fname
			 :direction :output
			 :if-exists :supersede
			 :if-does-not-exist :create
		)
		(format str "")
	)
	
	(setq size (length char_codes))
	
	(loop for i from 0 to (- size 1)
		do(with-open-file 
				(str output_fname
					 :direction :output
					 :if-exists :append
					 :if-does-not-exist :create
				)
				;(format str "~D: " (car collatz_seq) )
				(progn
					(cond
						( (equal #\Linefeed (car (nth i char_codes))) (format str "newline: " ) )
						( (equal #\SPACE (car (nth i char_codes))) (format str "space: " ) )
						( t (format str "~C: " (car (nth i char_codes)) ) )

					)
					;(format str "~C: " (car (nth i char_codes)) )
					(format str (nth 1 (nth i char_codes)) )
					;(format str "~D " (nth 1 (nth i char_codes)) )
					(format str "~%")
				
				)
		)
	)

)

(print-codes-to-file "paragraph.txt" "huffman_codes.txt" )
