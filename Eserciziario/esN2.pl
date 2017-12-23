salute(giorgio).
salute(anna).
salute(marco).
salute(maria).
salute(alberto).
ama(giorgio,elisa).
ama(massimo,elisa).
ama(marco,maria).
ama(elisa,giorgio).
ama(anna,giorgio).
ama(maria,alberto).
ama(alberto,maria).

felice(X):-
     salute(X),
     ama(X,_).

felici(X,Y):-
     salute(X),
     salute(Y),
     ama(X,Y),
     ama(Y,X).
