alumno(arnold,18,7.6).
alumno(jimmy,17,9.9).
alumno(timmy,12,4.0).
quiereViajar(jimmy).
quiereViajar(arnold).
escolta(timmy).

promedioAlto(X):-alumno(X,Y,Z),gt(Z,7.0).
mayorDeEdad(X):-alumno(X,Y,Z),gt(Z,17).

cumpleCondiciones(X):-promedioAlto(X),mayorDeEdad(X).
cumpleCondiciones(X):-escolta(X),mayorDeEdad(X).

vaDeIntercambio(X):-cumpleCondiciones(X),quiereViajar(X).
