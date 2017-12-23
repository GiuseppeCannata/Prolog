



:-op(30,fx,->).
:-op(100,xfy,and).
:-op(100,xfy,or).


%L idea è questa:
%        io dichiaro tutte le formule possibili che ci possono essere
%        all interno di una Proposizione, e vado di volta in volta a
%        vere se sono ben formate.
%
%          regola(X):-
%              predicato(X).
%
%          corrisponde alla clausola tappo in cui arrivero dopo aver
%          scisso tutte le formule
%
%
% Sembra funzionare

costante(a).
costante(b).
costante(c).
costante(d).
funzione(f,1).
funzione(g,2).
funzione(h,3).
funzione(i,4).
predicato(p,1).
predicato(q,2).
predicato(r,3).
predicato(s,4).
variabile(x).
variabile(y).
variabile(z).


termine(X):-
    costante(X),!.
termine(X):-
    variabile(X),!.
termine(X):-
    X=..[Funtore|Argomenti],
    length(Argomenti,Lung),
    funzione(Funtore,Lung),!.

regola(exists(V,Formula)):-
    variabile(V),
    regola(Formula).

regola(all(V,Formula)):-
    variabile(V),
    regola(Formula).


regola(A and B):-
    \+ termine(A),
    \+ termine(B),
    regola(A),!,
    regola(B).

regola(A -> B):-
      \+ termine(A),
      \+ termine(B),
      regola(A),!,
      regola(B).

regola(A or B):-
    \+ termine(A),
    \+ termine(B),
    regola(A),!,
    regola(B).

regola(X):-
    predicato(X).

predicato(P):-
    P=..[Funtore|Argomenti],
    regolapredicato(Funtore,Argomenti).

regolapredicato(Funtore,Argomenti):-
    predicato(Funtore,AritaDB),
    length(Argomenti,AritaDB),
    (
        AritaDB = 1,
        Argomenti = [X],
        termine(X)
        ;
        AritaDB > 1,
        findall(X, (
                     member(X,Argomenti),
                     termine(X)
                    ),
                Lista),
        length(Lista,AritaDB)
    ).

fbf(FP):-
   regola(FP).



