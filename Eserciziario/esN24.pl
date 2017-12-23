% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N 24
%Da terminare, eseguilo e vedi cosa manca
%
%
trova_nesimo([],_,[]).
trova_nesimo([T|C],X,L1):-
    length(T,Lunghezza),
    \+ Lunghezza < X,
    scorri(T,X,1,Elemento),
    crealista(C,X,Elemento,L1).

trova_nesimo([_|C],X,L1):-
    trova_nesimo(C,X,L1).

scorri([Elemento|_],N,N,Elemento).
scorri([T|C],X,Acc,Elemento):-
    Acc1 is Acc+1,
    scorri(C,X,Acc1,Elemento).


crealista(Input,X,Elemento,[Elemento|C]):-
    trova_nesimo(Input,X,C).
