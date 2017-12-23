% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.



%ES N58
% ok, manca da generare trasposta
%
matrice(M,MT):-
    write('Dimensione?'),nl,
    read(DIM),nl,nl,
    write('Elementi diversi da 1'),nl,
    prendi([],ListaDiversi),
    genera(1,1,ListaDiversi,DIM,M).

prendi(['basta'|ListaDiversi],ListaDiversi).
prendi(Lista,ListaDiversi):-
    read(Elemento),nl,
    prendi([Elemento|Lista],ListaDiversi).

%genero la matrice
genera(Riga,_,_,DIM,[]):-
    Riga > DIM.
genera(Riga,Colonna,Diversi,DIM,[R|Mat]):-
    colonna(Riga,Colonna,Diversi,DIM,R),
    Riga1 is Riga+1,
    genera(Riga1,Colonna,Diversi,DIM,Mat).

colonna(_,Colonna,_,DIM,[]):-
    Colonna > DIM.
colonna(Riga,Colonna,Diversi,DIM,[Numero|R]):-
    member([Riga,Colonna,Numero],Diversi),
    Colonna1 is Colonna+1,
    colonna(Riga,Colonna1,Diversi,DIM,R).
colonna(Riga,Colonna,Diversi,DIM,[1|R]):-
    Colonna1 is Colonna+1,
    colonna(Riga,Colonna1,Diversi,DIM,R).


