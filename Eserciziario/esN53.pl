% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.


run(N):-
    chiedi([],0,L),
    length(L,Lunghezza),
    setof(   numeri(Lunghezza,L,Numero).


chiedi(['basta'|Lista],_,Lista).
chiedi(Lista,10,Lista).
chiedi([X|Visitati],Cont,Lista):-
    member(X,Visitati),
    write('Gia inserito'),
    Cont1 is Cont-1,
    chiedi(Visitati,Cont1,Lista).
chiedi(Visitati,Cont,Lista):-
    write('Dai cifra __'),
    read(X),
    Cont1 is Cont+1,
    chiedi([X|Visitati],Cont1,Lista).
numero(Elemento,Atom

numeri(1,L,L).
numeri(2,L,Numero):-
    member(X,L), member(Y,L),

numeri(3,L,N).
numeri(4,L,N).
numeri(5,L,N).
numeri(6,L,N).
numeri(7,L,N).

atom_number(A,1).
numero(Lista,N)
numeri(8,L,N).
numeri(9,L,N).
numeri(10,L,N).

