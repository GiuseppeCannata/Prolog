%Esercizio 14
%ok,ma verifica un altra volta
%
caratteredifine(0).

run:-
     inserimento(L),     %creazione della lista
     prendiUltimo(L,U),  %prendo l ultimo elemento della lista
     verifica(U,L,_).    %vedo se U < 10 altrimenti mi regolo di conseguenza

%creazione della lista
inserimento(L):-
     read(X),
     crealista(X,L).
crealista(A,[]):-
    caratteredifine(A).
crealista(Atom,[Atom|C]):-
    inserimento(C).


%estraggo l ultimo elemento della lista
prendiUltimo([_,N2|[]],N2).
prendiUltimo([_|C],U):-
     prendiUltimo(C,U).


%vedo se U < 10: se � si trovo le occorrenze nella lista
% se U > 10: trovo un antecendente dell ultimo numero, che sia minore di
% 10 e trovo le sue occorrenze nella lista
% se non c � nessun numero < 10 lo scrivo a schermo
verifica(U,L,Occor):-
     U < 10,
     scorri(U,L,0,Occor),
     write('Occorrenze '),write(U ),write(=),write(Occor).
verifica(U,L,Occor):-
    U > 10,
    cerca(Altro,L),   %cerco il primo antecedente dell ultimo < 10
    verificaAltro(Altro,L,Occor). %verifica se la variabile altro � istanziata

verificaAltro(Altro,L,Occor):-
    number(Altro),  %se � istanziata vedo le occorrenze altrimenti stampo che i numeri sono tutti maggiori di zero
    scorri(Altro,L,0,Occor),
    write('Occorrenze '),write(Altro ),write(=),write(Occor).
verificaAltro(_,_,_):-
    write('Non ci sono elementi minori di 10 nella lista').


% scorre tutta la lista trovando le occorrenze nella lista dell elemento
% U
scorri(_,[],Occor,Occor).
scorri(U,[T|C],Cont,Occor):-
     U = T,
     Occor1 is Cont+1,
     scorri(U,C,Occor1,Occor).
scorri(U,[_|C],Cont,Occor):-
     scorri(U,C,Cont,Occor).


%cerca il primo numero minore di 10
cerca(_,[]).
cerca(U,[T|C]):-
    cerca(U,C),
    T > 10.

cerca(T,[T|_]).  %per quando  T > 10 fallisce


