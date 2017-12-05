
(deftemplate persona
	(slot nombre)
    (slot edad)
    (slot presupuesto)
    (multislot intereses)
    (slot dias)
    (slot presDia (default 0))
    (slot presTransporte (default 0))
    (slot presAlojamiento (default 0))
    (slot rangoEdad (default ninguno)))

(deftemplate ciudad
	(slot nombre)
    (slot habitantes)
    
    (slot hoteles)    
    (slot monumentos(default 0))
    (slot montanya)
    (slot playa)
    (slot discotecas(default 0))
    (slot balnearios(default 0))
    (slot museos(default 0))
    (slot teatros(default 0))
    (slot operas(default 0))
    (slot restaurantes(default 0))
    (slot atracciones(default 0))
    (slot centrosComerciales(default 0))
    
    (multislot deportes)
    (multislot tipoDestino))

(deftemplate destino
    (slot nombre)
    (slot ciudad)
	(slot alojamiento)
    (slot transporte))

(deffacts ini
    ;(persona (nombre juan)(edad 18)(presupuesto 150)(intereses aventura)(dias 3))
    ;(persona (nombre maria)(edad 35)(presupuesto 800)(intereses turismo)(dias 7))
    ;(persona (nombre pepe)(edad 65)(presupuesto 500)(dias 2))
  
  ; (ciudad (nombre segovia)(habitantes 55000)(hoteles 28)
   ;    (montanya si) (playa no)(centrosComerciales 2)
    ;  (discotecas 5) (monumentos 7)(balnearios 3)(restaurantes 25))
    
    ;(ciudad (nombre valencia)(habitantes 100000)(hoteles 1200)
     ;   (montanya no) (playa si) (discotecas 7)  (monumentos 30)
      ; (restaurantes 300))
    
	;(ciudad (nombre barcelona)(habitantes 500000000)(hoteles 2260)
     ;  (montanya no) (playa si)(atracciones 4) (centrosComerciales 50)
   ; (teatros 10) (museos 50) (operas 5)(deportes aventura)(discotecas 30) (monumentos 120) (restaurantes 600))

	;(ciudad (nombre bilbao)(habitantes 350000)(hoteles 900)
  ;(montanya si) (playa si)(centrosComerciales 10)
  ;(discotecas 4) (monumentos 3)(balnearios 0)(restaurantes 800))
  
;(ciudad (nombre santiago)(habitantes 96000)(hoteles 33)
 ; (montanya no) (playa no)(centrosComerciales 2)
  ;(discotecas 1) (monumentos 10)(balnearios 2)(restaurantes 105)))
	(ciudad (nombre prueba)(habitantes 10)(hoteles 1)
       (montanya no) (playa no) (discotecas 0) (tipoDestino fiesta) (monumentos 0)
       (restaurantes 0)))
;______________________________Módulo del usuario_________________________

(defmodule usuario )


;Calculamos el presupuesto para un día.

(defrule presDiario
	"calcula el presupuesto para un día"
    ?v <- (persona (presupuesto ?p)(dias ?d)(presDia 0))
	=>
    (modify ?v (presDia (/ (/ ?p 2) ?d))))

;--------------RangoEdad--------------------

(defrule rangoBajo
    ?v <- (persona (edad ?e)(rangoEdad ninguno))
    (test (<= ?e 30))
	=>
    (modify ?v (rangoEdad joven)))

(defrule rangoMedio
    ?v <- (persona (edad ?e)(rangoEdad ninguno))
    (test (> ?e 30))
    (test (<= ?e 60))
	=>
    (modify ?v (rangoEdad medio)))

(defrule rangoAlto
    ?v <- (persona (edad ?e)(rangoEdad ninguno))
    (test (> ?e 60))
	=>
    (modify ?v (rangoEdad mayor)))


;--------------------------------------- Intereses--------------------------

(defrule intOcio
    ?v <- (persona (nombre ?n)(rangoEdad joven)(intereses $?l))
    	(not (persona (nombre ?n) (intereses $? ocio $?)))
    =>
      (modify ?v (intereses $?l ocio)))

(defrule intFiesta
    ?v <- (persona (nombre ?n)(rangoEdad joven)(intereses $?l))
    	(persona (nombre ?n) (intereses $? aventura $?))
    	(not (persona (nombre ?n) (intereses $? fiesta $?)))
    =>
      (modify ?v (intereses $?l fiesta)))

