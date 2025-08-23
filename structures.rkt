;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname structures) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; exercise structures
;;(define-struct posn (x y))
(define-struct entry (name zip phone))
(define-struct movie (title producer))
(define-struct star (last first instrument sales))

;; placing within a larger folder
(define a-posn (make-posn 5 6))
(define phonebook (make-entry 'peterlee 15230 '606-771))

;;extracting information
(posn-x a-posn)
(entry-phone phonebook)

;; to make/modify an entry for a star but has $2000 increase in sales -> here is the definition
;;define the increase in sales i.e.
(define (increase-in-sales a-star) (make-star (star-last a-star)
                                              (star-first a-star)
                                              (star-instrument a-star)
                                              (+ (star-sales a-star) 2000)))

(define-struct jetfighter (designation acceleration topspeed range))

;; within-range : record -> record
;; to determine whether the fighter can achieve intended target 
(define (within-range a-jetfighter target-distance) (make-jetfighter (jetfighter-designation a-jetfighter)
                                                                   (jetfighter-acceleration a-jetfighter)
                                                                   (jetfighter-topspeed a-jetfighter)
                                                                   (<= target-distance (jetfighter-range a-jetfighter))))

(define (reduce-range jetfighter) (make-jetfighter (jetfighter-designation jetfighter)
                                                   (jetfighter-acceleration jetfighter)
                                                   (jetfighter-topspeed jetfighter)
                                                   ( - (jetfighter-range jetfighter) (* jetfighter 0.8))))

;;range 500 - to reduce this by 80% = 500 - (500 x 0.80)


;;Exercise 6.4.1
  ;;data definitions
  ;;(define-struct movie (title producer))
  ;;data definition = (symbol, symbol)

  ;;(define-struct cheerleader (name number))
  ;;data definition = (symbol, number)

(define-struct time (hours minutes seconds))
;;data definition = (number, number, number)

;;Exercise to substitute teacher fritz with elise in all student records associated to fritz
 ;; define structure for student
   (define-struct student (last first teacher))
  ;; substitute teacher : student symbol -> student 
   ;; example: (make-student 'flich 'mathew 'fritz) -> (sub-teacher (make-student 'flich 'mathew 'fritz) 'elise)


(define (sub-teacher a-student a-teacher) (cond
                                            [(symbol=? (student-teacher a-student) 'fritz)
                                            (make-student (student-last a-student)
                                                          (student-first a-student)
                                                          a-teacher)]
                                            [else a-student]))


;;Exercise 6.5.1 templates
 (define-struct boyfriend (name hair eyes phone))
  ;; boyfriend : boyfriend symbol -> boyfriend symbol 
  ;; template
  ;;(define boyfriend (make-boyfriend (make-boyfriend name)
                                  ;;(make-boyfriend hair)
                                  ;;(make-boyfriend eyes)
                                  ;;(make-boyfriend phone)))
  ;; time into seconds
  ;; time-to-seconds : time structure -> time 
(define (time-to-seconds time) (make-time (* 3600 (time-hours time))
                                            (* 60 (time-minutes time))
                                            (time-seconds time)))


;;Exercise 6.6.1
  ;; to develop coloured circles
  ;; structure definition to incorporate centre, radius, colour
  (define-struct circle (centre radius colour))
      ;; data definition circle = (structure, number, symbol)

;; Template
           (define (fun-for-circle a-circle) (... (circle-centre a-circle)...
                                            ... (circle-radius a-circle)...
                                            ... (circle-colour a-circle)...))

          (define (draw-a-circle circle) (make-circle (circle-centre circle)
                                                      (circle-radius circle)
                                                      (circle-colour circle)))


(make-circle (make-posn 20 20) 5 'red)

(start 300 300)
(draw-a-circle (make-circle (make-posn 20 20) 5 'red))

  ;; to calculate whether the pixel is within the circle
  ;;if pixels distance to the centre is less or equal to radius of circle = in the circle
;; posn - circle centre


;;(define (posn-minus lhs rhs) (lhs ( - ( posn-x a-posn) (posn-X circle-centre))) (rhs( - (posn-y a-posn) (posn-y circle-centre))))
(define (posn-minus lhs rhs) (make-posn (- (posn-x lhs) (posn-x rhs)) (- (posn-y lhs) (posn-y rhs))))
(define (hypot posn) (+ (* (posn-x posn) (posn-x posn)) (* (posn-y posn) (posn-y posn))))


(define (in-circle circle a-posn) (<= (hypot (posn-minus (circle-centre circle) a-posn)) (* (circle-radius circle) (circle-radius circle))))
  ;; (define (in-circle circle a-posn) (cond 
                                ;; [ ( <= ((sqr ( - (posn-X a-posn)(posn-X circle)) + ( sqr ( - (posn-Y a-posn) (posn-Y circle))) circle-radius circle) 'inside)]
                                 ;;[ else 'outside]))

;; centre is the circle that is right to the number of pixels 
(define (translate-circle circle delta) (make-circle ( make-posn (+ delta (posn-x (circle-centre circle)))
                                                      (posn-y (circle-centre circle))) 
                                                      (circle-radius circle)
                                                      (circle-colour circle)))

;; to clear a circle
(define (clear-a-circle circle) (clear-circle (make-circle (circle-centre circle)
                                                             (circle-radius circle)
                                                             (circle-colour circle))))

;; to draw then wait then clear a circle
(define (draw-and-clear-circle circle) (and (make-circle (circle-centre circle)
                                                      (circle-radius circle)
                                                      (circle-colour circle))
                                              (sleep-for-a-while ...)
                                              (clear-circle (circle-centre circle)
                                                             (circle-radius circle)
                                                             (circle-colour circle))))
                                          
;;move circle : number circle -> circle
;;to draw and clear a circle, translate it by delta pixels
(define (move-circle delta circle) (cond
                                       [(draw-and-clear-circle circle) (translate-circle circle delta)]
                                       [else circle]))

(start 200 100)
(draw-a-circle (move-circle 10 (move-circle 10 (move-circle 10 (move-circle 10 (make-circle (make-posn 20 20) 5 'red))))))



