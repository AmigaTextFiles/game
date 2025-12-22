(define (tunnel-map proc seq)
  (if (null? seq)
      '()
      (cons (proc (car seq))
	    (tunnel-map proc (cdr seq)))))

(define tunnel-for-each
  (lambda (proc seq . seqmore)
    (if (not (null? seq))
        (begin
          (apply proc (append (list (car seq)) (tunnel-map car seqmore)))
          (apply tunnel-for-each (append (list proc (cdr seq))
                                         (tunnel-map cdr seqmore)))))))

(define (tunnel-save imdr filename)
  (let ((image (car imdr))
        (drawable (cadr imdr)))
    (file-png-save 1 image drawable (string-append filename ".png")
                   "" FALSE 9 FALSE FALSE FALSE FALSE FALSE)))

(define (tunnel-new w h)
  (let* ((image (car (gimp-image-new w h RGB)))
	 (drawable (car (gimp-layer-new image w h RGBA_IMAGE
                                        "Layer" 100 NORMAL))))
    (gimp-image-add-layer image drawable 0)
    (gimp-edit-clear drawable)
    (list image drawable)))

(define (tunnel-all prefix)
  (tunnel-balls prefix)
  (tunnel-frame perfix)
  (tunnel-lines prefix)
  (tunnel-screens prefix)
  (tunnel-text prefix))
