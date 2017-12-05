/*
Inteligencia Artificial, Practica 7: Segunda parte
Enrique Ballesteros e Ignacio Iker Prado Rujas (Grupo 03)
*/

%Representación de estados
%%	estado(Jarra3, Jarra4)
%    con Jarra3 cantidad de agua en la jarra 3
%    y Jarra4 cantidad de agua en jarra 4.


%Definimos los estado inicial y final.
%
inicial(estado(0,0)).
objetivo(estado( _, 2)).

%Definimos los operadores.
%El orden influirá en la ejecución.
%
operador(estado(Z, J), estado(3, J), llenar3) :- (Z < 3).
operador(estado(Z, J), estado(Z, 4), llenar4) :- (J < 4).
operador(estado(Z, J), (estado(0, X)), verter3) :-  (Z > 0), (J < 4), (Z + J) < 5, X is Z+J.
operador(estado(Z, J), (estado(X, 4)), verter3) :-  (Z > 0), (J < 4),  X is Z-4+J .
operador(estado(Z, J), (estado(X, 0)), verter4) :-  (Z < 3), (J > 0), (Z + J) < 4, X is Z+J.
operador(estado(Z, J), (estado(3, X)), verter4) :-  (Z < 3), (J > 0),  X is  J-3+Z .
operador(estado(Z, J), estado(0, J), vaciar3) :- (Z > 0).
operador(estado(Z, J), estado(Z, 0), vaciar4) :- (J > 0).

%Definimos la función. Caso base, y caso recursivo:
%
jarras(Estado, _, [], 0) :- objetivo(Estado).
jarras(Estado, Visitados, [OperadorActual|Operadores], N) :- operador(Estado, EstadoNuevo, OperadorActual),
	\+ member(EstadoNuevo, Visitados),jarras(EstadoNuevo,[EstadoNuevo|Visitados], Operadores, K), N is K+1.


%Realizamos la consulta comenzando en el estado inicial ya definido
%
consulta :- inicial(Estado), jarras(Estado,[Estado], ListaOperadores, K), write(ListaOperadores), write(K).











