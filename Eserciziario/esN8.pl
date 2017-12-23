
fine('fine').


richiesta(L):-
    inserisci(Atom),
    \+ fine(Atom),
    trova(Atom,L).
richiesta(_).

inserisci(Atom):-
    write('Dammi l atomo: '),
    read(Atom).


trova(Atom,L):-
    member(Atom,L),

    findall(Pos, scorri(Atom,L,1,Pos), LI),
    write('La posizione e: '),write(LI),nl,richiesta(L).


trova(Atom,L):-
    write(Atom),write('no appartiene alla lista'),nl,
    richiesta(L).

scorri(Atom,[Atom|C],Pos,Pos).
scorri(Atom,[T|C],Acc,Pos):-
    Pos1 is Acc+1,
    scorri(Atom,C,Pos1,Pos).

