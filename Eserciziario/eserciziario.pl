
%esercizio 4
%
%problema con il false e con Atom if Atom == char
%is non vuole elementi a dx che siano char
%
sost([],_,_,[]).
sost([T|C],Num,Atom,[T1|U]):-
     T =:= Num,
     T1 is Atom,
     !,
     sost(C,Num,Atom,U).

sost([T|C],Num,Atom,[T1|U]):-
     T1 is T,
     sost(C,Num,Atom,U).

%esercizio 8
%
%

caratteredifine(.).

lista(L):-
     write('Inserire elemento:'),nl,
     get(X),   %restituisce ASCII
     name(Atom,[X]),   %conversione da ASCII a carattere
     crealista(Atom,L).

crealista(A,[]):-
    caratteredifine(A).
crealista(Atom,[Atom|C]):-
    lista(C).


posizionelista(X,L,Pos):-
     member(X,L),
     Acc is 1,
     scansiona(X,L,Acc,Pos).

posizionelista(_,_,_):-
     write('Non è contenuto nella lista').


scansiona(X,[T|C],Acc,Pos):-
     \+ X = T,
     Acc1 is Acc+1,
     scansiona(X,C,Acc1,Pos).

scansiona(_,_,Acc1,Acc1).


%ESERCIZIO 7
%ok
%
stampa([]).
stampa([T|C]):-
     write(T),write(' '),
     stampa(C).



genera(1,[]).
genera(N,[N|C]):-
    N1 is N-1,
    genera(N1,C).


primi(N,L):-
    genera(N,ListaNumeri),
    reverse(ListaNumeri,Inv),
    setaccio(Inv,L),
    !,
    stampa(L).


setaccio([],[]).
setaccio([T|C],[T|C1]):-
  %genero i multipli
  multipli(T,T,Multipli),
  eliminazione(C,Multipli,L),
  setaccio(L,C1).

multipli(N,A,[T|C]):-
    T is N+A,
    T =< 100,
    multipli(T,A,C).

multipli(_,_,[]).

eliminazione([],_,[]).
eliminazione([T|C],Multipli,[T|C1]):-
    \+ member(T,Multipli),
    eliminazione(C,Multipli,C1).

eliminazione([_|C],Multipli,L):-
      eliminazione(C,Multipli,L).

%esercizio 10
%ok
%

fine(fine).

trova_elemento:-
     lista2(L),
     length(L,Lu),   %Lu lunghezza lista
     verifica(L,Lu).

lista2(L):-
     write('Dai lista: '),
     read(L).

verifica(L,Lu):-
     write('Dai N: '),
     read(N),
     controllo(N,Lu,L).

controllo(N,_,_):-
       fine(N).

controllo(N,Lu,L):-
     N =< Lu,  %quando fallisce va a verifica sotto perche read è non risoddisfacilìbile
     posizione(L,N,0,Valore),
     write(Valore),nl,
     verifica(L,Lu).

verifica(L,Lu):-
     write('Errore '),nl,
     verifica(L,Lu).


posizione([_|C],N,Acc,Valore):-
     Acc1 is Acc+1,
     \+ N =:= Acc1,
     posizione(C,N,Acc1,Valore).

posizione([T|_],_,_,T).


%esercizio 11
%
%Manca l ordinamento del percorso secondo le lettere
s(1,4,a,3).
s(2,5,b,4).
s(3,8,c,15).
s(4,6,d,8).
s(5,8,e,7).
s(6,8,g,4).
s(8,12,i,6).
s(6,7,f,2).
s(7,9,h,2).
s(7,11,l,6).
s(9,10,m,3).

destinazione(10).


cercaPercorso(Lettera/Nodo,Percorso) :-
     ucs([0-[Lettera/Nodo]],C-P),bubble_sort(P, Sorted) ,Percorso=C-Sorted.




ucs([C-[Lettera/Nodo|Perc]|_],C-[Lettera/Nodo|Perc]) :-
	destinazione(Nodo).

ucs([C-Percorso|Percorsi],Soluzione):-
  espansione2(C-Percorso,PercorsiEstesi),
  fusioneOrdinata(PercorsiEstesi,Percorsi,NuoviPercorsi),
  ucs(NuoviPercorsi,Soluzione).


