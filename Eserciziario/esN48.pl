% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%Es N48
%
%

fine(fine).
run(L1,L2):-
    chiedi([],ListaInseriti),
   % findall(Carattere,( chiedi(Carattere) ), ListaInseriti),
    crea(ListaInseriti,L1,L2).


chiedi(Inseriti,ListaInseriti):-
    write('Inserisci: '),
    read(Carattere),nl,
    \+ fine(Carattere),
    inserisci(Carattere,Inseriti,ListaInseriti).
chiedi(Inseriti,Inseriti).

inserisci(Carattere,Inseriti,ListaInseriti):-
    \+ member(Carattere,Inseriti),
    chiedi([Carattere|Inseriti],ListaInseriti).
inserisci(_,Inseriti,ListaInseriti):-
    chiedi(Inseriti,ListaInseriti).


crea([],[],[]).
crea([T|C],[T|C1],L2):-
    number(T),
    crea(C,C1,L2).
crea([T|C],L1,[T|C2]):-
    crea(C,L1,C2).




