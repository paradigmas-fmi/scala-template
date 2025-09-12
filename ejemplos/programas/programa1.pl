% Archivo de conocimiento Prolog de ejemplo
% Este archivo contiene reglas y hechos para el programa1

% Hechos
padre(juan,maria).
padre(juan,pedro).
padre(carlos,ana).
madre(luisa,maria).
madre(luisa,pedro).

% Reglas
abuelo(X,Y):-padre(X,Z),padre(Z,Y).
abuelo(X,Y):-padre(X,Z),madre(Z,Y).
