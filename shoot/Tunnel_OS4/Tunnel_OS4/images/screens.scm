(define (tunnel-splash prefix)
  (let* ((image (car (gimp-image-new 640 480 RGB)))
         (drawable (car (gimp-layer-new image 640 480 RGB_IMAGE
                                        "Layer" 100 NORMAL)))
         (text-size 18)
         (indent 100)
         (text-x 300)
         (text-y 25)
         (text-skip 23)
         (text-par-skip 15)
         (light 45)
	 (head-fontname "-urw-gothic l-demi bold-r-normal-*-*-180-*-*-*-*-*-*")
	 (light-fontname "-urw-bookman-light-r-normal-*-*-180-*-*-*-*-*-*")
	 (demibold-fontname "-urw-bookman-demibold-r-normal-*-*-180-*-*-*-*-*-*")
         (ball (lambda (cx cy r col alpha)
                 (tunnel-ball-ellipse image (- cx r) (- cy r) (* r 2) (* r 2)
                                      REPLACE TRUE)
                 (tunnel-ball-shade (list image drawable) cx cy r light
                                    col alpha)))
	 (write-center (lambda (text cx by fontname size)
			 (let* ((extents (gimp-text-get-extents-fontname text
									 size
									 PIXELS
									 fontname))
				(x (- cx (/ (car extents) 2)))
				(y (- by (cadr extents))))
			   (gimp-text-fontname image drawable x y text -1 TRUE
					       size PIXELS fontname))))
	 (write-left (lambda (text lx by fontname size)
			 (let* ((extents (gimp-text-get-extents-fontname text
									 size
									 PIXELS
									 fontname))
				(x lx)
				(y (- by (cadr extents))))
			   (gimp-text-fontname image drawable x y text -1 TRUE
					       size PIXELS fontname))))
	 (write-right (lambda (text rx by fontname size)
			 (let* ((extents (gimp-text-get-extents-fontname text
									 size
									 PIXELS
									 fontname))
				(x (- rx (car extents)))
				(y (- by (cadr extents))))
			   (gimp-text-fontname image drawable x y text -1 TRUE
					       size PIXELS fontname)))))
    (gimp-image-add-layer image drawable 0)
    (gimp-palette-set-background '(0 0 0))
    (gimp-edit-fill drawable BG-IMAGE-FILL)

    ; punch
    (ball 400 220 35 '(99 184 255) 100)
    ; bullet 1
    (ball 507 348 24 '(50 250 50) 100)
    ; bullet 2
    (ball 395 300 27 '(50 250 50) 100)
    ; tickler
    (ball 380 350 45 '(222 184 135) 100)
    ; speedy
    (ball 440 180 47 '(255 215 0) 100)
    ; crazy
    (ball 530 300 50 '(205 92 92) 100)
    ; crawler
    (ball 280 330 50 '(132 112 255) 100)
    ; bullet 3
    (ball 255 240 30 '(50 250 50) 100)
    ; ship
    (ball 115 180 65 '(255 131 250) 40)
    (ball 115 180 13 '(255 131 250) 100)
    (ball 115 180 65 '(255 131 250) 40)

    (gimp-palette-set-foreground '(255 69 0))
    (write-center "TUNNEL" 320 75 head-fontname 48)
    (gimp-palette-set-foreground '(255 69 0))
    (write-right "© 2000-2004 Trevor Spiteri" 630 470 demibold-fontname 20)

    (tunnel-save (list image (car (gimp-image-flatten image)))
                 (string-append prefix "splash"))))

(define (tunnel-pause prefix)
  (let* ((imdr (tunnel-new 640 480))
         (extents (gimp-text-get-extents-fontname "PAUSED" 48 PIXELS
						  "-urw-gothic l-demi bold-r-normal-*-*-180-*-*-*-*-*-*"))
         (x (- 320 (/ (car extents) 2)))
         (y (- 240 (/ (cadr extents) 2))))
    (gimp-palette-set-background '(0 0 0))
    (gimp-palette-set-foreground '(255 69 0))
    (gimp-rect-select (car imdr) 0 0 640 480 REPLACE FALSE 0)
    (gimp-bucket-fill (cadr imdr) BG-BUCKET-FILL NORMAL-MODE 50 0 0 0 0)
    (gimp-text-fontname (car imdr) (cadr imdr) x y "PAUSED" 0 TRUE 48 PIXELS
			"-urw-gothic l-demi bold-r-normal-*-*-180-*-*-*-*-*-*")
    (let* ((im (car imdr))
           (dr (car (gimp-image-merge-visible-layers im CLIP-TO-IMAGE)))
           (id (list im dr)))
      (tunnel-save id (string-append prefix "paused")))))

(define (tunnel-wait prefix)
  (let* ((imdr (tunnel-new 640 480))
	 (extents (gimp-text-get-extents-fontname "PLEASE WAIT" 48 PIXELS
						  "-urw-gothic l-demi bold-r-normal-*-*-180-*-*-*-*-*-*"))
         (x (- 320 (/ (car extents) 2)))
         (y (- 240 (/ (cadr extents) 2))))
    (gimp-palette-set-background '(0 0 0))
    (gimp-palette-set-foreground '(255 69 0))
    (gimp-rect-select (car imdr) 0 0 640 480 REPLACE FALSE 0)
    (gimp-bucket-fill (cadr imdr) BG-BUCKET-FILL NORMAL-MODE 50 0 0 0 0)
    (gimp-text-fontname (car imdr) (cadr imdr) x y "PLEASE WAIT" 0 TRUE 48
			PIXELS
			"-urw-gothic l-demi bold-r-normal-*-*-180-*-*-*-*-*-*")
    (let* ((im (car imdr))
           (dr (car (gimp-image-merge-visible-layers im CLIP-TO-IMAGE)))
           (id (list im dr)))
      (tunnel-save id (string-append prefix "wait")))))

(define (tunnel-screens prefix)
  (tunnel-splash prefix)
  (tunnel-pause prefix)
  (tunnel-wait prefix))
