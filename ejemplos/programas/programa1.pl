%% Base de conocimientos de ejemplo: relaciones familiares
%% Hechos y reglas, con consultas de solución única y múltiple

%% Hechos
padre(juan,maria).
padre(juan,pedro).
padre(pedro,ana).
madre(luisa,maria).
madre(luisa,pedro).

%% Reglas
abuelo(X,Y):-padre(X,Z),padre(Z,Y).
abuelo(X,Y):-padre(X,Z),madre(Z,Y).
