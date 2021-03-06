% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

nera(1,5).
nera(2,2).
nera(3,2).
nera(4,2).
nera(5,2).
nera(6,2).
nera(3,3).
nera(3,4).
nera(6,1).
nera(5,1).

p(aiuola).
p(spia).
p(bo).
p(aio).
p(ama).
p(si).
p(no).
p(po).


a(2,1,a).
a(3,1,m).
a(4,1,a).

a(1,2,s).
a(2,2,i).

a(4,3,a).
a(5,3,b).
a(6,3,a).

a(1,3,p).
a(2,3,o).






stampa([]).
stampa([T|C]):-
    writeln(T),
    stampa(C).

trovaParola:-



cercaOrizzontale():-
    destra(X,X1),
    \+ nera(X1,Y),
    \+ between(1,6,X1),
    a(X,Y,Lettera).

    procedi(X,Y,[Lettera],Parola),
    cercaOrizzontale(
    stampa(ListaDestra).

destra(X,X1):-
    X1 is X+1.

procedi(X,Y,Lista,Parola):-
    destra(X,X1),
    (
         nera(X1,Y)
         ;
         \+ between(1,6,X1)
    ),
    reverse(Lista,L1),
    controllo(L1,Parola).
procedi(X,Y,Lettera,Parola):-
    destra(X,X1),
    \+ nera(X1,Y),
    a(X1,Y,NLettera),
    procedi(X1,Y,[NLettera|Lettera],Parola),
    !.

controllo(Lista,Parola):-
    atom_chars(Parola,Lista),
    p(Parola).

