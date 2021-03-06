% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.



%OK
%
%
p(abaco).
p(aia).
p(amai).
p(car).
p(cera).
p(emo).
p(ram).
p(roma).
p(zuzzurellone).

stampa([]).
stampa([T|C]):-
    atom_chars(Parola,T),
    writeln(Parola),
    stampa(C).


cruciverba(M,N):-
    costruzione(M,N,[],Cruci1),
    reverse(Cruci1,Cruci),
    controlloEsatezza(N,Cruci),
    stampa(Cruci).

costruzione(0,_,Cruci,Cruci).
costruzione(Riga,Colonna,App,Cruci):-
    p(Parola),
    atom_chars(Parola,ListaParola),
    \+ member(ListaParola,App),
    length(ListaParola,Colonna),
    Riga1 is Riga-1,
    costruzione(Riga1,Colonna,[ListaParola|App],Cruci).

controlloEsatezza(N,Cruci):-
    trasposta(1,N,Cruci,CruciT),
    controlloParola(CruciT).

controlloParola([]).
controlloParola([T|C]):-
    atom_chars(Parola,T),
    p(Parola),
    controlloParola(C).


trasposta(Colonna,N,_,[]):-
    Colonna > N.
trasposta(Colonna,N,Mat,[Lista|MatT]):-
    prendi(Colonna,Mat,Lista),
    Colonna1 is Colonna+1,
    trasposta(Colonna1,N,Mat,MatT),
    !.
prendi(_,[],[]).
prendi(Colonna,[Lista|C],[Elemento|MatT]):-
    scorri(Colonna,1,Lista,Elemento),
    prendi(Colonna,C,MatT).
scorri(Colonna,Colonna,[Elemento|_],Elemento).
scorri(Colonna,Con,[_|C],Elemento):-
    Con1 is Con+1,
    scorri(Colonna,Con1,C,Elemento).







