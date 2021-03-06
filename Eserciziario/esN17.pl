%Es N 17
% ok, esce, ho avuto problemi con il quick per la clausola tappo. HO
% UTILIZZATO LA LISTA VISITATE
%
%
%

lettere(Atom):-
    atom_chars(Atom, ListaCaratteri), %mi permette di convertire la stringa Atom in una lista di caratteri 'ciao'-->['c','i','a','o']
    verifica(ListaCaratteri,[],ListaConOccor),  %ListaConOccor = [c/1, i/1 |...]
    quicksort1(ListaConOccor,Ordinata),
    write('Nomi'),write(' '),write('Occorrenze'),nl,
    stampa(Ordinata),
    !.

verifica([],_,_).
verifica([T|C],ListaVisitati,ListaConOccor):-
    \+ T = ' ',
    \+ member(T,ListaVisitati),
    minuscola(T),
    occorrenza(T,C,1,Occor), %1 parto da uno perch� almeno uno c �
    crealista(T/Occor, C,[T|ListaVisitati], ListaConOccor).
verifica([_|C],Visitati,ListaOccor):-
    verifica(C,Visitati,ListaOccor).



minuscola(Lettera):-
    name(Lettera,[X]),
    between(97,122,X). %ok se � compresa la lettera � minuscola

%restituisce l occorrenza della lettera nella stringa
occorrenza(_,[],Occor,Occor).
occorrenza(Elem,[T1|C1],Acc,Occor):-
    Elem = T1,
    Occor1 is Acc+1,
    occorrenza(Elem, C1, Occor1, Occor).
occorrenza(Elem,[_|C1],Acc,Occor):-
    occorrenza(Elem,C1,Acc,Occor).

%creazione della lista si fatta [ lettera/occorrenza |... ]
crealista(T/Occor, ListaCaratteri , Visitati, [T/Occor|C]):-
    verifica(ListaCaratteri ,Visitati,C).


quicksort1([L|Xs],Ys) :-
  partitio(Xs,L,Left,Right),
  quicksort1(Left,Ls),
  quicksort1(Right,Rs),
  appen(Ls,[L|Rs],Ys).
quicksort1([],[]).

partitio([],L1,[],[]).
partitio([L/X|Xs],L1/Occor,[L/X|Ls],Rs) :-
  name(L,[Numx]),
  name(L1,[Numy]),
  Numx =< Numy, partitio(Xs,L1/Occor,Ls,Rs).
partitio([L/X|Xs],L1/Occor,Ls,[L/X|Rs]) :-
  name(L,[Numx]),
  name(L1,[Numy]),
  Numx > Numy, partitio(Xs,L1/Occor,Ls,Rs).
appen([],Ys,Ys).
appen([L/X|Xs],Ys,[L/X|Zs]) :- appen(Xs,Ys,Zs).

stampa([]).
stampa([Elem/Occor|C]):-
    write(Elem),write('      '),write(Occor),nl,
    stampa(C).









/*PENSATO MALE

fine(end_of_file).

lettere(Nome):-
    open(Nome,read,Stream),
    prendi(_,Stream,L),
    %ordinare,
    write('lettera'),write(' '),write('presenza'),
    stampa(L).


minuscola(Lettera,_,_):-
    name(Lettera,[X]),
    between(97,122,X). %ok se � compresa la lettera � minuscola

minuscola(_,Stream,L):- %nel caso fallisse quello prima significa che ho una lettera maiuscola
    prendi(_,Stream,L).


prendi(X,Stream,L):-
    read(Stream,X),
    read(Stream,Y),
    \+ fine(X),
    minuscola(X,Stream,L), %se non � minuscola fallisce e va di back
    crealista(X/Y,L,Stream).

prendi(_,Stream,_):-
    close(Stream).

crealista(X/Y,[X/Y|C],Stream):-
    prendi(_,Stream,C).

stampa([]).
stampa([X/Y|C]):-
    write(X),write(' '),write(Y),
    stampa(C).


*/
