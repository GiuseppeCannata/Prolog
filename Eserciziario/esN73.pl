

a([1,2,3,4]).
b([2,9,6,1]).
c(['+','-','*','+']).


operazioni(A,+,B,Ris):-
    Ris is A+B.

operazioni(A,-,B,Ris):-
        Ris is A-B.

operazioni(A,*,B,Ris):-
         Ris is A*B.

go:-
    a(L1),
    b(L2),
    c(L3),
    scorri(L1,L2,L3,Risultati),
    writeln(Risultati).

scorri([],[],[],[]).
scorri([X1|C1],[X2|C2],[X3|C3],[Ris|Risultati]):-
    operazioni(X1,X3,X2,Ris),
    scorri(C1,C2,C3,Risultati).



