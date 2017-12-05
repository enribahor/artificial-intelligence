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

(defrule hermano1
    (dd ?x ?y ?z h)
    (dd ?x ?y ?j ?)
    (test (neq ?z ?j))
    =>
    (assert (hermano ?z ?j)))
        
(defrule hermana1
    (dd ?x ?y ?z m)
    (dd ?x ?y ?j ?)
    (test (neq ?z ?j))
    =>
    (assert (hermana ?z ?j)))
    
  (defrule abuelo1
    (padre ?z ?x)
    (padre ?x ?y)
    =>
    (assert (abuelo ?z ?y)))

  (defrule abuelo2
    (padre ?z ?x)
    (madre ?x ?y)
    =>
    (assert (abuelo ?z ?y)))

(defrule abuela1
    (madre ?z ?x)
    (padre ?x ?y)
    =>
    (assert (abuela ?z ?y)))

  (defrule abuela2
    (madre ?z ?x)
    (madre ?x ?y)
    =>
    (assert (abuela ?z ?y)))

  (defrule primo1
    (dd ? ? ?x h)
    (padre ?z ?x)
    (hermano ?z ?j)
    (padre ?j ?y)
    
    =>
    (assert (primo ?x ?y)))

    (defrule primo2
    (dd ? ? ?x h)
    (padre ?z ?x)
    (hermano ?z ?j)
    (madre ?j ?y)
    
    =>
    (assert (primo ?x ?y)))

	  (defrule primo3
    (dd ? ? ?x h)
    (madre ?z ?x)
    (hermana ?z ?j)
    (padre ?j ?y)
    
    =>
    (assert (primo ?x ?y)))
    
  (defrule primo4
    (dd ? ? ?x h)
    (madre ?z ?x)
    (hermana ?z ?j)
    (madre ?j ?y)
    
    =>
    (assert (primo ?x ?y)))

  (defrule prima1
    (dd ? ? ?x m)
    (padre ?z ?x)
    (hermano ?z ?j)
    (padre ?j ?y)
    
    =>
    (assert (prima ?x ?y)))

    (defrule prima2
    (dd ? ? ?x m)
    (padre ?z ?x)
    (hermano ?z ?j)
    (madre ?j ?y)
    
    =>
    (assert (prima ?x ?y)))

	  (defrule prima3
    (dd ? ? ?x m)
    (madre ?z ?x)
    (hermana ?z ?j)
    (padre ?j ?y)
    
    =>
    (assert (prima ?x ?y)))
    
  (defrule prima4
    (dd ? ? ?x m)
    (madre ?z ?x)
    (hermana ?z ?j)
    (madre ?j ?y)
    
    =>
    (assert (prima ?x ?y)))

  (defrule antecesor1
    (padre ?x ?y)
    =>
    (assert (antecesor ?x ?y)))

  (defrule antecesor2
    (madre ?x ?y)
    =>
    (assert (antecesor ?x ?y)))

  (defrule antecesor3
    (antecesor ?x ?z)
    (antecesor ?z ?y)
    =>
    (assert (antecesor ?x ?y)))

(reset)
(run)
(facts)
