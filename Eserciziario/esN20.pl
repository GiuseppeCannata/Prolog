% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N20
%manca da ordinare per frequanza decrescente
%
%

%L = ['atom','ciao','atom','ciao','no']
%L1 = [atom-2, ciao-2, no-1]
parole(L,L1):-
    main(L,L1,[]),
    !.

% main--> ad ogni iter considera una parola e scansiona la lista per
% contare le occorrenze. Questo accade solo se la parola considerata in
% questa iter non l ho gia scansionata prima
main([],[],_).
main([Parola|C],L,Visitati):-
    \+ member(Parola,Visitati), %verifico che la parola che considero non l ho gia considerata prima
    scansiona(Parola,C,1,Elemento),
    crealista(C,Elemento,L,Visitati).
main([_|C],L,Visitati):-
    main(C,L,Visitati).


scansiona(Parola,[],Freq, Parola-Freq).
scansiona(Parola,[T|C], Freq ,Elemento):-
    Parola = T,
    Freq1 is Freq+1,
    scansiona(Parola,C, Freq1, Elemento).


scansiona(Parola,[_|C],Freq,ListaConFreq):-
    scansiona(Parola,C,Freq,ListaConFreq).

crealista(RestoParole,Parola-Freq,[Parola-Freq|C],Visitati):-
    main(RestoParole,C,[Parola|Visitati]).
