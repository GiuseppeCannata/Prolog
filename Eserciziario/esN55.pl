% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.


diz(bqlla,beautiful).
diz(bqffa,derision).
diz(bolla,bubble).
diz(pianta,tree).
diz(fianco,side).
diz(una,a).

traduci:-
    write('Dai una frase'),nl,
    read(LIns),
    \+ LIns = [],
    findall( Traduzione ,( member(Parola,LIns), controllo(Parola,Traduzione) ), Lista),
    write(Lista),
    traduci.

traduci.


controllo(Italiano,Traduzione):-
    diz(Italiano,Traduzione),
    !.%metto il cut per evitare il risoddisfacimento dovuto al CUT

% qualora esistano parole italiane della stessa lunghezza che
% differiscono per una sola lettera, si scelga come parola inglese
% quella corrispondente alla parola italiana avente la lettera diversa
% più vicina (secondo il codice ASCII);
controllo(Italiano,Traduzione):-      %scindo la parola inserita in lista di caratteri
    atom_chars(Italiano,ListaIns),
    %ne calcolo la lunghezza
    length(ListaIns,LungIns),
    %IL SETOF FALLISCE NEL CASO IN CUI LungDB = LungIns FALLISCE
    setof(ItDBLista-Traduzione ,( %prendo la parola del dizionario e vedo se ha:
                                  %         1) la stessa lunghezza della parola inserita
                                  %         2) se solo una lettera è diversa rispetto la parola inserita
                                  diz(X,Traduzione),
                                  atom_chars(X,ItDBLista),
                                  length(ItDBLista,LungDB),
                                  LungDB = LungIns,
                                  diversita1(ItDBLista,ListaIns,0,Div),
                                  Div = 1
                                ),
          ListaUno),
    sceltaparola(ListaUno,ListaIns,Traduzione),
    !. %metto il cut per evitare il risoddisfacimento dovuto al CUT

% qualora non sia verificato il punto precedente, se esistono parole
% italiane della stessa lunghezza che differiscono per solo due lettere
% contigue, si scelga come parola inglese quella corrispondente
% alla parola italiana avente la minima distanza totale dalle lettera
% diverse (secondo il codice ASCII);
%
% La clausola è implementata allo stesso modo di cui sopra, con l unica
% differenza che in questo caso si considerano div=2
controllo(Italiano,Traduzione):-
    atom_chars(Italiano,ListaIns),
    length(ListaIns,LungIns),
    findall(ItDBLista-Traduzione ,( diz(X,Traduzione),
                                  atom_chars(X,ItDBLista),
                                  length(ItDBLista,LungDB),
                                  LungDB = LungIns,
                                  diversita2(ItDBLista,ListaIns,0,Div),
                                  Div = 2
                                ),
          ListaDue),
    sceltaparola(ListaDue,ListaIns,Traduzione),
    !. %metto il cut per evitare il risoddisfacimento dovuto al CUT

% qualora non siano verificati nessuno dei punti precedenti venga
% tradotta con una parola della stessa lunghezza e composta da tutte
% lettere uguali a quella iniziale.
controllo(Italiano,Traduzione):-
    atom_chars(Italiano,[T|C]),
    length([T|C],LungIns),
    genera(T,LungIns,[],Traduzione),
    !.



genera(_,0,App,Traduzione):-
    atom_chars(Traduzione,App).
genera(Lettera,Cont,App,Traduzione):-
    Cont1 is Cont-1,
    genera(Lettera,Cont1,[Lettera|App],Traduzione).




%abbiamo trovato nel DB una sola lettera
sceltaparola([_-Traduzione|[]],_,Traduzione).
sceltaparola(ListaUno,ListaIns,Traduzione):-
    %calcoliamo la distanza delle parole trovate per prendere quella piu breve
    %setof ordina in maniera crescente rispetto Distanza
    findall( Distanza-Tra,( member(Parola-Tra,ListaUno), distanza(Parola,ListaIns,_,Distanza) ), Lista ),
    sort(Lista,ListaOrd), %ordino per avere come primo elemento in ListaOrd la Traduzione con la distanza piu breve
    ListaOrd = [_-Traduzione|_].

distanza([],[],Distanza,Distanza):-
    !.
distanza([X|C],[X|C1],App,Distanza):-
    distanza(C,C1,App,Distanza),
    !.
distanza([X|C],[Y|C1],_,Distanza):-
    name(X,[ASCIIX]),
    name(Y,[ASCIIY]),
    Distanza1 is abs(ASCIIX-ASCIIY),
    distanza(C,C1,Distanza1,Distanza),
    !.


diversita1([],[],Div,Div):-
    !.
diversita1([X|C],[X|C1],Cont,Div):-
    diversita1(C,C1,Cont,Div),
    !.
diversita1([_|C],[_|C1],Cont,Div):-
    Cont1 is Cont+1,
    diversita1(C,C1,Cont1,Div),
    !.

diversita2([],[],Div,Div):-
    !.
diversita2([X|C],[X1|C1],Cont,Div):-
      \+ X = X1,
      C = [Y|_],
      C1 = [Y1|_],
      \+ Y = Y1,
      Cont1 is Cont+2,
      diversita2(C,C1,Cont1,Div).
diversita2([_|C],[_|C1],Cont,Div):-
    diversita2(C,C1,Cont,Div),
    !.

