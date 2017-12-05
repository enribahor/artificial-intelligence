

%Crear y eliminar citas
	
:- dynamic cita/6 .
:- dynamic reunion/6 .
:- dynamic evento/6 .

	%	Puedes guardar solo la duración de la consulta, o guardar la consulta y rehacerla
	%	Si quieres reutilizar preguntas, tienes que guardar todo.
	
:- dynamic consulta_guardada/4 .
	consulta_guardada(empty, empty, 0, empty).

%Cracion de los tres tipos de compromisos que permitimos.

	crear(Salida, cita, Persona, Dia, Mes, Hora, Minuto, Duracion) :- 
			assert(cita( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(cita, crear, Salida).
	crear(Salida, reunion, Persona, Dia, Mes, Hora, Minuto, Duracion) :- 
			assert(reunion( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(reunion, crear, Salida).
	crear(Salida, evento, Persona, Dia, Mes, Hora, Minuto, Duracion) :- 
			assert(evento( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(evento, crear, Salida).

%Eliminacion de los compromisos.
			
	eliminar(Salida, cita, Persona, Dia, Mes, Hora, Minuto, Duracion) :-
			retract(cita( Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(cita, eliminar, Salida).
	eliminar(Salida, reunion, Persona, Dia, Mes, Hora, Minuto, Duracion) :-
			retract(reunion(Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(reunion, eliminar, Salida).
	eliminar(Salida, evento, Persona, Dia, Mes, Hora, Minuto, Duracion) :-
			retract(evento(Persona, Dia, Mes, Hora, Minuto, Duracion)),
			salida(evento, eliminar, Salida).
		
%Todas las consultas que podemos hacer.
	
	%Consulta de compromisos concretos.
		
		consultar(Salida, Dia, Mes, Hora, Minuto) :-
				 cita( Persona, Dia, Mes, Hora, Minuto, _),
				 guardar_consulta(cita, Persona, Dia, Mes),
				 mostrar_cita(Salida, Persona).
				 
		consultar(Salida, Dia, Mes, Hora, Minuto) :-
				 reunion( Persona, Dia, Mes, Hora, Minuto, _),
				 guardar_consulta(reunion, Persona, Dia, Mes),
				 mostrar_reunion(Salida, Persona).
				 
		consultar(Salida, Dia, Mes, Hora, Minuto) :-
				 evento( Persona, Dia, Mes, Hora, Minuto, _),
				 guardar_consulta(evento, Persona, Dia, Mes),
				 mostrar_evento(Salida, Persona).
		
	%Consulta de la duración de un compromiso: mostrar_duracion(Salida, Tipo, Persona, Dia, Mes, Duracion)
	
		consultar_duracion(Salida, cita, Persona, Dia, Mes) :-
				 cita(Persona, Dia, Mes, _, _,Duracion),
				 mostrar_duracion(Salida, cita, Persona, Dia, Mes, Duracion).
		consultar_duracion(Salida, reunion, Persona, Dia, Mes) :-
				 reunion(Persona, Dia, Mes, _, _,Duracion),
				 mostrar_duracion(Salida, reunion, Persona, Dia, Mes, Duracion).
		consultar_duracion(Salida, evento, Persona, Dia, Mes) :-
				 evento(Persona, Dia, Mes, _, _,Duracion),
				 mostrar_duracion(Salida, evento, Persona, Dia, Mes, Duracion).
				  
	%Parte opcional 1	
		consultar_dia(Salida,Dia,Mes) :-
				setof([cita, con, Persona, el, Dia, de, Mes, a, las, Hora, y, Minuto, minutos, durante, Duracion, minutos],
						cita(Persona, Dia, Mes, Hora, Minuto, Duracion),Salida1),
				setof([reunion, con, Persona, el, Dia, de, Mes, a, las, Hora, y, Minuto, minutos, durante, Duracion, minutos],
						reunion(Persona, Dia, Mes, Hora, Minuto, Duracion),Salida2),
				setof([evento, con, Persona, el, Dia, de, Mes, a, las, Hora, y, Minuto, minutos, durante, Duracion, minutos],
						evento(Persona, Dia, Mes, Hora, Minuto, Duracion),Salida3),
				append(Salida1, Salida2, Salida4),
				append(Salida4, Salida3, Salida).
				
		consultar_dia_tipo(Salida,Tipo,Dia,Mes) :-
			( 	es_tipo_cita(Tipo) ->
					setof([cita, con, Persona, el, Dia, de, Mes, a, las, Hora, y, Minuto, minutos, durante, Duracion, minutos],
							cita(Persona, Dia, Mes, Hora, Minuto, Duracion),Salida);
				es_tipo_reunion(Tipo) ->
					setof([reunion, con, Persona, el, Dia, de, Mes, a, las, Hora, y, Minuto, minutos, durante, Duracion, minutos],
							reunion(Persona, Dia, Mes, Hora, Minuto, Duracion),Salida);
				es_tipo_evento(Tipo) ->
					setof([evento, con, Persona, el, Dia, de, Mes, a, las, Hora, y, Minuto, minutos, durante, Duracion, minutos],
						evento(Persona, Dia, Mes, Hora, Minuto, Duracion),Salida);
				Salida = 'Error'						
				),!.
				
			
% Gramática. Tenemos los cuatro tipos de frase que podemos recibir: crear, eliminar, consultar un compromiso y consultar la duración.

		frase(Salida) --> accion(crear), tipo(Tipo), persona(Persona), fecha(Dia, Mes), hora(Hora, Minuto),
										duracion(Duracion), {crear(Salida, Tipo, Persona, Dia, Mes, Hora, Minuto, Duracion)}.
										
		frase(Salida) --> accion(eliminar), tipo(Tipo), persona(Persona), {eliminar(Salida, Tipo, Persona, _, _, _, _, _)}.		

		frase(Salida) --> pregunta_consulta, tipo(Tipo), fecha(Dia,Mes), {consultar_dia_tipo(Salida, Tipo,Dia,Mes)}.
		
		frase(Salida) --> pregunta_consulta, fecha(Dia, Mes), hora(Hora, Minuto), {consultar(Salida, Dia, Mes, Hora, Minuto)}.
		
		frase(Salida) --> pregunta_consulta, fecha(Dia,Mes), {consultar_dia(Salida,Dia,Mes)}.
		
		frase(Salida) --> consulta_duracion, tipo(Tipo), persona(Persona), fecha(Dia, Mes), {consultar_duracion(Salida, Tipo, Persona, Dia, Mes)}.

		frase(Salida) --> consulta_parcial, hora(Hora, Minuto),
							{ consulta_guardada(_, _, Dia, Mes), consultar(Salida, Dia, Mes, Hora, Minuto)}.
		
		frase(Salida) --> consulta_parcial, consulta_duracion,
							{ consulta_guardada(Tipo, Persona, Dia, Mes), consultar_duracion(Salida, Tipo, Persona, Dia, Mes)}.

%Gestion de qué tipo de accion se lleva a cabo(crear o eliminar)

	accion(Tipo) --> [T], {es_accion(Tipo, T)}.

	es_accion(crear, pon).
	es_accion(crear, añade).

	es_accion(eliminar, borra).
	es_accion(eliminar, quita).

%Gestionamos qué tipo de compromiso tenemos, y aseguramos la concordancia con los artículos

	tipo(Tipo) --> [Tipo], { es_tipo_accion(Tipo, _)}.
	tipo(Tipo) --> [Articulo, Tipo],  { es_articulo(Articulo, Genero), es_tipo_accion(Tipo, Genero)}, !. 
	
	%Aprovechamos la práctica anterior para meter concordancia
	

	%Gestión de consulta

	es_tipo_accion(cita, femenino).
	es_tipo_accion(reunion, femenino).
	es_tipo_accion(evento, masculino).
	es_tipo_accion(citas, femenino).
	es_tipo_accion(reuniones, femenino).
	es_tipo_accion(eventos, masculino).
	
	es_tipo_cita(cita).
	es_tipo_cita(citas).
	es_tipo_reunion(reunion).
	es_tipo_reunion(reuniones).
	es_tipo_evento(evento).
	es_tipo_evento(eventos).
	
	articulo(Genero) --> [A], {es_articulo(A, Genero)}.
	
	es_articulo(un, masculino).
	es_articulo(el, masculino).
	es_articulo(una, femenino).
	es_articulo(la, femenino).
	es_articulo(los, masculino).
	es_articulo(las, femenino).
	
%Preguntas para las consultas.
	
	pregunta_consulta --> [que, hay], !.
	pregunta_consulta --> [que, tengo], !.
	pregunta_consulta --> [dime], !.
	consulta_duracion --> [cuanto, durara], !.
	
	consulta_parcial --> [y], !.

%Persona: Realmente puedes introducir una cita con quien quieras. Si quieres que sea alguien de la agenda, puede añadirse.

	persona(Persona) --> [con, Persona], !.
	persona(Persona) --> [de, Persona], !.
	persona(Persona) --> [Persona], !.

%Gestion de fechas: de manera alternativa puede ponerse hoy o mañana
	fecha(Dia, Mes) --> [mañana], !, {mañanas(Dia, Mes)}.
	
	fecha(Dia, Mes) --> [hoy], !, {hoy(Dia, Mes)}.
	fecha(Dia, Mes) --> dias(Dia), mes(Mes, Limite), {Dia =< Limite}.
	
	%Si no especifica mes nos quedamos con el actual.
	fecha(Dia, Mes) --> dias(Dia), {hoy(_, Mes), es_mes(_, Mes, Limite), Dia =< Limite}. 

	%El caso de mañana requiere algunas comprobaciones
	
	

	mañanas(Dia, Mes) :- hoy(DiaActual, Mes), es_mes(_, Mes, Limite), (DiaActual+1) =< Limite, Dia is DiaActual+1.
	
	%Si cambia el mes, o el año, debemos tenerlo en cuenta. Si el día de hoy iguala el límite.
	% Si el mes es el 12 pasamos al 1 (hay que hacer primero el módulo si no diciembre sería el 0)

	mañanas(Dia, Mes) :- hoy(DiaActual, MesActual), es_mes(NumeroMes, MesActual, Limite), DiaActual >= Limite, Dia is 1,
																es_mes((NumeroMes mod 12)+1, Mes, _). 
	
	

	dias(Dia) --> [el, dia, Dia], !.	
	dias(Dia) --> [el, Dia],! .
	dias(Dia) --> [del, dia, Dia], !.	
	dias(Dia) --> [del, Dia],! .
	dias(Dia) --> [Dia],!.
	
	mes(Mes, Limite) --> [de, Mes], !, {es_mes(_, Mes, Limite)}.
	mes(Mes, Limite) --> [Mes], !, {es_mes(_, Mes, Limite)}.

	es_mes(1, enero, 31).
	es_mes(2, febrero, 28).
	es_mes(3, marzo, 31).
	es_mes(4, abril, 30).
	es_mes(5, mayo, 31).
	es_mes(6, junio, 30).
	es_mes(7, julio, 31).
	es_mes(8, agosto, 31).
	es_mes(9, septiembre, 30).
	es_mes(10, octubre, 31).
	es_mes(11, noviembre, 30).
	es_mes(12, diciembre, 31).

%Gestión de horas.

	hora(Hora, Minuto) --> hora_hora(Hora), hora_minuto(Minuto).
	hora(Hora, Minuto) --> hora_hora(Hora),{Minuto is 0}.

	hora_hora(Hora) --> [a, las, Hora, horas], !, {es_hora(Hora)}.
	hora_hora(Hora) --> [a, las, Hora], !, {es_hora(Hora)}.

	hora_minuto(Minuto) --> [y, Minuto, minutos], !, {es_minuto(Minuto)}.
	hora_minuto(Minuto) --> [y, Minuto], !, {es_minuto(Minuto)}.


	es_hora(Hora) :- Hora >= 0, Hora < 24.
	es_minuto(Minuto) :- Minuto >= 0, Minuto < 60.


%Gestión de duración.


	duracion(Tiempo) --> [durara, Tiempo, minutos].
	
	%Si no se especifica se ponen 30 minutos.
	duracion(Tiempo) --> {Tiempo is 30}.


%Como hecho inicial tenemos qué día es hoy.
	hoy(10, junio).
 
%Bucle para las consultas.
 
	consulta:-  nl, write('Escribe frase entre corchetes separando palabras con comas '), nl, 
	 write('o lista vacía para parar '), nl, 
	 read(F), 
	 trata(F). 
	 
	trata([]):- write('final'). 
	% tratamiento final 
	 
	trata(F):- frase(Salida, F, []), write(Salida), nl, consulta. 
	% tratamiento caso general 

% Guardado de datos para consultas posteriores.

	guardar_consulta(Tipo, Persona, Dia, Mes) :-
		retractall(consulta_guardada(_, _, _, _)),
		assert(consulta_guardada(Tipo,Persona, Dia, Mes)).

	

%Gestion de la salida ____________________________________________________

	%Salida para las creaciones (puede mejorarse)

		salida(cita, crear, cita_creada).
		salida(reunion, crear, reunion_creada).
		salida(evento, crear, evento_creado).
	
	%Salida para las eliminaciones.
	
		salida(cita, eliminar, cita_eliminada).
		salida(reunion, eliminar, reunion_eliminada).
		salida(evento, eliminar, evento_eliminado).
	
	%Salida de todas las consultas
	
		mostrar_cita(Salida, Persona):-
			append([tienes, una, cita, con, Persona], [], Salida).
		mostrar_reunion(Salida, Persona):-
			append([tienes, una, reunion, con, Persona], [], Salida).
		mostrar_evento(Salida, Persona):-
			append([tienes, un, evento, con, Persona], [], Salida).
			
	%Muestra la duracion. Puede ser un evento, una cita o una reunion.
	
		mostrar_duracion(Salida, Tipo, Persona, Dia, Mes, Duracion):-
			append([tu, Tipo, con, Persona, el, dia, Dia, de, Mes, durara, Duracion, minutos], [], Salida).
			
			
			
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%	EJEMPLOS DE EJECUCIÓN	%%%%%%%%%%%%%%%%%%%%%%%%

%		Tenemos un programa sencillo. Podemos crear citas, reuniones y eventos. También eliminarlos.
%		Funciona como se indica en el enunciado simple. La parte opcional no está implementada.
%		De la anterior práctica hemos añadido un pequeño control en la concordancia de los artículos.
%		Además hemos incluído el tratamiento de algunos errores. Sin embargo, muchos se quedan sin tratar.
%		Por ejemplo si es día 15 y ponemos una cita para el 7, se pone para el 7 del mes actual, lo que 
%		sería un error. Y así numerosos errores no tratado en caso de introducir datos erróneos.

		%Los nombres raros son porque me daba errores que no entendía y quería evitar cosas raras(luego me daba cuenta que no era eso).
%		El uso es el que se explica: se pone "consulta.", y a continuacion la frase entre [] separada por comas.
%		Ahora pondremos algunos ejemplos de ejecucion que permite el programa. La salida no está muy cuidada tampoco:
%

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [añade, cita, con, maria, el, 27,de, mayo, a, las, 9].
%	cita_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [pon, una, reunion , con, carlos, el, 3, de, junio, a, las, 11].
%	reunion_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [pon, un, evento , con, juan, el, 8, de, julio, a, las, 18].
%	evento_creado

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [borra, el, evento, de, juan].
%	evento_eliminado

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [quita, la, reunion, con, carlos].
%	reunion_eliminada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [pon, una, cita, con, paqui, mañana, a, las, 18].
%	cita_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [que, tengo, mañana, a, las, 18].
%	[tienes,una,cita,con,paqui]

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [pon, un, evento, con, peter].
%	evento_creado

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [que, tengo, el, dia, 25, a, las, 11].
%	[tienes,un,evento,con,peter]
%
%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [pon, una, cita, con, juan, mañana, a, las, 18, durara, 21, minutos].
%	cita_creada

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [pon, una, cita, con, juan, mañana, a, las, 18, durara, 21, minutos].
%	cita_creada

%	(Mañana es 11 de junio para el programa)
%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [cuanto, durara, la, cita, con, juan, el, dia, 11].
%	[tu,cita,con,juan,el,dia,11,de,junio,durara,21,minutos]

%%%%%%% Creamos eventos, reuniones y citas. Para cada día se muestran los tres tipos.
%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [que, hay, el, 24, de, julio].
%	[[evento,con,juan,el,24,de,julio,a,las,12,y,0,minutos,durante,30,minutos],
%	[reunion,con,pedro,el,24,de,julio,a,las,8,y,0,minutos,durante,30,minutos],
%	[cita,con,maria,el,24,de,julio,a,las,4,y,0,minutos,durante,30,minutos]]

%% También podemos preguntar por un tipo en particular.

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [dime, las, citas, del, 24, de, julio].
%	[[cita,con,maria,el,24,de,julio,a,las,4,y,0,minutos,durante,30,minutos]]

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [dime, las, reuniones, del, 24, de, julio].
%	[[reunion,con,pedro,el,24,de,julio,a,las,8,y,0,minutos,durante,30,minutos]]

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [dime, los, eventos, del, 24, de, julio].
%	[[evento,con,juan,el,24,de,julio,a,las,12, y,0,minutos,durante,30,minutos]]


%%%%%%%%% Ahora realizamos preguntas parciales.
%		 La idea es guardar lo necesario para reutilizar funciones ya escritas.
%		 Las reconsultas pueden no tener sentido porque se muestra todo desde un 
% 		 inicio, pero si se omitiesen los datos en la salida lo tendría.

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [que, tengo, el, dia, 24, de, julio, a, las, 12].
%	[tienes,un,evento,con,juan]

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [y, a, las, 8].
%	[tienes,una,reunion,con,pedro]

%	Escribe frase entre corchetes separando palabras con comas 
%	o lista vacía para parar 
%	|: [y, cuanto, durara].
%	[tu,reunion,con,pedro,el,dia,24,de,julio,durara,30,minutos]