
%Es N50
%
%modifiche fatte al db
%

% studiando il Db mi sono accorto che c è una ricerca in profondità.
% Questo accade fino a Piazza Cavour dove posso prendere due strade:
% galleria o corso garibaldi.
%
% L idea è questa:
% 1) mi porto dietro di volta in volta i vari posti esplorati, in modo
%    tale da non ripassare per lo stesso posto
% 2) in base ai posti esplorati considero la via percorsa
%
connesso(passetto,dorico,viale_della_vittoria,3).
connesso(dorico,passetto,viale_della_vittoria,3).

connesso(piazza_diaz,piazza_cavour,viale_della_vittoria,7).
connesso(piazza_cavour,piazza_repubblica,corso_garibaldi,5).
connesso(piazza_repubblica,s2,via_29_settembre,7).
connesso(s2,piazza_italia,viale_marconi,8).
connesso(piazza_italia,piazza_ugo_bassi,corso_carlo_alberto,7).
connesso(piazza_liberta,piazza_europa,via_martiri_resistenza,6).
connesso(piazza_cavour,piazza_liberta,galleria,9).
connesso(piazza_liberta,piazza_europa,via_martiri_resistenza,6).
connesso(piazza_europa,piazza_ugo_bassi,via_ricostruzione,4).
connesso(piazza_ugo_bassi,pinocchio,via_maggini,14).

%modifica fatta al db
connesso(dorico,piazza_diaz,viale_della_vittoria,3).



vai(Partenza,Arrivo,Percorso,Distanza):-
     ucs([0-[Partenza]],Arrivo,[],C-P),
     reverse(P,PInv),
     Percorso=PInv,
     Distanza=C.

%tappo
ucs([C-[Arrivo|_]|_],Arrivo,Vie,C-Vie).

ucs([C-Percorso|Percorsi],Arrivo,Vie,Soluzione):-
  espansione(C-Percorso,PercorsiEstesi,VieEstese),
  fusioneOrdinata(PercorsiEstesi,Percorsi,NuoviPercorsi),
  NuoviPercorsi = [Costo-_|_],  %Nuovi percorsi avrà alla testa sempre il percorso più breve, Siccome io devo selezionare la via associata ne considero il costo
  prendiVia(Costo,VieEstese,NuovaVia),
  controllo(NuovaVia,Vie,VieConAggiunta),
  ucs(NuoviPercorsi,Arrivo,VieConAggiunta,Soluzione).

%In base al costo considero la via
prendiVia(Costo,[Costo-T|_],T).
prendiVia(Costo,[_|U],Nuovo):-
     prendiVia(Costo,U,Nuovo).

% se la via non è presete basta che la inserisco
controllo([p(Via-Distanza)],Vie,[p(Via-Distanza)|Vie]):-
     \+ member(p(Via-_),Vie).
% Nel caso in cui la NuovaVia sia già inserita devo aggiungere solo i Km
% in piu
controllo([p(Via-Distanza)],Vie,USCITA):-
     member(p(Via-X),Vie),
     NuovaDistanza is X+Distanza,
     scorri(Via-NuovaDistanza,Vie,USCITA).

scorri(Via-NuovaDistanza,[p(Via-_)|C],[p(Via-NuovaDistanza)|C]).
scorri(Via-NuovaDistanza,[T|C],[T|U]):-
      scorri(Via-NuovaDistanza,C,U).



espansione(C-[N|P],Percorsi,Vie):-
 % mi crea la lista circa i posti visitati
 setof(CC-[NN,N|P] , Distanza^( connesso(N,NN,_,Distanza), \+ member(NN,[N|P]), CC is C+Distanza ),Percorsi),
 % mi prende le vie in base ai posti esplorati
 %Cosa importante, le vie portano dietro il costo, questo mi permetterà, in caso abbia più scelte,di associare l esporazione dei posti alle giuste vie percorse
 setof(CC-[p(Via-Distanza)] ,( connesso(N,NN,Via,Distanza), \+ member(NN,[N|P]), CC is C+Distanza ),Vie).

espansione(_-_,[]). % non fa fallire espansione

fusioneOrdinata([],L,L).
fusioneOrdinata(L,[],L).
fusioneOrdinata([C1-P1|CP1],[C2-P2|CP2],[C1-P1|Coda]) :-
	C1 =< C2,
	 fusioneOrdinata(CP1,[C2-P2|CP2],Coda).
fusioneOrdinata([C1-P1|CP1],[C2-P2|CP2],[C2-P2|Coda]) :-
	C1 > C2,
	fusioneOrdinata([C1-P1|CP1],CP2,Coda).

