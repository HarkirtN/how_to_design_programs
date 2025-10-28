;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-reader.ss" "lang")((modname fingerexercises_6) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp") (lib "dir.rkt" "teachpack" "htdp")) #f)))
;;finger exercises 6
;;mutually recursive function

(define-struct parent (children name date eyes))

(define gustav (make-parent empty 'gustav 1988 'brown))

  (define fred&eva (list gustav))

(define adam (make-parent empty 'adam 1950 'yellow))
(define dave (make-parent empty 'dave 1955 'black))
(define eva (make-parent fred&eva 'eva 1965 'blue))
(define fred (make-parent fred&eva 'fred 1966 'pink))

  (define carl&bettina (list adam dave eva))

(define carl (make-parent carl&bettina 'carl 1926 'green))
(define bettina (make-parent carl&bettina 'bettina 1926 'green))

;; blue-eyed-parent? : parent -> boolean
(define (blue-eyed-parent? structure) (cond
                                        [(symbol=? 'blue (parent-eyes structure)) true]
                                        [else (blue-eyed-children? (parent-children structure))]))

;; blue-eyed-children? : list -> boolean
(define (blue-eyed-children? aloc) (cond
                                     [(empty? aloc) false]
                                     [else (cond
                                             [(blue-eyed-parent? (first aloc)) true]
                                             [else (blue-eyed-children? (rest aloc))])]))


;;eye-colours : structure list -> list
(define (eye-colours parent) (cond
                               [(empty? parent) empty]
                               [else (cons (parent-eyes parent) (list-eyes (parent-children parent)))]))

(define (list-eyes aloc) (cond
                           [(empty? aloc) empty]
                           [else (append (eye-colours (first aloc)) (list-eyes (rest aloc)))]))
              
                                
                                
;;test
(eye-colours carl) ;; green yellow black blue brown

(define-struct wp (header body))

;; size : webpage -> number
(define (size webpage) (+ (wp-header webpage) (count-symbols (wp-body webpage))))
(define (count-symbols body) (cond
                                  [(empty? body) 0]
                                  [else (+ (count-symbols (rest body)))]))

;;find : webpage symbol -> boolean
;; to determine if symbol occurs in the webpage and produces a list of those headers encountered

(define (find-symbol webpage s) (cond
                                       [(symbol? s (webpage-header webpage)) true]
                                       [else (find-document (webpage-body webpage))]))
(define (find-document pages) (cond
                                [(empty? pages) false]
                                [else (cond
                                        [(find-symbol (first pages)) true]
                                        [(find-document (rest pages)) true]
                                        [else false])]))

(define (find webpage s) (cond
                           [(empty? webpage) empty]
                           [else (local ((define (find-symbol webpage s) (cond
                                                                      [(symbol? s (webpage-header webpage)) true]
                                                                      [else (find-document (webpage-body webpage))]))
                                    (define (find-document pages) (cond
                                                                     [(empty? pages) false]
                                                                     [else (cond
                                                                              [(find-symbol (first pages)) true]
                                                                              [(find-document (rest pages)) true]
                                                                              [else false])])))
      ___________________________________________________________________________________________________________________________________________________________________
                              (list (= (webpage-header webpage) s) (find webpage s)))]))

