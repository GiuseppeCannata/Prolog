
cercaPercorso(Nodo,Percorso,_) :-
%	retractall(o(_,_)),
%	dfs(Nodo,Percorso).                   %DFS senza controllo cicli
%	depthfirst([],Nodo,P),inv(P,Percorso).                      %DFS
%	depthlimited(Nodo,Percorso,MaxDepth).                       %DLS
%	dfslimited([],Nodo,P,MaxDepth),inv(P,Percorso).             %DLS
%	ids(Nodo,P,1),inv(P,Percorso).                              %IDS
%	solve(Nodo,P),inv(P,Percorso).                             %IDS2
%	bfs([[Nodo]],Percorso).			                    %BFS
%	breadthfirst([[Nodo]|Z]-Z,Percorso),       %BFS difference lists
%	destinazione(D),biddfs2([Nodo,D],Nodo-D,Percorso).%Bidirezionale
        ucs([0-[Nodo]],C-P),inv(P,PInv),Percorso=C-PInv.	   % UCS
%	gs([9999+0-[Nodo]],_+C-P),inv(P,PInv),Percorso=C-PInv.	   % GS
%	a([9999+0-[Nodo]],_+C-P),inv(P,PInv),Percorso=C-PInv.	   % A

dfs(N,[N]) :-
	destinazione(N).
dfs(N,[N|C]) :-
	s(N,N1),
	dfs(N1,C).

% depthfirst([],+Partenza,-Percorso)
% con accumulatore per evitare cicli

depthfirst(Perc,Nodo,[Nodo|Perc]) :-
	destinazione(Nodo).

depthfirst(Perc,Nodo,Percorso) :-
	s(Nodo,Nodo1),
	\+  member(Nodo1,Perc),         % previene i cicli
	depthfirst([Nodo|Perc],Nodo1,Percorso).

% depthlimited(+Partenza,-Percorso,+MassimaProfondita)
% Percorso non è più lungo di MassimaProfondita da Partenza alla
% destinazione

depthlimited(Nodo,[Nodo],_)  :-
   destinazione(Nodo).

depthlimited(Nodo,[Nodo|Perc],Maxdepth)  :-
   Maxdepth > 0,
   s(Nodo,Nodo1),
   Max1 is Maxdepth - 1,
   depthlimited(Nodo1,Perc,Max1).

dfslimited(Perc,Nodo,[Nodo|Perc],_) :-
	destinazione(Nodo).

dfslimited(Perc,Nodo,Percorso,Maxdepth) :-
	Maxdepth > 0,
	s(Nodo,Nodo1),
	\+  member(Nodo1,Perc),         % previene i cicli
	Max is Maxdepth - 1,
	dfslimited([Nodo|Perc],Nodo1,Percorso,Max).

ids(Nodo,Percorso,Depth) :-
	dfslimited([],Nodo,Percorso,Depth).
ids(Nodo,Percorso,Depth) :-
	Depth1 is Depth + 1,
	ids(Nodo,Percorso,Depth1).

solve(Inizio,Soluzione) :-
	ids2(Inizio,Goal,Soluzione),
	destinazione(Goal).

% ids2(N1,N2,Percorso): genera percorsi da N1 a N2 di
% lunghezza crescente restituiti in ordine inverso
ids2(N,N,[N]).
ids2(Primo,Ultimo,[Ultimo|P]) :-
	ids2(Primo,Penultimo,P),
	s(Penultimo,Ultimo),
	\+ member(Ultimo,P).

% bfs([[Partenza]],Percorso):
% ricerca in ampiezza

bfs([[Nodo|Perc]|_],[Nodo|Perc]) :-
	destinazione(Nodo).

bfs([Percorso|Percorsi],Soluzione):-
  espansione(Percorso,PercorsiEstesi),
  append(Percorsi,PercorsiEstesi,NuoviPercorsi),
  bfs(NuoviPercorsi,Soluzione).

espansione([N|Perc],Percorsi):-
  findall([NN,N|Perc],(s(N,NN),\+ member(NN,[N|Perc])),Percorsi).

