% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%Es N61
%
%  Devo controllare perche non crea 100,300,500
%  e poi devo convertire la lista in numeri
%

posto_cifra(1,[0,2,4,9]).
posto_cifra(2,[1,2,3,4,5,6,7]).
posto_cifra(3,[1,3,5,7,9]).
ripetizioni(0,2).
ripetizioni(1,2).
ripetizioni(2,1).
ripetizioni(3,2).
ripetizioni(4,1).
ripetizioni(5,2).
ripetizioni(6,1).
ripetizioni(7,2).
ripetizioni(8,0).
ripetizioni(9,3).

numeri:-
    findall( Posto , posto_cifra(Posto,_), [T|C]),
    max(T,C,MaxCifreNum),
    setof(Lista , (
                    costruisciNum(1,MaxCifreNum,[],Lista) ,
                    length(Lista,3)
                   )
          , Numeri),
      stampa(Numeri).

stampa([]).
stampa([T|C]):-
    write(T),nl,
    stampa(C).


costruisciNum(Cont,Max,Ripetizioni,[Cifra|Numero]):-
    posto_cifra(Cont,ListaEsclusi),
    between(0,9,Cifra),
    \+ member(Cifra,ListaEsclusi),
    controlloRipetizioni(Cifra,Ripetizioni,NuovaListaRip),
    Cont1 is Cont+1,
    costruisciNum(Cont1,Max,NuovaListaRip,Numero).
costruisciNum(_,_,_,[]).


controlloRipetizioni(Cifra,Old,Nuova):-
    ripetizioni(Cifra,NumRipPossibili),
    \+ NumRipPossibili = 0,
    member(Cifra/OldRip , Old ),
    NuovaRip is OldRip+1,
    NuovaRip =< NumRipPossibili,
    aggiorna(Cifra/NuovaRip,Old,Nuova),
    !.

controlloRipetizioni(Cifra,Old,[Cifra/1|Old]):-
    ripetizioni(Cifra,NumRipPossibili),
    \+ NumRipPossibili = 0,
     \+ member(Cifra/_,Old),
    !.

aggiorna(Cifra/NuovaRip,Old,Nuova):-
    append(T,C,Old),
    C = [Cifra/_|Coda],
    append(T,Cifra/NuovaRip,Parziale),
    append(Parziale,Coda,Nuova).

max(Max,[],Max).
max(Elemento,[T|C],Max):-
    Elemento > T,
    Max1 = Elemento,
    max(Max1,C,Max).
max(_,[Elemento|C],Max):-
    max(Elemento,C,Max).
