(require toups/toups toups/functional toups/list srfi/13)

(define j8-new-lines
  (sys "cat j8_new.hoc"))

(define (pt3dadd-line? line)
  (and (> (string-length (string-trim-both line)) (string-length "pt3dadd"))
       (equal?
        "pt3dadd"
        (substring (string-trim-both line) 0 (string-length "pt3dadd")))))
   
(define (pt3dclear-line? line)
  (and (> (string-length (string-trim-both line)) (string-length "pt3dclear"))
  (equal?
   "pt3dclear"
   (substring (string-trim-both line) 0 (string-length "pt3dclear")))))

(define (section-indicator? line)
  (let ((trimmed (string-trim-both line)))
    (or (and (>= (string-length trimmed) 4)
             (equal? "soma" (substring trimmed 0 4)))
        (and
         (> (string-length trimmed) 2)
         (equal? "a" (substring trimmed 0 1))
         (or
          (equal? "1" (substring trimmed 1 2))
          (equal? "2" (substring trimmed 1 2))
          (equal? "3" (substring trimmed 1 2))
          (equal? "4" (substring trimmed 1 2)))))))

(define (string-contains? what string)
  (regexp-match what string))

(define (keeper? line)
  (and
   (not (string-contains? "connect" line))
   (not (string-contains? "diam" line))
   (or
    (section-indicator? line)
    (pt3dadd-line? line))))

(define (fixup-line line)
  (cond
   ((section-indicator? line)
    (let ((trimmed (string-trim-both line)))
      (substring trimmed 0 (- (string-length trimmed) 2))))
   ((pt3dadd-line? line)
    (let ((trimmed (string-trim-both line)))
      (foldl (plx regexp-replace* #f #f " ")
             (substring trimmed (string-length "pt3dadd(") (string-length trimmed))
             (list "," #rx"\\)"))))))

(define output (reverse
 (foldl
  (fn (it ac)
      (cond
       ((and (symbol? (cadr it)) (eq? (cadr it) 'end-sigil)) (cons (string-append (fixup-line (car it)) "];") ac))
       ((section-indicator? (car it)) (cons (string-append (fixup-line (car it)) " = [ ") ac))
       ((section-indicator? (cadr it)) (cons (string-append (fixup-line (car it)) " ];") ac))
       (else (cons (string-append (fixup-line (car it)) ";") ac))))
  '()
  (let ((lines (filter keeper? j8-new-lines)))
    (zip lines (append (cdr lines) (list 'end-sigil)))))))

(with-output-to-file "./j8geom_data.m"
    (fn ()
        (for-each (fn (it) (display (format "~a" it)) (newline)) output)))
