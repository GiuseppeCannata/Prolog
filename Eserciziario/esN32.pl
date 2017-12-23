% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N32
% non funziona bene il more, dovrebbe falsificarsi scrivi ma lo fa solo
% una volta
%
%
sottos(LI,S,LO):-
   findall(Result, (predicato(LI,S,App,[],0),reverse(App,Result)) , Results),
   eliminaDoppioni(Results,NResults),  %siccome il findall prende anche i doppioni,
   write(NResults),
   scrivi(NResults,LO,y).

%La prima volta meccer� con questa clausola restituendo LO...
scrivi([H|_],H,y).
% ...appena per� provocher� il fallimento per back, far� fallire la
% clausola precedente e il match avverr� con questa
scrivi([_,H1|C],HX,y):-
        write('more(y/n)?'),
        read(X),
        scrivi([H1|C],HX,X).



predicato(_,S,Visitati,Visitati,S).
predicato([T|C],S,LO,Visitati,Somma):-
    \+ member(T,Visitati),
    Somma1 is Somma+T,
    predicato(C,S,LO,[T|Visitati],Somma1).
predicato([_|C],S,LO,Visitati,Somma):-
    predicato(C,S,LO,Visitati,Somma).

eliminaDoppioni([],[]).
eliminaDoppioni([T|C],[T|U]):-
   \+ member(T,C),
   eliminaDoppioni(C,U).
eliminaDoppioni([_|C],LU):-
    eliminaDoppioni(C,LU).