(defrule intTurismo
    ?v <- (persona (nombre ?n)(rangoEdad medio)(dias ?d)(intereses $?l))
    	(test (>= ?d 7))
    	(not (persona (nombre ?n) (intereses $? turismo $?)))
    =>
      (modify ?v (intereses $?l turismo)))

(defrule intGastro
    ?v <- (persona (nombre ?n)(rangoEdad medio)(presDia ?p)(intereses $?l))
    	(test (>= ?p 100))
    	(not (persona (nombre ?n) (intereses $? gastronomia $?)))
    =>
      (modify ?v (intereses $?l gastronomia)))

(defrule intRelax
    ?v <- (persona (nombre ?n)(rangoEdad mayor)(intereses $?l))
    	(not (persona (nombre ?n) (intereses $? relax $?)))
    =>
      (modify ?v (intereses $?l relax)))

;______________________________Módulo de ciudad________________________________

(defmodule ciudad )

(defrule ocioso
    ?v <- (ciudad (nombre ?n)(atracciones ?a)(centrosComerciales ?c)(tipoDestino $?d))
        (test (>= ?a 3))
        (test (>= ?c 10))
    (not (ciudad (nombre ?n) (tipoDestino $? ocio $?)))
    =>
      (modify ?v (tipoDestino $?d ocio)))
 

(defrule cultura
	?v <- (ciudad (nombre ?n)(museos ?m)(teatros ?t)(operas ?o)(tipoDestino $?d))
    (test (>= ?m 6))
    (test (>= ?t 5))
	(test (>= ?o 2))
    (not (ciudad (nombre ?n) (tipoDestino $? cultura $?)))
    =>
    (modify ?v (tipoDestino $?d cultura)))

(defrule aventura1
    ?v <- (ciudad (nombre ?n)(deportes $? ?d $?)(tipoDestino $?l))
    	(test (eq ?d aventura))
    	(not (ciudad (nombre ?n) (tipoDestino $? aventura $?)))
    =>
      (modify ?v (tipoDestino $?l aventura)))

(defrule aventura2
    ?v <- (ciudad (nombre ?n)(playa ?y)(tipoDestino $?l))
    	(test (eq ?y si))
    	(not (ciudad (nombre ?n) (tipoDestino $? aventura $?)))
    =>
      (modify ?v (tipoDestino $?l aventura)))

(defrule aventura3
    ?v <- (ciudad (nombre ?n)(montanya ?y)(tipoDestino $?l))
    	(test (eq ?y si))
    	(not (ciudad (nombre ?n) (tipoDestino $? aventura $?)))
    =>
      (modify ?v (tipoDestino $?l aventura)))

(defrule extremo
    ?v <- (ciudad (nombre ?n)(deportes $? ?d $?)(tipoDestino $?l))
    	(test (eq ?d extremo))
    	(not (ciudad (nombre ?n) (tipoDestino $? extremo $?)))
    =>
      (modify ?v (tipoDestino $?l extremo)))

(defrule fiesta
    ?v <- (ciudad (nombre ?n)(discotecas ?d)(tipoDestino $?l))
    	(test (>= ?d 10))
    	(not (ciudad (nombre ?n) (tipoDestino $? fiesta $?)))
    =>
      (modify ?v (tipoDestino $?l fiesta)))

(defrule turismo
    ?v <- (ciudad (nombre ?n)(monumentos ?m )(tipoDestino $?l))
    	(test (>= ?m 15))
    	(not (ciudad (nombre ?n) (tipoDestino $? turismo $?)))
    =>
      (modify ?v (tipoDestino $?l turismo)))

(defrule relax
    ?v <- (ciudad (nombre ?n)(balnearios ?b)(tipoDestino $?l))
    	(test (> ?b 0))
    	(not (ciudad (nombre ?n) (tipoDestino $? relax $?)))
    =>
      (modify ?v (tipoDestino $?l relax)))

(defrule naturaleza1
    ?v <- (ciudad (nombre ?n)(deportes $? ?d $?)(tipoDestino $?l))
    	(test (eq ?d naturaleza))
    	(not (ciudad (nombre ?n) (tipoDestino $? naturaleza $?)))
    =>
      (modify ?v (tipoDestino $?l naturaleza)))

