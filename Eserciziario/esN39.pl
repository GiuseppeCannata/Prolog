%es N 39
% Ok, il cut non � dove dovrebbe essere, guarda esempio libro e
% risultato di questo algoritmo
%
%
uguali(Li,Lo):-
    findall(ListAtom,(member(Atom,Li), atom_chars(Atom, ListAtom)) ,ListAtoms),  %creo listAtoms cio� una lista di liste.Quest ultime hanno come argomenti le lettere degli atomi listAtoms=[[c,i,a,o],[n,o,n]]
    predicato(ListAtoms,[],List), %vedo se la prima e l ultima lettera sono uguali e se � si la parola la metto in List
    mergesort(List,ListOrdinata),
    !,%ordino
    conversione(ListOrdinata,Lo). %Converto trasformando le liste si fatte [c,i,a,o] , in atomi e inserirli nella lista Lo

predicato([],L,L).
predicato([ListAtom|C],Visitati,L):-
    prima(ListAtom,PrimaLettera),
    ultima(ListAtom,UltimaLettera),
    PrimaLettera = UltimaLettera,
    predicato(C,[ListAtom|Visitati],L).
predicato([_|C],Lista,L):-
    predicato(C,Lista,L).


prima([Lettera|_],Lettera).
ultima([Ultima|[]],Ultima).
ultima([_|R],Ultima):-
    ultima(R,Ultima).


mergesort([],[]).    /* covers special case */
mergesort([A],[A]).
mergesort([A,B|R],S) :-
   split([A,B|R],L1,L2),
   mergesort(L1,S1),
   mergesort(L2,S2),
   merg(S1,S2,S).

split([],[],[]).
split([A],[A],[]).
split([A,B|R],[A|Ra],[B|Rb]) :-  split(R,Ra,Rb).

merg(A,[],A):-!.
merg([],B,B):-!.
merg([A|Ra],[B|Rb],[A|M]) :-
    length(A,Lung1),
    length(B,Lung2),
    A=[T1|_],
    B=[T2|_],
    name(T1,[X1]),
    name(T2,[X2]),
    (
        T1 = T2,   %se i due atomi iniziano con la stessa lettera inserisco prima quello di lunghezza maggiore
        Lung1 > Lung2
        ;
        X1 < X2  %se la condizione sopra non si verifica l ordinamento � alfabetico in ordine crescente
    ),
   merg(Ra,[B|Rb],M).
merg([A|Ra],[B|Rb],[B|M]) :-
    A=[T1|_],
    B=[T2|_],
    name(T1,[X1]),
    name(T2,[X2]),
    X1 >= X2,
    merg([A|Ra],Rb,M).

conversione([],[]).
conversione([ListAtom|R],[Atom|U]):-
    atom_chars(Atom, ListAtom),
    conversione(R,U).





