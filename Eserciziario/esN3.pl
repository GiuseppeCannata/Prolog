%esercizio 3
%
%
% è GIUSTA QUESTA VERSIONE POICHè SE MEMBER FALLISCE IO ANDRO DI
% BACKTRACKING E CERCANDO DI NEGARE INTERSEZIONE ANDRO A QUELLA DOPO CHE
% SCALERà LA LISTA DI UNO E RICHIAMERA LA SECONDA
intersezione([],_,[]).
intersezione([T|C], L, [T|U]):-
     member(T,L),
     intersezione(C,L,U).

intersezione([_|C], L, L1):-
     intersezione(C,L,L1).

%unione di due liste, senza creare dei doppioni

unione([],L2,L2).
unione([T1|C1],L2,[T1|U]):-
    \+ member(T1,L2),
    unione(C1,L2,U).

unione([_|C],L2,L):-
     unione(C,L2,L).