(defrule naturaleza2
    ?v <- (ciudad (nombre ?n)(montanya ?y)(tipoDestino $?l))
    	(test (eq ?y si))
    	(not (ciudad (nombre ?n) (tipoDestino $? naturaleza $?)))
    =>
      (modify ?v (tipoDestino $?l naturaleza)))


(defrule gastronomia
    ?v <- (ciudad (nombre ?n)(restaurantes ?r)(tipoDestino $?l))
    	(test (>= ?r 20))
    	(not (ciudad (nombre ?n) (tipoDestino $? gastronomia $?)))
    =>
      (modify ?v (tipoDestino $?l gastronomia)))

;_________________________Módulo de destino______________________________

(defmodule destino)



(defrule destinoFinal 
    "Decidimos destinos en función de los intereses"
    (persona (nombre ?n)(intereses $? ?j $?))
    (ciudad (nombre ?c)(tipoDestino $? ?j $?))
     (not(destino (nombre ?n) (ciudad ?c)))    
    =>   
    (assert ( destino (nombre ?n)(ciudad ?c))))
     

(defrule destino1
     (persona (nombre ?n)(intereses $? ocio $?)(rangoEdad joven))
    (ciudad (nombre ?c)(tipoDestino $? fiesta $?))
     (not(destino (nombre ?n) (ciudad ?c)))    
    =>   
    (assert ( destino (nombre ?n)(ciudad ?c))))
 
(defrule destino2
     (persona (nombre ?n)(intereses $? ocio $?)(rangoEdad joven))
    (ciudad (nombre ?c)(tipoDestino $? fiesta $?))
     (not(destino (nombre ?n) (ciudad ?c)))    
    =>   
    (assert ( destino (nombre ?n)(ciudad ?c))))

;____________________________Módulo de Transporte_____________________________

(defmodule logistica )

   
(defrule calTransporte
    ?v <- (persona (presupuesto ?p)(presTransporte 0))
    =>
    (modify ?v (presTransporte (/ ?p 4))))

(defrule viajeBarato
    "decide en que medio viajar"
    (persona (nombre ?n) (presTransporte ?p))
	?v <- (destino (nombre ?n))
    (test( < ?p 40))
    (test (> ?p 0 ))
    => 
    (modify ?v (nombre ?n) (transporte bus)))

(defrule viajeMedio
    "decide en que medio viajar"
    (persona (nombre ?n) (presTransporte ?p))
	?v <- (destino (nombre ?n))
    (test( >= ?p 40))
    (test( < ?p 110))
    => 
    (modify ?v (nombre ?n) (transporte coche)))

(defrule viajeCaro
    "decide en que medio viajar"
    (persona (nombre ?n) (presTransporte ?p))
	?v <- (destino (nombre ?n))
    (test( >= ?p 110))
    => 
    (modify ?v (nombre ?n) (transporte tren)))
   
;_________________Módulo de Alojamiento_______________________________


(defrule calAlojamiento
    ?v <- (persona (presupuesto ?p)(dias ?d))
    =>
    (modify ?v (presAlojamiento ( / (/ ?p 4) ?d))))



(defrule alojarCaro
	"decide donde debe alojarse una persona"
    ?v <- (destino (nombre ?n) (alojamiento nil))
    (persona (nombre ?n)(presAlojamiento ?p)(dias ?d))
     (test (>= ?p 50 ))
	=>
    (modify ?v (nombre ?n) (alojamiento hotel)))

(defrule alojarMedio
	"decide donde debe alojarse una persona"
    ?v <- (destino (nombre ?n) (alojamiento nil))
    (persona (nombre ?n)(presAlojamiento ?p)(dias ?d))
    (test (< ?p 50 ))
    (test (>= ?p 20 ))
	=>
    (modify ?v (nombre ?n) (alojamiento apartamento)))

(defrule alojarBajo
	"decide donde debe alojarse una persona"
   ?v <- (destino (nombre ?n) (alojamiento nil))
    (persona (nombre ?n)(presAlojamiento ?p)(dias ?d))
    (test (< ?p 20 ))
    (test (> ?p 0 ))
	=>
    (modify ?v (nombre ?n) (alojamiento camping)))



  
(reset)
(focus usuario ciudad destino logistica)
(run)
(facts *)
