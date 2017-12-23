% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N57
%OK
%

%DB dato
ang(alfa,[10,23,18]).
ang(beta,[22,0,38]).
ang(gamma,[12,28,30]).
ang(delta,[21,30,28]).
ang(epsilon,[21,59,58]).


%Sottrazione � cosi fomata
%
%
%      10� 20' 30'' -
%      9�  10' 40''
%
%sottrazione( Numero1 ,
%              Numero2 ,
%              Differenza tra i due numeri ,
%              l'ELEMENTO PRIMA ha chiesto una decina?
%              1: si
%              0: no ,
%              Ho bisogno di una decina?
%              1: si
%              0: no
%            )
%
sottrazione(X,Y,Diff,0,0):-
    X > Y,
    Diff is X-Y.
sottrazione(X,Y,Diff,0,1):-
    X < Y,
    Diff is (60+X)-Y.
sottrazione(X,Y,Diff,1,0):-
    X1 is X-1,
    X1 > Y,
    Diff is X1-Y.
sottrazione(X,Y,Diff,1,1):-
    X1 is X-1,
    X1 < Y,
    Diff is (60+X)-Y.
sottrazione(X,Y,0,1,0):-
    X1 is X-1,
    X1 = Y.
sottrazione(X,X,0,0,0).



minima(CA):-
    %prendo tutti i fatti del DB e creo una lista con essi
    findall(Angolo-Misura , ang(Angolo,Misura) , ListaDB),
    %Dopo di che calcolo tutte le differenze fra gli angoli e le inserisco in una lista
    %Nota: Ho bisogno di coda in modo tale da non ripetere piu di una volta delle differenze gi� fatte.
    %       ex:  alfa-beta � la stessa di beta-alfa (dato che consideriamo il valore assoluto), per cui non ha senso ripeterla
    findall(Diff  , (
                      member(X,ListaDB),
                      coda(X,ListaDB,Coda),
                      scorri(X,Coda,Diff)
                    ),
          ListaDifferenze),
    %Siccome ListaDifferenze � una lista di liste, la appiattisco
    appiattita(ListaDifferenze,L),
    %Ordino la lista appiattita in modo tale da avere al primo elemento la differenza piu piccola tra tutte
    sort(L,[CA|_]).

appiattita(L,LAppiattita):-
    findall( Elemento, (
                          member(Lista,L),
                          member(Elemento,Lista)
                        ),
             LAppiattita).

coda(X,[X|Coda],Coda):-!.
coda(X,[_|C],Coda):-
    coda(X,C,Coda),
    !.

scorri(_,[],[]).
scorri(Angolo1-Misura1,[Angolo2-Misura2|C],[Diff-Angolo1/Angolo2|U]):-
    differenza(Misura1,Misura2,Diff),
    scorri(Angolo1-Misura1,C,U),
    !.

scorri(Angolo1-Misura1,[_|C],Diff):-
    scorri(Angolo1-Misura1,C,Diff),
    !.

differenza([Gradi1,Primi1,Secondi1],[Gradi2,Primi2,Secondi2],[Diff3,Diff2,Diff1]):-
    Gradi1 > Gradi2, %sottraggo sempre il numero piu grande dal piu piccolo
    %DA NOTARE IL FATTO CHE
    % Riporto viene passato di volta in volta

    %0: � il primo elemento a cui viene fatta la sottrazione per cui non c � un elemento prima che avrebbe potuto chiedere una decina    %Riporto1 : indica se questa differenza(Diff1) ha necessitato di chiedere una decina
    sottrazione(Secondi1,Secondi2,Diff1,0,Riporto1),

    %Riporto1: mi oermette di capire se la Diff1 ha necessitato di una decina
    %Riporto2 : indica se questa differenza (Diff2) ha necessitato di chiedere una decina
    sottrazione(Primi1,Primi2,Diff2,Riporto1,Riporto2),
    sottrazione(Gradi1,Gradi2,Diff3,Riporto2,_).

differenza([Gradi1,Primi1,Secondi1],[Gradi2,Primi2,Secondi2],[Diff3,Diff2,Diff1]):-
    Gradi2 > Gradi1, %sottraggo sempre il numero piu grande dal piu piccolo

    %DA NOTARE IL FATTO CHE
    % Riporto viene passato di volta in volta

    %0: � il primo elemento a cui viene fatta la sottrazione per cui non c � un elemento prima che avrebbe potuto chiedere una decina    %Riporto1 : indica se questa differenza(Diff1) ha necessitato di chiedere una decina
    sottrazione(Secondi2,Secondi1,Diff1,0,Riporto1),

    %Riporto1: mi oermette di capire se la Diff1 ha necessitato di una decina
    %Riporto2 : indica se questa differenza (Diff2) ha necessitato di chiedere una decina
    sottrazione(Primi2,Primi1,Diff2,Riporto1,Riporto2),
    sottrazione(Gradi2,Gradi1,Diff3,Riporto2,_).




