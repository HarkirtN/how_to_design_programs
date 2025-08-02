;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname composing_functions) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;; length measurements : number -> number

;; to compute length measurements into metric equilvalents

;;example: (inch 1) should produce 2.54 cm

;; defeinition [conversion]
(define (inch-to-cm i) (* i 2.54))

(define (foot-to-inches x) (* x 12))

(define (yard-to-feet y) (* y 3))

(define (rods-to-yards z) (* z 5.5))

(define (furlong-to-rods f) (* f 40))

(define (miles-to-furlongs m) (* m 8))

;; Example:
;;    (feet-to-cm 1) => 30.48
;;    (* 2.54 (* 12 1))
(define (feet-to-cm feet) (inch-to-cm (foot-to-inches feet)))

;; Example:
;;    (yard-to-cm 1) => 91.44
;;    ( * 2.54 (* 12 (*3 1)))
(define (yard-to-cm yard) (inch-to-cm(foot-to-inches(yard-to-feet yard))))

(define (rods-to-inches rods) (foot-to-inches(yard-to-feet(rods-to-yards rods))))

(define (miles-to-feet miles) (yard-to-feet(rods-to-yards (furlong-to-rods(miles-to-furlongs miles)))))