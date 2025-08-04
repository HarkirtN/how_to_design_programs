;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname practice#2) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp")) #f)))
;;Exercise 3.2.1 

;; Contract : inches to cm : number -> number
 ;; Purpose : to compute inches to cm 
  ;; Example : (inches-to-cm 1) should produce 2.54
   ;; Definition : [conversion to cm]
      (define (inches-to-cm cm) (* cm 2.54))
    ;;Test :
          (inches-to-cm 1)
     ;; expected value
          ;;2.54 cm

;; Feet to inches : number -> number
  ;; Example : (feet-to-inches 1) should produce 12 in
   ;; Definition : [conversion to inches]
      (define (feet-to-inches in) (* in 12))
    ;;Test :
          (feet-to-inches 1)
     ;; expected value
          ;;12 in

;; Yard to feet : number -> number
  ;; Example : (yard-to-feet 1) should produce 3 ft
   ;; Definition : [conversion to feet]
      (define (yard-to-feet ft) (* ft 3))
    ;;Test :
          (yard-to-feet 1)
     ;; expected value
          ;;3 ft

;; rods to yards : number -> number
  ;; Example : (rods-to-yards 1) should produce 5.5 yd
   ;; Definition : [conversion to yards]
      (define (rods-to-yards yd) (* yd 5.5))
    ;;Test :
          (rods-to-yards 1)
     ;; expected value
          ;;5.5 yd

;; furlongs to rods : number -> number
  ;; Example : (furlongs-to-rods 1) should produce 40 rd
   ;; Definition : [conversion to rods]
      (define (furlongs-to-rods rd) (* rd 40))
    ;;Test :
          (furlongs-to-rods 1)
     ;; expected value
          ;;40 rd

;; miles to furlongs : number -> number
  ;; Example : (miles-to-furlongs 1) should produce 8 fl
   ;; Definition : [conversion to furlongs]
      (define (miles-to-furlongs fl) (* fl 8))
    ;;Test :
          (miles-to-furlongs 1)
     ;; expected value
          ;;8 fl

;; feet to cm : number -> number
  ;; Example : (feet-to-cm 1) should produce 30.48
   ;; Definition : [conversion to cm]
     (define (feet-to-cm feet) ( inches-to-cm(feet-to-inches feet)))
    ;;Test :
          (feet-to-cm 1)
     ;; expected value
        ;;30.48

;; yards to cm : number -> number
  ;; Example : (yards-to-cm 1) should produce 91.44
   ;; Definition : [conversion to cm]
     (define (yards-to-cm yards) (inches-to-cm (feet-to-inches(yard-to-feet yards))))
    ;;Test :
          (yards-to-cm 1)
     ;; expected value
        ;;91.44

;; rods to inches : number -> number
  ;; Example : (rods-to-inches 1) should produce 198
   ;; Definition : [conversion to inches]
     (define (rods-to-inches rods) (feet-to-inches (yard-to-feet(rods-to-yards rods))))
    ;;Test :
          (rods-to-inches 1)
     ;; expected value
        ;;198

;; miles to feet : number -> number
  ;; Example : (miles-to-feet 1) should produce 5280
   ;; Definition : [conversion to feet]
     (define (miles-to-feet miles) ( yard-to-feet(rods-to-yards (furlongs-to-rods(miles-to-furlongs miles)))))
    ;;Test :
          (miles-to-feet 1)
     ;; expected value
        ;;5280