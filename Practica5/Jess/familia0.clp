(deffacts inicio
    (dd juan maria rosa m)
    (dd juan maria luis h)
    (dd jose laura pilar m)
    (dd luis pilar miguel h)
    (dd miguel isabel jaime h)
    (dd pedro rosa pablo h)
    (dd pedro rosa begoña m))

(defrule padre
    (dd ?x ? ?y ?)
    =>
    (assert (padre ?x ?y)))

(defrule madre
    (dd ? ?x ?y ?)
    =>
    (assert (madre ?x ?y)))

(defrule hijo1
	(dd ?y ? ?x h)
	=>
    (assert (hijo ?x ?y)))

(defrule hijo2
	(dd ? ?y ?x h)
	=>
    (assert (hijo ?x ?y)))

(defrule hija1
	(dd ?y ? ?x m)
	=>
    (assert (hija ?x ?y)))

(defrule hija2
	(dd ? ?y ?x m)
	=>
    (assert (hija ?x ?y)))


(reset)
(run)
(facts)
