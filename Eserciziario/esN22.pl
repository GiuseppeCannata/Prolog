% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
%then enter the text in that file's own buffer.

%es N 22
%Ok, funziona
%
fine(0).

medie(X,N):-
    main(0,N,0,X). %x dove metterò la lista


main(NumInseriti,N,VecchiaSomma,L):-
    prendi(Elemento,N),
    Inseriti is NumInseriti+1,  %tiene conto di quanti elementi sono stati inseriti dall utente
    media(Elemento,Inseriti,Media,VecchiaSomma,SommaNuova),
    write('Sono stati immessi '),write(Inseriti),write(' numeri'),write(' la cui media è'),write(Media),
    crealista(Elemento,L, Inseriti, N, SommaNuova).

main(_,_,_,[]). % serve per quando fallisce il prendi


crealista(Atom,[Atom|C],Inseriti, N, SommaNuova ):-
   main(Inseriti, N, SommaNuova ,C).

%prendi fallisce se
%1) Elemento = 0
%2) se Elemento non è un numero
%3) se Elemento > N
prendi(Elemento,N):-
    nl,write('Dai Elemento: '),
    read(Elemento),
    number(Elemento),
    \+ fine(Elemento),
    Elemento < N.

%setisco il caso in cui Elemento sia una lettera o un numero > N
prendi(Elemento,N):-
    \+ fine(Elemento),
    write('Controllrare!'),nl,write('Non sono ammessi ne lettere ne numeri maggiori di'),write(N),nl,
    prendi(_,N).

% effettua la media tenendo conto della VecchiaSomma utilizzata per il
% calcolo della media al passo precedente
media(Elemento,QuantiNumInseriti,Media,VecchiaSomma,Somma):-
    Somma is Elemento+VecchiaSomma,
    Media is Somma/QuantiNumInseriti.

