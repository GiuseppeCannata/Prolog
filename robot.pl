/*un robot si muove sul piano x,y fra ostacoli rettangolari allineati con gli assi cartesiani
Il robot si puo assimilare ad un punto e si puo muovere solo orizzontalmente o verticalmente
Supponiamo che il costo di cambiare direzione sia pari a quello di avanzare di una mattonella.
Definire i predicati:
s(Stato,NuovoStato,Costo),
e
H(Stato,H) da utilizzare con l algoritmo A*
gli ostacoli sono rappresentati da
ostacolo(*/


destinazione(4/4).

ostacolo(2/2,3/3).
ostacolo(5/5,5/9).

%euristica calcolata a run time punto per punto
%L eruistica è zero nel punto di destrinazione
h(X/Y,H):-
    destinazione(Xd/Yd),
    C1 is abs(Yd-Y),
    C2 is abs(Xd-X),
    H is sqrt((C1*C1)+(C2*C2)).



%definisco i confini del mio spazio di stati
luogo(X/Y):-
    between(0,10,X),
    between(0,10,Y).

%Avanti
% Posso andare avanti solo nel caso in cui non collido altrimenti provo
% altre strade
s(X/Y,X/Y1):-
    Y1 is Y+1,
    luogo(X/Y1),
   \+ collisione(X/Y1).


%indietro
s(X/Y,X/Y1):-
    Y1 is Y-1,
    luogo(X/Y1),
   \+ collisione(X/Y1).

%destra
s(X/Y,X1/Y):-
    X1 is X+1,
    luogo(X/Y1),
   \+ collisione(X1/Y1).

%sinistra
s(X/Y,X1/Y1):-
    X1 is X-1,
    luogo(X/Y1),
   \+ collisione(X1/Y1).


%Verifica se c è collisione con l ostacolo
collisione(X/Y):-
    ostacolo(X1/Y1,X2/Y2),
    between(X1,X2,X),
    between(Y1,Y2,Y).


/*La dfs non va bene poichè va in profondita ed esplora troppi nodi andando in out of stack.
 * Inoltre la dfs non è ottima ne completa

dfs(X/Y,[X/Y]) :-
	destinazione(X/Y).
dfs(X/Y,[X/Y|C]) :-
	s(X/Y,X1/Y1),
	dfs(X1/Y1,C).*/

gs([0+C-[Nodo|Perc]|_],0+C-[Nodo|Perc]).

gs([H+C-Percorso|Percorsi],Soluzione):-
  espansione_gs(H+C-Percorso,PercorsiEstesi),
  fusioneOrdinata_gs(PercorsiEstesi,Percorsi,NuoviPercorsi),
  gs(NuoviPercorsi,Soluzione).

espansione_gs(_+C-[N|P],Percorsi):-
  setof(HH+CC-[NN,N|P],C1^(s(N,NN,C1),\+ member(NN,[N|P]),h(NN,HH),CC is C+C1),Percorsi),
  !.
espansione_gs(_+_-_,[]). % non fa fallire espansione2

fusioneOrdinata_gs([],L,L).
fusioneOrdinata_gs(L,[],L).
fusioneOrdinata_gs([H1+C1-P1|CP1],[H2+C2-P2|CP2],[H1+C1-P1|Coda]) :-
	H1 =< H2,
	fusioneOrdinata_gs(CP1,[H2+C2-P2|CP2],Coda).
fusioneOrdinata_gs([H1+C1-P1|CP1],[H2+C2-P2|CP2],[H2+C2-P2|Coda]) :-
	H1 > H2,
	fusioneOrdinata_gs([H1+C1-P1|CP1],CP2,Coda).

















