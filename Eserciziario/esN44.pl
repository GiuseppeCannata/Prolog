% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%esN 44
% ok, manca da ordinare lessicograficamente le parole per ogni
% corrispondenza
%

p(pino).
p(pippo).
p(vino).
p(tonno).
p(ceppo).
p(tino).
p(ceppi).
p(parigino).
p(ticino).
p(micino).
p(camicino).
p(gino).
p(cugino).

rima:-
    write('Dai parola'),nl,
    read(Parola), atom_chars(Parola,L1),reverse(L1,L11),
    creaListaCorrispondenze(L11,[],[],Results),
    quicksort(Results,ResultsOrdinato),  %ordino in maniera crescente in base alle corrispondenze
    stampa(ResultsOrdinato,_).

% creaListaCorrispondenze permette di creare la lista
% [Corrispondenze-Parola|...] le corispondenze non considerate sono
% quelle pari a 0, al termine di creaLista... avrò scorso tutto il DB e
% saprò per ogni parola quante corrispondenze ci sono con quella
% inserita dall utente


creaListaCorrispondenze(L11,Visitati,App,Results):-
    p(DB),
    \+ member(DB,Visitati),
    atom_chars(DB,L2),
    reverse(L2,L22),
    corrispondenze(L11,L22,0,Corrispondenze),
    \+ Corrispondenze = 0,
    creaListaCorrispondenze(L11,[DB|Visitati],[Corrispondenze-DB|App],Results).
creaListaCorrispondenze(_,_,Results,Results).



% predicato permette di segnare le corrispondenze di lettere tra le
% parole presenti nel DB e quella inserita
% PRE: le parole devo essere reverse


%caso in cui le due parole sono uguali
corrispondenze([],[],Corrispondenze,Corrispondenze).
corrispondenze([T|C],[T1|C1],Cont,Corrispondenze):-
    T = T1,
    Cont1 is Cont+1,
    corrispondenze(C,C1,Cont1,Corrispondenze).
%caso in cui fallisce quello sopra
corrispondenze(_,_,Corrispondenze,Corrispondenze).






quicksort([X|Xs],Ys) :-
  partitio(Xs,X,Left,Right),
  quicksort(Left,Ls),
  quicksort(Right,Rs),
  appen(Ls,[X|Rs],Ys).
quicksort([],[]).

partitio([Corrispondenze-Termine|Xs],Corrispondenze1-Termine1,[Corrispondenze-Termine|Ls],Rs) :-
  Corrispondenze =< Corrispondenze1,
  partitio(Xs,Corrispondenze1-Termine1,Ls,Rs).
partitio([Corrispondenze-Termine|Xs],Corrispondenze1-Termine1,Ls,[Corrispondenze-Termine|Rs]) :-
  Corrispondenze > Corrispondenze1,
  partitio(Xs,Corrispondenze1-Termine1,Ls,Rs).
partitio([],Y,[],[]).

appen([],Ys,Ys).
appen([X|Xs],Ys,[X|Zs]) :-
    appen(Xs,Ys,Zs).



stampa([],_).
stampa([Corrispondenze-Termine|C],Corrispondenze):-
    write('Numero corripondenze: '),write(Corrispondenze),nl,nl,
    stampaTermini([Corrispondenze-Termine|C],Corrispondenze).

stampaTermini([Corrispondenze-Termine|C],Corrispondenze):-
    write(Termine),nl,
    stampaTermini(C,Corrispondenze).
stampaTermini(L,_):-
    nl,
    stampa(L,_).

