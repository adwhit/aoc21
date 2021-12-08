(define input (get-string-all (open-input-file "data/06")))

(define (get-numbers s)
  (filter
   (lambda (n) (< 0 n))
   (map (lambda (n) (- (char->integer n) (char->integer #\0))) (string->list s))
))

(define test-start '(3 4 3 1 2))

(define (dbg x) (printf "~A \n" x) x)

(define (join l1 l2)
  (if (null? l1)
      l2
      (cons (car l1) (join (cdr l1) l2))))

(define (tick fish)
  (let* ((newlist (cdr fish))
         (newfish (car fish)))
    (join (add-at 7 newlist newfish) (list newfish))))

(define (iterate count func inp)
  (if (> count 1)
      (iterate (sub1 count) func (func inp))
      inp)
)

(define init-counts '(0 0 0 0 0 0 0 0 0))

(define (add-at index l qty)
  (if (eq? index 1)
      (cons (+ qty (car l))
            (cdr l))
      (cons (car l)
            (add-at (sub1 index) (cdr l) qty))))

(define (length l) (if (null? l) 0 (add1 (length (cdr l)))))

;; (display (count (iterate 100 tick (get-numbers input))))

(define (starting-counts counts input)
  (if (null? input)
      counts
      (starting-counts (add-at (car input) counts 1) (cdr input))
      ))

(define (sum-list l) (fold-right + 0 l))

(let* (
      (small-start (starting-counts init-counts test-start))
      (big-start (starting-counts init-counts (get-numbers input)))
      (out-list (iterate 80 tick big-start))
      (out-list-big (iterate 256 tick big-start))
      )
  (printf "ex06 pt 1 ~A\n" (sum-list out-list))
  (printf "ex06 pt 2 ~A\n" (sum-list out-list-big))
)

(exit)
