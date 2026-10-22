%% Base de conocimientos de ejemplo: intercambio estudiantil
%% alumno(nombre,edad,promedio)

alumno(arnold,18,8).
alumno(jimmy,17,10).
alumno(timmy,12,4).
quiereViajar(jimmy).
quiereViajar(arnold).
escolta(timmy).

promedioAlto(X):-alumno(X,E,P),gt(P,7).
mayorDeEdad(X):-alumno(X,E,P),gt(E,17).

cumpleCondiciones(X):-promedioAlto(X),mayorDeEdad(X).
cumpleCondiciones(X):-escolta(X),mayorDeEdad(X).

vaDeIntercambio(X):-cumpleCondiciones(X),quiereViajar(X).
