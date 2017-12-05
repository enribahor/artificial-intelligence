frase --> grupo_nominal(Numero),
 verbo(X,Y,Z,Numero).
grupo_nominal(Numero) --> nombre(Numero).
verbo(X,Y,Z,Numero) --> verbo(X,Y,Z,Numero),
 grupo_nominal(Numero1).
%Complemento Directo: no concuerda con el verbo.
verbo(X,Y,Z,Numero)--> verbo(X,Y,Z,Numero).
nombre(plural) --> [manzanas].
nombre(singular) --> [juan].
%verbo(singular) --> [come]. 

