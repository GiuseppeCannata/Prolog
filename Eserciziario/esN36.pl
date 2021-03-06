% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N36
%
%

password('amico').

start:-
    write('Password ?'),nl,
    read(Password),
    \+ password(Password),
    password(X),
    atom_chars(Password, ListI), %I sta ad indicare la pass inserita dall utente
    atom_chars(X, ListX), %X sta ad indicara la pass presente ne DB
    controlManager(ListI,ListX).
start.

controlManager(ListI,ListX):-
      controllo(ListI,ListX,0,_),
      adiacenza(ListI,ListX).

controllo([_],[],_,_):-
    write('Un solo elemento in piu'),
    start.
controllo([],[_],_,_):-
    write('Una lettera in meno'),
    start.
controllo([],[],Errori,Errori):-
    Errori = 1,
    write('Diversa una lettera'),nl,
    start.
controllo([T|C],[T1|C1],Cont,Errori):-
    T = T1,
    controllo(C,C1,Cont,Errori).
controllo([_|C],[_|C1],Cont,Errori):-
    Cont1 is Cont+1,
    controllo(C,C1,Cont1,Errori).
controllo([],[],_,_).  %nel caso in cui tutte fallissero

% adicenza da solo funziona ma da problemi se eseguo amicii, e poi
% amico, vedi guitracer
adiacenza([],[]).
adiacenza([T|C],[X|U]):-
    verifica(C,T,U,X).
adiacenza([_|C],[_|U]):-
    adiacenza(C,U).
verifica([T1|_],T,[X1|_],X):-
    T1 = X,
    X1 = T,
    write('adicenza'),nl,
    start.
verifica([_|C1],_,[_|U1],_):-
    adiacenza(C1,U1).




