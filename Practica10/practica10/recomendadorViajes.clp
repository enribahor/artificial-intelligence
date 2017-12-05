(mapclass Usuario)
(mapclass Viaje)
(mapclass Destino)
(mapclass Coche)
(mapclass Tren)
(mapclass Avion)
(mapclass Hotel)
(mapclass Camping)

;Calcula el precio del viaje sumanso el coste del transporte y el alojamiento.
;Para el alojamiento se tiene en cuenta tanto el precio por día como la duración del viaje.
;No funciona con las clases abstractas por alguna razón.

(defrule precioViajeHotelCoche
	(object (is-a Hotel) (precio_por_dia ?pa) (OBJECT ?a))
	(object (is-a Coche) (precio ?pt) (OBJECT ?t))
	?v <- (object (is-a Viaje) (precio 0) (duracion ?d) (transporte ?t) (alojamiento ?a))
	=>
	(modify-instance ?v (precio (+ ?pt (* ?pa ?d)))))
	
(defrule precioViajeHotelAvion
	(object (is-a Hotel) (precio_por_dia ?pa) (OBJECT ?a))
	(object (is-a Avion) (precio ?pt) (OBJECT ?t))
	?v <- (object (is-a Viaje) (precio 0) (duracion ?d) (transporte ?t) (alojamiento ?a))
	=>
	(modify-instance ?v (precio (+ ?pt (* ?pa ?d)))))

(defrule precioViajeHotelTren
	(object (is-a Hotel) (precio_por_dia ?pa) (OBJECT ?a))
	(object (is-a Tren) (precio ?pt) (OBJECT ?t))
	?v <- (object (is-a Viaje) (precio 0) (duracion ?d) (transporte ?t) (alojamiento ?a))
	=>
	(modify-instance ?v (precio (+ ?pt (* ?pa ?d)))))

(defrule precioViajeCampingCoche
	(object (is-a Camping) (precio_por_dia ?pa) (OBJECT ?a))
	(object (is-a Coche) (precio ?pt) (OBJECT ?t))
	?v <- (object (is-a Viaje) (precio 0) (duracion ?d) (transporte ?t) (alojamiento ?a))
	=>
	(modify-instance ?v (precio (+ ?pt (* ?pa ?d)))))
	
(defrule precioViajeCampingAvion
	(object (is-a Camping) (precio_por_dia ?pa) (OBJECT ?a))
	(object (is-a Avion) (precio ?pt) (OBJECT ?t))
	?v <- (object (is-a Viaje) (precio 0) (duracion ?d) (transporte ?t) (alojamiento ?a))
	=>
	(modify-instance ?v (precio (+ ?pt (* ?pa ?d)))))
	
(defrule precioViajeCampingTren
	(object (is-a Camping) (precio_por_dia ?pa) (OBJECT ?a))
	(object (is-a Tren) (precio ?pt) (OBJECT ?t))
	?v <- (object (is-a Viaje) (precio 0) (duracion ?d) (transporte ?t) (alojamiento ?a))
	=>
	(modify-instance ?v (precio (+ ?pt (* ?pa ?d)))))
	
	
;Hace varios matching a la vez que han sido testados por separado:
;El destino tiene características (al menos una) coincidentes con el usuario.
;El viaje no supera el presupuesto del usuario.
;Garantizamos que no haya repeticiones (y la terminación) con el not a viajes del usuario.
;Además, para evitar utilizar viajes que no tienen calculado su precio, nos aseguramos de 
;que no haya de coste cero. Esto hace que no puedan existir viajes gratuítos. Podría utilizarse otro valor por defecto.

(defrule matching
	(object (is-a Destino) (nombre ?nd) (caracteristicas $? ?c $?) (OBJECT ?d))
	?x <-(object (is-a Usuario) (nombre ?n) (viajes $?f)(presupuesto ?r) (intereses $? ?c $?))
	(object (is-a Viaje) (codigo ?o) (precio ?pr) (destino ?d)(OBJECT ?y))
	(test( > ?r ?pr))
	(test( < 0 ?pr)) 
	(not (object (is-a Usuario) (nombre ?n) (viajes $? ?y $?)))
	=>
	(modify-instance ?x (viajes ?f ?y)))
	
(reset)
(run)
(facts)
