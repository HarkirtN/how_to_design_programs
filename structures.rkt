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
(define (increase-in-sales a-star) (make-star (star-last a-star) (star-first a-star) (star-instrument a-star) (+ (star-sales a-star) 2000)))

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

;;exercise 6.4.1
;;data definitions
;;(define-struct movie (title producer))
;;data definition = (symbol, symbol)

;;(define-struct cheerleader (name number))
;;data definition = (symbol, number)

(define-struct time (hours minutes second))
;;data definition = (number, number, number)

;;Exercise to substitute teacher fritz with elise in all student records associated to fritz
;; define structure for student
;; (define-struct student (last first teacher))

;; substitute teacher : student symbol -> student 

;; example: (make-student 'flich 'mathew 'fritz) -> (sub-teacher (make-student 'flich 'mathew 'fritz) 'elise)

;;Definition
(define (sub-teacher a-student a-teacher) (cond
                                            [symbol=? (student-teacher a-student) 'fritz]
                                            (make-student (student-last a-student)
                                                          (student-first a-student)
                                                          a-teacher))
