;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname fingerexercises_2) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;;finger exercises
;; functions for compound data

   ;; subst-teacher : student symbol -> student
   ;; define structure first
(define-struct student (last first teacher))

;; to replace previous teacher with new teacher
(define (replace a-student a-teacher) (cond
                                        [(symbol=? 'Fritz (student-teacher a-student))
                                         (make-student (student-last a-student)
                                                       (student-first a-student)
                                                        a-teacher)]
                                        [else a-student]))

;; check student structure for teacher's name, return student's last name if there is a match with teacher or otherwise 'none
(define (check a-student a-teacher) (cond
                                      [(symbol=?  (student-teacher a-teacher) a-teacher)
                                       (student-last a-student)]
                                      [else 'none]))

;;replace the previous teacher with a new one in the student structure
(define (transfer a-student a-teacher) (make-student (student-last a-student)
                                                     (student-first a-student)
                                                     'harper))

;;convert time -> seconds
(define-struct time (hours minutes seconds))
(define (convert-to-seconds time) (make-time (* 3600(time-hours time))
                                             (* 60 (time-minutes time))
                                             (time-seconds time)))

;;within range : to determine whether fighter jet can achieve the range
(define-struct jetfighter (destination acceleration top-speed distance))
(define (within-range a-jetfighter target-distance) (cond
                                     [(<= target-distance (jetfighter-distance a-jetfighter)) a-jetfighter]
                                     [else 'notInRange]))

;; create a coloured circle
(define-struct circle (centre radius colour))

(define (coloured-circle a-circle) (draw-circle (circle-centre a-circle)
                                                (circle-radius a-circle)
                                                (circle-colour a-circle)))

(define (translate-circle a-circle delta) (make-circle (make-posn (+ delta (posn-x (circle-centre a-circle)))
                                                                           (posn-y (circle-centre a-circle)))
                                                       (circle-radius a-circle)
                                                       (circle-colour a-circle)))

(define (clear-a-circle a-circle) (clear-circle (circle-centre a-circle)
                                                (circle-radius a-circle)
                                                'white))

(define (draw-and-clear a-circle) (and (coloured-circle a-circle)
                                       (sleep-for-a-while 1)
                                       (clear-a-circle a-circle) true))


(start 200 200)
(define real-circle (make-circle (make-posn 100 100) 30 'blue))
(coloured-circle real-circle)
(draw-and-clear real-circle)

;;create a coloured rectangle
(define-struct rectangle (posn width height colour))

;;template
(define (fun-for-rect a-rectangle) (...(rectangle-posn a-rectangle)
                               (rectangle-width a-rectangle)
                               (rectangle-height a-rectangle)
                               (rectangle-colour a-rectangle)))

(define (draw-a-rectangle a-rectangle) (draw-solid-rect (rectangle-posn a-rectangle)
                                                        (rectangle-width a-rectangle)
                                                        (rectangle-height a-rectangle)
                                                        (rectangle-colour a-rectangle)))
;;to find whether a pixel is within a rectangle

(define (posn-minus lhs rhs) (- (- (posn-x lhs) (posn-x rhs)) (- (posn-y lhs) (posn-y rhs))))

;;(define (right-hand? posn rectangle-width rectangle-height) (* rectangle-width (posn-minus lhs rhs) rectangle-height))

;;(define (in-rectangle? a-rectangle pixel) (cond
                                             ;;[(and (< (right-hand? (posn-minus pixel (rectangle-posn a-rectangle))
                                                                 ;;  (rectangle-width a-rectangle)
                                                                   ;;(rectangle-height a-rectangle)) rectangle-posn)
                                                 ;; (> pixel (rectangle-width))
                                                  ;;(> pixel (rectangle-height))) 'inRectangle]
                                             ;;[else a-rectangle]))

(define (translate-rectangle a-rectangle delta) (make-rectangle (make-posn ( + (posn-x a-rectangle) delta)
                                                                           (posn-y a-rectangle))
                                                                (rectangle-width a-rectangle)
                                                                (rectangle-height a-rectangle)
                                                                (rectangle-colour a-rectangle)))

(define (clear-a-rect a-rectangle) (clear-solid-rect (rectangle-posn a-rectangle)
                                                     (rectangle-width a-rectangle)
                                                     (rectangle-height a-rectangle)
                                                     'white))

(define (draw-and-clear-rect a-rectangle) (and (draw-a-rectangle a-rectangle)
                                                (sleep-for-a-while 1)
                                                (clear-a-rect a-rectangle) true))
                                    
(start 300 300)
(define tangle (make-rectangle (make-posn 10 150) 50 100 'purple))
(draw-a-rectangle tangle)

(number? (make-posn 2 3))

(define-struct circle (center radius))

(define-struct square (posn length))

;;perimeter - to compute perimeter dependent on the type of shape
;;perimeter : shape -> number
;;template
(define (perimeter a-shape) (cond
                              [(circle? a-shape) ( * pi ( sqr (circle-radius a-shape)))]
                              [(square? a-shape) (* 4 (square-length a-shape))]))

(define (area a-shape) (cond
                         [(circle? a-shape) (* pi (sqr (circle-radius a-shape)))]
                         [(square? a-shape) (sqr (square-length a-shape))]))

