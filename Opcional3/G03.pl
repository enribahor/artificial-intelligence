
verbo(Infinitivo, Tiempo, Persona, Numero) -->
                  [V],
                  { name(V, VerboCadena),
                    append(RaizCad, TerminacionCad, VerboCadena),
                    name(Raiz, RaizCad),
                    es_verbo(Raiz, Infinitivo),
                    name(Terminacion, TerminacionCad),
                    es_terminacion(Terminacion, Tiempo, Persona, Numero)
                  }.

% DICCIONARIO

pronombre(Persona, Numero) --> 
					[P],
					{
					es_pronombre(P, Persona, Numero)					
					}.

es_verbo(pint, pintar).
es_verbo(habl, hablar).
es_verbo(am, amar).
es_verbo(compr, comprar).

%verbo( I, T, P, N, [amar�s],[]).

es_terminacion(ar�, futuro, 1, singular).
es_terminacion(ar�s, futuro, 2, singular).
es_terminacion(ar�, futuro, 3, singular).
es_terminacion(aremos, futuro, 1, plural).
es_terminacion(ar�is, futuro, 2, plural).
es_terminacion(ar�n, futuro, 3, plural).

es_terminacion(o, presente, 1, singular).
es_terminacion(as, presente, 2, singular).
es_terminacion(a, presente, 3, singular).
es_terminacion(amos, presente, 1, plural).
es_terminacion(a�is, presente, 2, plural).
es_terminacion(an, presente, 3, plural).


es_pronombre(Yo, 1, singular).
es_pronombre(T�, 2, singular).
es_pronombre(�l, 3, singular).
es_pronombre(Ella, 3, singular).
es_pronombre(Nosotros, 1, plural).
es_pronombre(Vosotros, 2, plural).
es_pronombre(Ellos, 3, plural).
es_pronombre(Ellas, 3, plural).

%si acaban en s plural, si no es singular.
%si terminan en -a, -as femenino. Si no masculino.
%el art�culo debe concordar con el nombre

articulo(Genero, Numero) --> [A],
					{
					(A, Genero, Numero)
					}.

es_articulo(el, masculino, singular).
es_articulo(la, femenino, singular). 
es_articulo(los, masculino, plural).
es_articulo(las, femenino, plural).

nombre(Genero, Numero) -->   [N],
                  { name(N, NombreCadena),
                    append(RaizCadena, PostfijoCadena, NombreCadena),
					name(Raiz, RaizCadena),
                    es_nombre(Raiz),                  
                    name(Postfijo, PostfijoCadena),
                    es_postfijo(Postfijo, Genero, Numero)
                  }.
es_nombre(perr).
es_nombre(gat).
es_nombre(cierv).
es_nombre(conej).

es_nombre(jarr).
es_nombre(puert).
es_nombre(ni�).

nombre --> [N], 
			{
			es_nombre_completo(N)
			}.

			
es_nombre_completo(flores).
es_nombre_completo(corchetes).


es_postfijo(o, masculino, singular).
es_postfijo(a, femenino, singular). 
es_postfijo(os, masculino, plural).
es_postfijo(as, femenino, plural).
				
complemento --> 
			articulo(Genero, Numero),
			nombre(Genero, Numero).
			
complemento --> 
			nombre.	
				
frase --> pronombre(Persona, Numero), verbo(_,_,Persona,Numero), complemento.

%La frase consta de pronombre, verbo y un complemento directo. El complemento directo 
%puede ser un nombre solo o un art�culo mas un nombre que concuerden en g�nero y n�mero.

%Los nombres con art�culo deben acabar en a, o, as u os.