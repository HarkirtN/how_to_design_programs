;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |practice #7|) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "guess-gui.rkt" "teachpack" "htdp") (lib "guess.rkt" "teachpack" "htdp") (lib "draw.rkt" "teachpack" "htdp")) #f)))
;; list with structure
;; to compute sum of toys from inventory list

;;Fist define the structure so you can extract info
(define-struct inventory (name price))

  ;;second : template for sum
  ;;(define (sum inv-list) (cond
                         ;;[(empty? inv-list) ...]
                         ;;[...(first inv-list)... (sum (rest inv-list)) ...]))

        (define (sum inv-list) (cond
                         [(empty? inv-list) 0]
                         [else (+ (inventory-price (first inv-list)) (sum (rest inv-list)))]))

;;Exercise 10.2.1
;; contains-doll? : inventory -> boolean
;; to compute whether inv-list contains a record for doll
(define (contains-doll? inv-list) (cond
                                    [(empty? inv-list) false]
                                    [else (cond
                                            [(symbol=? 'doll (inventory-name (first inv-list)))true]
                                            [else (contains-doll? (rest inv-list))])]))

;;Exercise 10.2.2
;; to create a inventory list with a picture that represents the object
(define-struct ol (symbol price picture))

;; to create a function 'show-picture' that takes the symbol and name of the toy from an inventory list to create a picture from the web
(define (show-picture symbol ol) (cond
                                     [(empty? ol) true]
                                     [(symbol=? 'robot (ol-symbol (first ol))) 'picture]
                                     [(symbol=? 'doll (ol-symbol (first ol))) 'picture]
                                     [(symbol=? 'rocket (ol-symbol (first ol))) 'picture]
                                     [else false]))

;; Exercise 10.2.3
(define (price-of symbol ol) (cond
                            [(empty? ol) true]
                            [(symbol=? 'robot (ol-symbol (first ol))) 11.95]
                            [(symbol=? 'doll (ol-symbol (first ol))) 19.95]
                            [(symbol=? 'rocket (ol-symbol (first ol))) 29.95]
                            [else false]))

;;extracting list of inventories and creating a seperate list with items that cost less than $1
;;extract1 : inv-list -> inv-list
;;template : (define (extract1 inv-list) (cond
                              ;;[(empty? inv-list) ...]
                              ;;[else (inventory-price (first inv-list)) ...(extract1 (rest inv-list))...]))

(define (extract1 inv-list) (cond
                              [(empty? inv-list) empty]
                              [(<= (inventory-price (first inv-list)) 1.00)
                                   (cons (first inv-list)(extract1 (rest inv-list)))]
                              [else (extract1 (rest inv-list))]))

;;Exercise 10.2.5
;; create function that extracts items above $1 and create a seperate list
;; extract2 : inv-list -> inv-list
(define (extract2 inv-list) (cond
                              [(empty? inv-list) empty]
                              [(> (inventory-price (first inv-list)) 1.00)
                               (cons (first inv-list) (extract2 (rest inv-list)))]
                              [else (extract2 (rest inv-list))]))

;;Exercise 10.2.6
;; data definition = inventory1 function is a list of one-dollar stores
;; inventory1 : inv-list -> inv-list1
;; template : (define (inventory1 inv-list) ...)

;;Exercise 10.2.7
;; to create a inventory list with a 5% increase in prices from original list
;; raise-prices : inv-list -> inv-list2
;; (define (raise-prices inv-list) (cond
                                  ;; [(empty? inv-list) empty]
                                   ;;[...(first inv-list) ...(raise-prices (rest inv-list)) ...]))

(define (raise-prices inventory) (cond
                                  [(empty? inventory) empty]
                                  [else ( cons ( * 0.05( inventory-price (first inventory))) (raise-prices (rest inventory)))]))
;; test
(raise-prices ( cons (make-inventory 'toy3 100.00)
                                     (cons ( make-inventory 'toy2 10.00)
                                       (cons (make-inventory 'toy1 1.00)
                                           empty))))

;;Exercise 10.1.6
;; data definition = function 'name-robot' changes 'robot to 'r2d2
;; name-robot : list -> list
;; tenplate :
(define (name-robot a-list) (cond
                              [(empty? a-list) empty]
                              [(symbol=? 'robot (first a-list)) (cons 'r2d2 (name-robot (rest a-list)))]
                              [else (cons (first a-list) (name-robot (rest a-list)))]))
;;test
(name-robot (cons 'doll
                  (cons 'robot
                        (cons 'doll
                              (cons 'dress empty)))))

;;Exercise 10.1.7
;; recall function eliminates any toys called 'ty' from list 'lon'
(define (recall ty lon) (cond
                          [(empty? lon) empty]
                          [(not (symbol=? 'ty (first lon)))
                           (cons (first lon) (recall ty (rest lon)))]
                          [else (recall ty (rest lon))]))

;;test
(recall 'robot (cons 'robot
                  (cons 'doll
                        (cons 'dress empty))))
