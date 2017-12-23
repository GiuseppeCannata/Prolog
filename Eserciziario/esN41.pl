% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.



%es N41
%ok,ma non mi piace
%

somma(L1,S):-
    predicato(L1,[],S).

predicato([],App,S):-
    reverse(App,S).
% predicato: scorre la lista di liste prendendone una per volta, e
%             e sommandole tra loro
% [T|C] : è una lista di liste, indi per cui T sarà una lista.
% App   : è la lista appoggio dove di volta in volta andrò a mettere la
%         delle varie liste
% S     : lista in cui ,alla fine, avro la somma finale
predicato([T|C],App,S):-
    reverse(T,T1), %faccio il reverse perchè mi è piu semplice la gestione
    predicato1(T1,App,[],0,Somma1),
    predicato(C,Somma1,S).

%primo avvio
predicato1(Somma,[],[],0,Somma).

%parita delle liste in lunghezza:
%si hanno 2 casi:
%1) il caso in cui la decina è zero --> faccio solo il reverse
%2) caso in cui la decina non è zero --> devo eseguire la somma della
%                                        decina, e poi il reverse
%
predicato1([],[],ListaSommaNonRe,0,ListaSomma):-
    reverse(ListaSommaNonRe,ListaSomma).
predicato1([T|[]],[T1|[]],ListaSommaNonRe,1,ListaSomma):-
    T3 is T+T1+1,
    reverse([T3|ListaSommaNonRe],ListaSomma).


%la prima lista era la piu lunga
predicato1([T|C],[],Par,DEC,ListaSomma):-
    DEC = 0,
    reverse(Par,ListaSommaPar),
    append(ListaSommaPar,[T|C],ListaSomma).
predicato1([T|C],[],Par,DEC,ListaSomma):-
    DEC = 1,
    scorri([T|C],DEC,Lista),
    reverse(Par,ListaSommaPar),
    append(ListaSommaPar,Lista,ListaSomma).


%la seconda lista era la piu lunga
predicato1([],[T|C],Par,DEC,ListaSomma):-
    DEC = 1,
    scorri([T|C],DEC,Lista),
    reverse(Par,ListaSommaPar),
    append(ListaSommaPar,Lista,ListaSomma).
predicato1([],[T|C],Par,DEC,ListaSomma):-
    DEC = 0,
    reverse(Par,ListaSommaPar),
    append(ListaSommaPar,[T|C],ListaSomma).


predicato1([T|C],[T1|C1],App,DEC,S):-
    SommaApp is T+T1+DEC,
    decina(SommaApp,DEC1,Somma),
    predicato1(C,C1,[Somma|App],DEC1,S).


decina(SommaApp,1,Somma):-
    SommaApp >= 10,
    Somma is SommaApp-10.
decina(Somma,0,Somma):-
    Somma < 10.

% scorri permette di sommare eventuali decine nel caso in cui le due
% liste non siano di lunghezza uguale
scorri([],0,_).
scorri([T|[]],1,[Somma|_]):-
    Somma is  T+1.
scorri([T|C],DEC,[Somma|C2]):-
    T2 is T+DEC,
    decina(T2,DEC1,Somma),
    scorri(C,DEC1,C2).
