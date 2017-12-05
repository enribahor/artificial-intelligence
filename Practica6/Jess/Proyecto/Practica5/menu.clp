/* Dadas las características y gustos de una persona y
conociendo su objetivo(mantener peso, adelgazar o engordar)se
calculan las calorías que debe ingerir (se hace la
simplificación de que cualquier persona debe ingerir 500
calorías para mantener su peso). A partir de ahí se genera un
menú formado por dos platos y un postre que respete las
preferencias de la persona y cuyas calorías totales estén
entre el 90% y el 100% de las que debe ingerir según su
objetivo */

(deftemplate persona
	(slot nombre)
    (slot edad)
    (slot sexo)
    (slot estatura)
    (slot peso)
    (slot objetivo)
    (slot preferencia)
    (slot caloriasRec (default 0)))

(deftemplate plato
	(slot nombre)
    (slot tipo)
    (slot mayoritario)
    (slot calorias))

(deftemplate menu
    (slot nombre)
	(slot primero)
    (slot segundo)
    (slot postre)
    (slot calorias))

(deffacts ini
    (persona (nombre juan)(edad 18)(sexo h)(estatura 180)(objetivo engordar)
        (peso 70) (preferencia carne))
     (persona (nombre maria)(edad 18)(sexo m)(estatura 170)(objetivo adelgazar)
        (peso 60) (preferencia pescado))
     (persona (nombre pepe)(edad 25)(sexo h)(estatura 190)(objetivo mantener)
        (peso 80) (preferencia cualquiera))
    (persona (nombre luisa)(edad 18)(sexo m)(estatura 170)(objetivo adelgazar)
        (peso 60) (preferencia pescado) (caloriasRec 200))
    (plato (nombre macarrones)(tipo primero)(mayoritario cereales)(calorias 200))
    (plato (nombre sopa)(tipo primero)(mayoritario cereales)(calorias 100))
    (plato (nombre consome)(tipo primero)(mayoritario caldo)(calorias 80))
    (plato (nombre menestra)(tipo primero)(mayoritario verdura)(calorias 120))
    (plato (nombre filete)(tipo segundo)(mayoritario carne)(calorias 250))
    (plato (nombre merluza)(tipo segundo)(mayoritario pescado)(calorias 150))
    (plato (nombre flan)(tipo postre)(mayoritario huevos)(calorias 200))
    (plato (nombre manzana)(tipo postre)(mayoritario fruta)(calorias 100)))

(deffunction ncalorias (?edad ?sexo ?peso ?estatura)
	(return 500))

(defrule mantener
	"calcula calorias para mantener"
    ?p <- (persona (nombre ?n)(edad ?e)(sexo ?s) (estatura ?es) 
        (peso ?p) (objetivo mantener) (caloriasRec 0))
	=>
    (modify ?p (caloriasRec (ncalorias ?e ?s ?p ?es))))

(defrule engordar
	"calcula calorias para engordar"
    ?p <- (persona (nombre ?n)(edad ?e)(sexo ?s) (estatura ?es) 
        (peso ?p) (objetivo engordar) (caloriasRec 0))
	=>
    (modify ?p (caloriasRec (* 1.1 (ncalorias ?e ?s ?p ?es)))))

(defrule adelgazar
	"calcula calorias para adelgazar"
    ?p <- (persona (nombre ?n)(edad ?e)(sexo ?s) (estatura ?es) 
        (peso ?p) (objetivo adelgazar) (caloriasRec 0))
	=>
    (modify ?p (caloriasRec (* 0.9 (ncalorias ?e ?s ?p ?es)))))

(defrule menu
  (persona (nombre ?n)(preferencia ?m)(caloriasRec ?c))
    (not(menu (nombre ?n))) 
    (plato (nombre ?np1)(tipo primero)(calorias ?c1))
    (plato (nombre ?np2)(tipo segundo)(mayoritario ?m)(calorias ?c2))
    (plato (nombre ?np3)(tipo postre)(calorias ?c3))
    (test (<= (+ ?c1 ?c2 ?c3) ?c))
    (test (>= (+ ?c1 ?c2 ?c3) (* 0.9 ?c)))
	=>
    (assert (menu (nombre ?n) (primero ?np1) (segundo ?np2) (postre ?np3) 
            (calorias (+ ?c1 ?c2 ?c3))))
    (printout t "Menú recomendado para " ?n " primero " ?np1 " segundo " ?np2 " postre " ?np3 crlf))

(defrule menucualquiera
  (persona (nombre ?n)(preferencia cualquiera)(caloriasRec ?c))
    (not(menu (nombre ?n))) 
    (plato (nombre ?np1)(tipo primero)(calorias ?c1))
    (plato (nombre ?np2)(tipo segundo)(calorias ?c2))
    (plato (nombre ?np3)(tipo postre)(calorias ?c3))
    (test (<= (+ ?c1 ?c2 ?c3) ?c))
    (test (>= (+ ?c1 ?c2 ?c3) (* 0.9 ?c)))
	=>
    (assert (menu (nombre ?n) (primero ?np1) (segundo ?np2) (postre ?np3) 
            (calorias (+ ?c1 ?c2 ?c3))))
    (printout t "Menú recomendado para " ?n " primero " ?np1 " segundo " ?np2 " postre " ?np3 crlf))

(defrule sinmenu 
    (declare (salience -1))
    (persona (nombre ?n))
    (not(menu (nombre ?n)))  
	=>
    (printout t "No hay menú recomendado para " ?n  crlf))
        
(reset)
(run)
(facts)
