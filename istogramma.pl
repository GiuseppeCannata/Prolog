% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.



istogramma(L,Lista):-
    %utilizzo setof poichè mi ordine ed elimina i doppioni dalla lista
    setof(Lettera-Occ,( member(Lettera,L) , occorrenza(Lettera,L,0,Occ) ),Lista),     isto(Lista,0),
    !.

occorrenza(_,[],Occ,Occ).
occorrenza(Lettera,[Lettera|C],App,Occ):-
    Occ1 is App+1,
    occorrenza(Lettera,C,Occ1,Occ),
    !.
occorrenza(Lettera,[_|C],App,Occ):-
    occorrenza(Lettera,C,App,Occ),
    !.

isto(_,10).
isto(Lista,Cont):-
    \+ member(Cont-_,Lista),
    write(Cont),write(' '),nl,
    Cont1 is Cont+1,
    isto(Lista,Cont1).

isto(Lista,Cont):-
    member(Cont-Occ,Lista),
    write(Cont),write(' '),
    disegna(Cont,Occ),
    nl,
    Cont1 is Cont+1,
    isto(Lista,Cont1).

disegna(_,0).
disegna(Cont,Occ):-
    write('*'),
    Occ1 is Occ-1,
    disegna(Cont,Occ1).

