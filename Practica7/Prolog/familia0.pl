/*
Inteligencia Artificial, Practica 7: Primera parte
Enrique Ballesteros e Ignacio Iker Prado Rujas (Grupo 03)
*/

dd(juan, maria, rosa, m).
dd(juan, maria, luis, h).
dd(jose, laura, pilar, m).
dd(luis, pilar, miguel, h).
dd(miguel,isabel,jaime,h).
dd(pedro, rosa, pablo, h).
dd(pedro, rosa, begoña, m).

padre(X, Y):- dd(X, _, Y, _).

madre(X, Y):- dd(_, X, Y, _).

hijo(X, Y):- dd(Y, _, X, h).
hijo(X, Y):- dd(_, Y, X, h).

hija(X, Y):- dd(Y, _, X, m).
hija(X, Y):- dd(_, Y, X, m).

hermano(X, Y):- dd(Z, J, X, h),
	dd(Z, J, Y, _),
	X\=Y.

hermana(X, Y):- dd(Z, J, X, m),
	dd(Z, J, Y, _),
	X\=Y.

progenitor(X, Y):- padre(X, Y).
progenitor(X, Y):- madre(X, Y).

abuelo(X, Y):- padre(X, Z),
	padre(Z, Y).
abuelo(X, Y):- padre(X, Z),
	madre(Z, Y).

abuela(X, Y):- madre(X, Z),
	madre(Z, Y).
abuela(X, Y):- madre(X, Z),
	padre(Z, Y).

primo(X, Y):- hijo(X, Z),
	progenitor(J, Y),
	hermano(Z, J).
primo(X, Y):- hijo(X, Z),
	progenitor(J, Y),
	hermana(Z, J).

prima(X, Y):- hija(X, Z),
	progenitor(J, Y),
	hermano(Z, J).
prima(X, Y):- hija(X, Z),
	progenitor(J, Y),
	hermana(Z, J).

ascendiente(X, Y):- progenitor(X, Y).
ascendiente(X, Y):- progenitor(Z , Y),
	ascendiente(X, Z).