% breadthfirst(([[Partenza]|Z]-Z,Percorso)
% ricerca in ampiezza con lista differenze

breadthfirst([[Nodo|Perc]|_]-_,[Nodo|Perc]) :-
	destinazione(Nodo).
breadthfirst([Percorso|Percorsi]-Z,Soluzione) :-
	espansione(Percorso,PercorsiEstesi),
	append(PercorsiEstesi,Z1,Z),
	Percorsi \== Z1,
	breadthfirst(Percorsi-Z1,Soluzione).

/*
% dfs_da_bfs([[Partenza]],Percorso)
% ricerca in profondità derivata da quella in ampiezza
% inserendo i nuovi percorsi frontiera in testa invece che in coda

dfs_da_bfs([[Nodo|Perc]|_],[Nodo|Perc]) :-
	destinazione(Nodo).

dfs_da_bfs([Percorso|Percorsi],Soluzione):-
  espansione(Percorso,PercorsiEstesi),
  append(PercorsiEstesi,Percorsi,NuoviPercorsi),
  dfs_da_bfs(NuoviPercorsi,Soluzione).
*/

/* questa implementazione della ricerca bidirezionale in profondità
 * non controlla i cicli
 *
biddfs(N,[N]) :-
	nuova_destinazione(N).
biddfs(N,[N|C]) :-
	nuovo_successore(N,N1),
	biddfs(N1,C).
*/

biddfs2(_,S-E,[S-E]) :-
	nuova_destinazione(S-E),
	!.
biddfs2(Visitati,S-E,[S-E|C]) :-
	nuovo_successore(S-E,S1-E1),
	\+ member(S1,Visitati),
	\+ member(E1,Visitati),
	biddfs2([S1,E1|Visitati],S1-E1,C).

nuovo_successore(S-E,S1-E1):-
   s(S,S1),      % un passo in avanti
   s(E1,E).      % un passo indietro
nuova_destinazione(S-S).   % i due goals coincidono
nuova_destinazione(S-E) :- % i due goals sono adiacenti
   s(S,E).

/* anche questa implementazione della ricerca bidirezionale
 * in profondità evita i cicli
 * bid_depthfirst([],arad-bucharest,Soluzione)
 */
bid_depthfirst(Perc,Nodo,[Nodo|Perc]) :-
	nuova_destinazione(Nodo),
	!.

bid_depthfirst(Perc,Nodo,Percorso) :-
	nuovo_successore(Nodo,S1-E1),
	\+  member(S1-_,[Nodo|Perc]),         % previene cicli
	\+  member(_-S1,[Nodo|Perc]),         % previene cicli
	\+  member(E1-_,[Nodo|Perc]),         % previene cicli
	\+  member(_-E1,[Nodo|Perc]),         % previene cicli
	bid_depthfirst([Nodo|Perc],S1-E1,Percorso).
/*

% ucs([0-[Partenza]],C-Percorso)
% ricerca a costo uniforme derivata da quella in ampiezza
% restituisce solo le prime due migliori soluzioni ma tiene meno
% percorsi in memoria perché elimina quelli che riespandono un nodo già
% espanso

ucs([C-[Nodo|Perc]|_],C-[Nodo|Perc]) :-
	destinazione(Nodo).

ucs([C-[N|P]|Percorsi],Soluzione):-
	ottimo(N,C),
	espansione3(C-[N|P],PercorsiEstesi),
	write(C), write(' '), inv([N|P],Percorso), scrivi(Percorso), nl,
	fusioneOrdinata(PercorsiEstesi,Percorsi,NuoviPercorsi),
	ucs(NuoviPercorsi,Soluzione).

espansione3(C-[N|P],Percorsi):-
	setof(CC-[NN,N|P],C1^(s(N,NN,C1),\+ o(NN,_),CC is C+C1),Percorsi),
	!.
espansione3(_-_,[]). % non fa fallire espansione2

% restituisce il costo ottimo se il nodo è stato già espanso
% altrimenti lo asserisce
ottimo(N,C) :-
	o(N,C),
	!.
ottimo(N,C) :-
	assertz(o(N,C)).

*/

% ucs([0-[Partenza]],C-Percorso)
% ricerca a costo uniforme derivata da quella in ampiezza
% il C-[Percorso] ha un costo C dato dalla somma dei costi degli archi

ucs([C-[Nodo|Perc]|_],C-[Nodo|Perc]) :-
	destinazione(Nodo).

ucs([C-Percorso|Percorsi],Soluzione):-
  espansione2(C-Percorso,PercorsiEstesi),
  fusioneOrdinata(PercorsiEstesi,Percorsi,NuoviPercorsi),
  ucs(NuoviPercorsi,Soluzione).


espansione2(C-[N|P],Percorsi):-
  setof(CC-[NN,N|P],C1^(s(N,NN,C1),\+ member(NN,[N|P]),CC is C+C1),Percorsi),
  write(Percorsi), nl,
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

scrivi([]).
scrivi([T|C]) :-
	write(T), write(' '),
	scrivi(C).


/*

% gs([0-[Partenza]],C-Percorso)
% ricerca greedy derivata da quella in ampiezza
% il H+C-[Percorso] ha un costo C dato dalla somma dei costi degli archi
% e l'euristica del nodo frontiera è H

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
*/

% a([0-[Partenza]],C-Percorso)
% ricerca greedy derivata da quella in ampiezza
% il H+C-[Percorso] ha un costo C dato dalla somma dei costi degli archi
% e l'euristica del nodo frontiera è H

a([C+C-[Nodo|Perc]|_],C+C-[Nodo|Perc]).

a([F+C-Percorso|Percorsi],Soluzione):-
  espansione_a(F+C-Percorso,PercorsiEstesi),
  write(C), write(' '), inv(Percorso,P), scrivi(P), nl,
  fusioneOrdinata_a(PercorsiEstesi,Percorsi,NuoviPercorsi),
  a(NuoviPercorsi,Soluzione).

espansione_a(_+C-[N|P],Percorsi):-
  setof(FF+CC-[NN,N|P],C1^H^(s(N,NN,C1),\+ member(NN,[N|P]),h(NN,H),CC is C+C1,FF is CC+ H),Percorsi),
  !.
espansione_a(_+_-_,[]). % non fa fallire espansione2

fusioneOrdinata_a([],L,L).
fusioneOrdinata_a(L,[],L).
fusioneOrdinata_a([F1+C1-P1|CP1],[F2+C2-P2|CP2],[F1+C1-P1|Coda]) :-
	F1 =< F2,
	fusioneOrdinata_a(CP1,[F2+C2-P2|CP2],Coda).
fusioneOrdinata_a([F1+C1-P1|CP1],[F2+C2-P2|CP2],[F2+C2-P2|Coda]) :-
	F1 > F2,
	fusioneOrdinata_a([F1+C1-P1|CP1],CP2,Coda).
