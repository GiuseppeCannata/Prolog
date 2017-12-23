


%esN43
%
%

run(L):-
    %con atomic tolgo ache eventuali atomi rappresentati da numeri
    findall(X,(member(X,L),\+ atomic(X), \+ contienefuntori(X)),Lista),
    sort(Lista,ListaOrdinata), %chiedere perchè non ordina lessograficamente
    write('Funtore'),write('     '),write('Argomenti'),
    stampa(ListaOrdinata).


stampa([]).
stampa([Termine|C]):-
    nl,
    Termine =..[Funtore|Argomenti],
    write(Funtore),write('          '),stampaargomenti(Argomenti),
    stampa(C).


stampaargomenti([]).
stampaargomenti([Argomento|C]):-
        write(Argomento),write(' '),
    stampaargomenti(C).

% permette di scomporre un predicato e capire se all interno ci sono
% altri predicati,
% ritorna true se ci sono
contienefuntori(Termine):-
    Termine =..L,
    member(X,L),
   \+ atomic(X).
