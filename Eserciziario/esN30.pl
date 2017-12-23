% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N30
%Non funziona bene
%
%DB
da_a(ancona,roma,[ora(8:10,9:30,[lun,mar,sab]),ora(9:30,10:40,giorno),ora(19:30,20:45,[mer,ven,dom])]).
da_a(roma,milano,[ora(9:30,10:40,giorno),ora(9:10,14:30,[lun,mar,sab]),
ora(18:30,20:45,[mer,ven,dom])]).
da_a(milano,parigi,[ora(9:30,10:40,giorno),ora(15:10,16:30,[lun,mar,sab]),
ora(20:15,22:10,[mer,ven,dom])]).


/*
viaggio(Partenza,Arrivo,Giorno,Iter):-
    depthfirst([],Partenza,Giorno,Arrivo,P),
    inv(P,Iter).
depthfirst(Perc,Arrivo,_,Arrivo,Perc).
depthfirst(Perc,Nodo,Giorno,Arrivo,P) :-
	da_a(Nodo,Nodo1,Orari),
        controllora(Perc,Orari,DBpartenza,DBarrivo,Giorno,Giorni),
        (   var(Giorni);
            Giorni =[G1|GRestanti]
        ),
        controllagiorno(G1,GRestanti,Giorno),
        \+  member(Nodo1,Perc),         % previene i cicli
	depthfirst([perc(Nodo,DBpartenza,Nodo1,DBarrivo)|Perc],Nodo1,Giorno,Arrivo,P).

controllora([], [ora(DBpartenza,DBarrivo,[G1|_])|_] ,DBpartenza,DBarrivo,G1,Giorni). %inizio

controllora([perc(_,_,_,H:M)|_], [ora(H1:M1,_,Giorni)|Restanti],_,_,Giorno,Giorni):-
   \+ H =< H1,
   \+ M =< M1,
   controllora([perc(_,_,_,H:M)|_],Restanti,_,_,Giorno,Giorni).
controllora([perc(_,_,_,H:M)|_], [ora(H1:M1,DBarrivo,Giorni)|_],H1:M1,DBarrivo,Giorno,Giorni).
controllora([perc(_,_,_,H:M)|_], [ora(H1:M1,DBarrivo,'giorno')|_],H1:M1,DBarrivo,Giorno,Giorni).


controllagiorno(Giorno,_,Giorno).
controllagiorno(_,_,'giorno').
controllagiorno(G,[_|C],Giorno):-
    controllagiorno(G,C,Giorno).


*/

/*
viaggio(Partenza,Arrivo,Giorno,Iter):-
    depthfirst([],Partenza,Giorno,Arrivo,P),
    inv(P,Iter).
depthfirst(Perc,Arrivo,_,Arrivo,Perc).
depthfirst(Perc,Nodo,Giorno,Arrivo,P) :-
	da_a(Nodo,Nodo1,Orari),
        controllora(Perc,Orari,DBpartenza,DBarrivo,Giorno),
        \+  member(Nodo1,Perc),         % previene i cicli
	depthfirst([perc(Nodo,DBpartenza,Nodo1,DBarrivo)|Perc],Nodo1,Giorno,Arrivo,P).

controllora([], [ora(DBpartenza,DBarrivo,[G1|_])|_] ,DBpartenza,DBarrivo,G1). %inizio

controllora([perc(_,_,_,H:M)|_], [ora(H1:M1,_,Giorni)|Restanti],_,_,Giorno):-
   \+ H =< H1,
   \+ M =< M1,
   controllora([perc(_,_,_,H:M)|_],Restanti,_,_,Giorno).
controllora([perc(_,_,_,H:M)|_], [ora(H1:M1,DBarrivo,[G1|GRestanti])|_],H1:M1,DBarrivo,Giorno):-
    member(Giorno,[G1|GRestanti]),
    controllagiorno(G1,GRestanti,Giorno).
controllora([perc(_,_,_,H:M)|_], [ora(H1:M1,DBarrivo,'giorno')|_],H1:M1,DBarrivo,Giorno).


controllagiorno(Giorno,_,Giorno).
controllagiorno(_,_,'giorno').
controllagiorno(G,[_|C],Giorno):-
    controllagiorno(G,C,Giorno).


*/

inv(Lista,Invertita) :-
	inverti(Lista,[],Invertita).
inverti([],Invertita,Invertita).
inverti([T|C],Parziale,Invertita) :-
	inverti(C,[T|Parziale],Invertita).

