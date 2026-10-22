%% Base de conocimientos de ejemplo: operaciones built-in
%% Incluye operaciones built-in anidadas

suma(X,Y,Z):-Z=add(X,Y).
resta(X,Y,Z):-Z=sub(X,Y).
multiplicacion(X,Y,Z):-Z=mult(X,Y).

sumaYDuplica(X,Y,Z):-Z=mult(add(X,Y),2).
distintos(X,Y):-not(eq(X,Y)).
diferenciaPositiva(X,Y):-gt(sub(X,Y),0).
