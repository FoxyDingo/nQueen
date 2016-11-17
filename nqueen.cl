(in-package :user)

(defun resolve-problema (estado-inicial procura)
  (defvar *linhas* nil)
 
  (setf *linhas* (length estado-inicial))
  
  (let (
        (estado estado-inicial)
        (problema '())
        (resultado '())
        (estado-final '()))
    (setf problema (cria-problema estado (list 'coloca-rainha)
                                  :objectivo? #'fnc-objectivo
                                  :estado= #'equalp
                                  :hash #'hash
                                  :heuristica #'heuristica))
    (if (equalp procura 'profundidade) (setf resultado (procura problema procura :profundidade-maxima 6 :espaco-em-arvore? t))
      (setf resultado (procura problema procura :espaco-em-arvore? t)))
   
    (if (equalp (car resultado) nil) (return-from resolve-problema nil) (progn
    (setf estado-final (car resultado)) 
    (return-from resolve-problema (car (last estado-final)))))))
   
(defun hash (estado)
   estado)

(defun ameaca (i j a b)
  (if (not (and (= i a) (= j b)))
    (or (= i a)
      (= j b)
      (= (- i j) (- a b))
      (= (+ i j) (+ a b)))))

(defun rainha? (estado linha)
  (return-from rainha? (not (equalp (nth linha estado) nil))))

(defun conta-ameacas (estado linha)
  (let ((contAmeacas 0)
      (coluna 0)
      (coluna2 0))
    (setf coluna (nth linha estado))
    (dotimes (linha2 *linhas*)
      (if (rainha? estado linha2)
        (progn (setf coluna2 (nth linha2 estado))
          (if (ameaca linha coluna linha2 coluna2)
            (setf contAmeacas (+ contAmeacas 1))))))
    (return-from conta-ameacas contAmeacas)))

(defun heuristica (estado)
  (let ((contAmeacas 0)
      (contRainhas 0)
      )
    (dotimes (linha *linhas*)
      (if (rainha? estado linha)
        (progn 
          (setf contRainhas (+ contRainhas 1))
          (setf contAmeacas (+ contAmeacas (conta-ameacas estado linha))))))
    (setf contRainhas (- *linhas* contRainhas))
    (setf contAmeacas (/ contAmeacas 2))
    (return-from heuristica (+ contRainhas contAmeacas))))

(defun fnc-objectivo (estado)
  (let ((contAmeacas 0)
    
    (contRainhas 0))
    (dotimes (linha *linhas*)
      (if (rainha? estado linha)
        (progn (setf contRainhas (+ contRainhas 1))
         
          (setf contAmeacas (+ contAmeacas (conta-ameacas estado linha))))))
    (if (and (= contAmeacas 0) (= contRainhas *linhas*)) t nil)))

(defun copia-estado (estado)
  (let ((resultado (make-list *linhas*)))
    (dotimes (linha *linhas*)
      (if (rainha? estado linha)
        (setf (nth linha resultado) (nth linha estado))))
    (return-from copia-estado resultado)))

(defun coloca-rainha (estado)
  (let ((lista-estados '()))
    (dotimes (linha *linhas*)
      (block check
        (if (rainha? estado linha)
          (return-from check t)
          (setf lista-estados (gera-estados estado linha)))))
    (return-from coloca-rainha lista-estados)))

(defun gera-estados (estado linha)
  (let (
    (tmp-estado '())
    (lista-estados '() ))
  (dotimes (coluna *linhas*)
    (setf tmp-estado (copia-estado estado))
    (setf (nth linha tmp-estado) coluna)
    (push tmp-estado lista-estados))
  (return-from gera-estados lista-estados)))


