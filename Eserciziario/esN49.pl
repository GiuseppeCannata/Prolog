% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%Es N49
%
%



run(N,X):-
    ottieniPari([]),
    ottieniDispari([]),
    findall(Numero,( p(N1) , \+ N1 = 0, d(N2) , p(N3) , d(N4) , creaNum([],Numero), Numero > N),X).


%permette di inserire numeri pari
ottieniPari(Inseriti):-
    write('Inserire numero pari: '),
    read(Num),nl,
    insPari(Inseriti,Num).

insPari(_,basta).

insPari(Inseriti,Num):-
    member(Num,Inseriti),
    write('Gia inserito'),
    ottieniPari(Inseriti).

insPari(Inseriti,Num):-
    D is Num mod 2,
    D = 0,
    asserta( p(Num) ),
    ottieniPari([Num|Inseriti]).

insPari(Inseriti,_):-
    write('Hai inserito un dispari '),nl,
    ottieniPari(Inseriti).


%permette di inserire numeri dispari
ottieniDispari(Inseriti):-
    write('Inserire numero dispari: '),
    read(Num),nl,
    insDisp(Inseriti,Num).

insDisp(_,basta).

insDisp(Inseriti,Num):-
    member(Num,Inseriti),
    write('Gia inserito'),
    ottieniDispari([Num|Inseriti]).

insDisp(Inseriti,Num):-
    D is Num mod 2,
    \+ D = 0,
    asserta( d(Num) ),
    ottieniDispari(Inseriti).

insDisp(Inseriti,_):-
    write('Hai inserito un pari '),nl,
    ottieniDispari(Inseriti).

creaNum(Lista,Numero):-
    member(X,Lista),













