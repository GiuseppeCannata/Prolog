




:- op(30,fx,non).
:- op(100,xfy,or).
:- op(100,xfy,and).

%! %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
substitute(Old,New,Old,New) :- !.

substitute(Old,New,Term,Term):-
           atomic(Term),
           Term \= Old.

substitute(Old,New,Term,Term1):-
          \+ atomic(Term),
          functor(Term,F,N),
          functor(Term1,F,N),
          substitute(N,Old,New,Term,Term1).

substitute(N,Old,New,Term,Term1):-
          N > 0,
          arg(N,Term,Arg),
          substitute(Old,New,Arg,Arg1),
          arg(N,Term1,Arg1),
          N1 is N - 1,
          substitute(N1,Old,New,Term,Term1).

substitute(0,Old,New,Term,Term1).
%! %%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
valore(f, f) :-!.

valore(v, v) :- !.

valore(non v, f) :- !. % tabella di verità del connettivo non
valore(non f, v) :- !. %
valore(v and v, v) :- !. %tabella di verità del connettivo and
valore(v and f, f) :- !. %
valore(f and v, f) :- !. %
valore(f and f, f) :- !. %
valore(v or v, v) :- !. % tabella di verità del connettivo or
valore(v or f, v) :- !. %
valore(f or v, v) :- !. %
valore(f or f, f) :- !. %

valore(non A,X) :- % determinazione del valore di verità
      valore(A,A1), % della formula non A, dove A é una
      valore(non A1,X). % formula proposizionale

valore(A and B,X) :- % determinazione del valore di verità
      valore(A,A1), % della formula A and B, dove A e B
      valore(B,B1), % sono formule proposizionali
      valore(A1 and B1,X). %

valore(A or B,X) :- % determinazione del valore di verità
      valore(A,A1), % della formula A or B, dove A e B
      valore(B,B1), % sono formule proposizionali
      valore(A1 or B1,X).


tautologia(FP):-
    trovaAtomi(FP,LA),
    setof(V, (
                genera(LA,Sequenza),
                sostituisci(LA,Sequenza,FP,V)
               ),
          ListaValori),
    controllo(ListaValori).

controllo([]).
controllo(['v'|C]):-
    controllo(C).

trovaAtomi(FP,LA):-
    setof(Atom,atomi(FP,Atom),LA).

atomi(Atom,Atom):-
       atomic(Atom).
atomi(FP,Atom):-
    \+ atomic(FP),
    FP=..[Funtore|Argomenti],
    member(X,Argomenti),
    atomi(X,Atom).


genera([],[]).
genera([_|C],[X|Sequenza]):-
    member(X,[v,f]),
    genera(C,Sequenza).

sostituisci([],[],FPV,V):-
    valore(FPV,V).
sostituisci([T|C],[Valore|C1],FP,V):-
    substitute(T,Valore,FP,FPV1),
    sostituisci(C,C1,FPV1,V).

