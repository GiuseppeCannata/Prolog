


pezzi(23412,2).
pezzi(23512,1).
pezzi(23712,4).
pezzi(43412,1).

pezzi(23414,4).
pezzi(23514,2).
pezzi(23714,5).
pezzi(53412,2).

pezzi(23415,3).
pezzi(23518,2).
pezzi(23717,5).
pezzi(63412,9).

pezzi(23418,2).
pezzi(23519,8).
pezzi(23519,2).
pezzi(26412,1).



run(T):-
    write('Dai codice'),nl,
    read(COD),
    atom_chars(COD,CodiceIns),
    predicato(CodiceIns,[],0,T).

predicato(CodiceIns,Usati,Prezzo,T):-
    pezzi(X,P),
    \+ member(X-P,Usati),
    atom_chars(X,CodiceDB),
    match(CodiceIns,CodiceDB),
    Prezzo1 is Prezzo+P,
    predicato(CodiceIns,[X-P|Usati],Prezzo1,T).
predicato(_,_,T,T).

match([],[]).
match([T|C],[T|C1]):-
    match(C,C1).
match(['?'|C],[_|C1]):-
    match(C,C1).