espansione2(C-[Lettera/N|P],Percorsi):-
  setof(CC-[NuovaLettera/NN,Lettera/N|P],C1^(s(N,NN,NuovaLettera,C1),\+ member(NN,[N|P]),CC is C+C1),Percorsi),
  !.
espansione2(_-_,[]). % non fa fallire espansione2

fusioneOrdinata([],L,L).
fusioneOrdinata(L,[],L).
fusioneOrdinata([C1-P1|CP1],[C2-P2|CP2],[C1-P1|Coda]) :-
	C1 =< C2,
	fusioneOrdinata(CP1,[C2-P2|CP2],Coda).
fusioneOrdinata([C1-P1|CP1],[C2-P2|CP2],[C2-P2|Coda]) :-
	C1 > C2,
	fusioneOrdinata([C1-P1|CP1],CP2,Coda).


inv(Lista,Invertita) :-
	inverti(Lista,[],Invertita).
inverti([],Invertita,Invertita).
inverti([T|C],Parziale,Invertita) :-
	inverti(C,[T|Parziale],Invertita).


%esercizio 12
% ok, ma non mi piace come l ho implementato, troppi quick potrei
% risolvere con una funzione max
%

piu_lunga(Lista,L,Lung):-
  solve1(Lista,ListaConLunghezze), %ListaConLunghezze è fatta cosi [3-[5,6,7],2-[1,4]|....],
  quicksort1(ListaConLunghezze,ListaConLunghezzeORD), %ordino listaConlunghezze rispetto la lunghezza di ogni lista
  length(ListaConLunghezzeORD,N), %calccolo quandi elementi ha
  max(ListaConLunghezzeORD,N,Lung,L1),  %prendo l ultimo elemento
  quicksort2(L1,L).%e ordino la lista copn cardinalita maggiore


solve1([],[]).
solve1([L1|C],[Lunghezza-L1|U]):-
     length(L1,Lunghezza),
     solve1(C,U).


quicksort1([L-X|Xs],Ys) :-
  partitio(Xs,L,Left,Right),
  quicksort1(Left,Ls),
  quicksort1(Right,Rs),
  appen(Ls,[L-X|Rs],Ys).
quicksort1([],[]).

partitio([L-X|Xs],L1,[L-X|Ls],Rs) :-
  L =< L1, partitio(Xs,L1,Ls,Rs).
partitio([L-X|Xs],L1,Ls,[L-X|Rs]) :-
  L > L1, partitio(Xs,L1,Ls,Rs).
partitio([],L1,[],[]).

appen([],Ys,Ys).
appen([L-X|Xs],Ys,[L-X|Zs]) :- appen(Xs,Ys,Zs).


max([_-_|Ln],N,Lungh,L):-
     N1 is N-1,
     \+ N1 = 0,
     max(Ln,N1,Lungh,L).
max([Lungh-L1|_],1,Lungh,L1).


quicksort2([X|Xs],Ys) :-
  partitio2(Xs,X,Left,Right),
  quicksort2(Left,Ls),
  quicksort2(Right,Rs),
  appen2(Ls,[X|Rs],Ys).
quicksort2([],[]).

partitio2([X|Xs],Y,[X|Ls],Rs) :-
  X =< Y, partitio2(Xs,Y,Ls,Rs).
partitio2([X|Xs],Y,Ls,[X|Rs]) :-
  X > Y, partitio2(Xs,Y,Ls,Rs).
partitio2([],Y,[],[]).

appen2([],Ys,Ys).
appen2([X|Xs],Ys,[X|Zs]) :- appen2(Xs,Ys,Zs).

%Esercizio 14
%
%
caratteredifine2(0).

run:-
     inserimento1(L),
     prendiUltimo(L,U),
     verifica1(U,L,0).


inserimento1(L):-
     read(X),
     crealista(X,L).
crealista(A,[]):-
    caratteredifine2(A).
crealista(Atom,[Atom|C]):-
    inserimento(C).

prendiUltimo([_,N2|[]],N2).
prendiUltimo([_|C],U):-
     prendiUltimo(C,U).

scorri(_,[],_).
scorri(U,[T|C],Occor):-
     U = T,
     Occor1 is Occor+1,
     scorri(U,C,Occor1).
scorri(U,[_|C],Occor):-
     scorri(U,C,Occor).


verifica1(U,L,Occor):-
     U < 10,
     scorri(U,L,Occor),
     write('Occorrenze '),write(U ),write(=),write(Occor).





















