% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N 23
%ok,funziona
%



piu_piccolo([T|C],Min):-
    min(T,C,Min).

min(Min,[],Min).
min(a(I),[a(Y)|C],Min):-
    I < Y ,
    Min1 = a(I),
    min(Min1,C,Min).
min(_,[Elemento|C],Min):-
    min(Elemento,C,Min).


ordina(L,L1):-
    quicksort2(L,L1).

quicksort2([X|Xs],Ys) :-
  partitio2(Xs,X,Left,Right),
  quicksort2(Left,Ls),
  quicksort2(Right,Rs),
  appen2(Ls,[X|Rs],Ys).
quicksort2([],[]).

partitio2([a(X)|Xs],a(Y),[a(X)|Ls],Rs) :-
  X > Y, partitio2(Xs,a(Y),Ls,Rs).
partitio2([a(X)|Xs],a(Y),Ls,[a(X)|Rs]) :-
  X =< Y, partitio2(Xs,a(Y),Ls,Rs).
partitio2([],_,[],[]).

appen2([],Ys,Ys).
appen2([X|Xs],Ys,[X|Zs]) :- appen2(Xs,Ys,Zs).





