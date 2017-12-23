% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

:- ensure_loaded(copia).


cruciverba([['0','0','0','0','0','0'],
     ['0','0','0','0','0','0'],
     ['0','0','0','0','0','0'],
     ['0','0','0','0','0','0']], Percorso,Usate).


/*
cruciverba([['0','0','0','0','0'],
     ['0','0','0','0','0'],
     ['0','0','0','0','0']], Percorso,Usate).
*/


cruciverba(ListaDiListeDiNeri,Percorso,ParoleUsate) :-
	dfs(ListaDiListeDiNeri,Percorso,[],ParoleUsate).

dfs(ListaDiListe,[ListaDiListe],Usate,Usate) :-
	stampa(ListaDiListe),
	nl,
	trasposta(ListaDiListe,Trasposta),
	verifica(Trasposta),
	length(Usate,L), L >= 2.

dfs(ListaDiListe,[ListaDiListe|PercorsoParziale],Acc,Usate) :-
	suc(ListaDiListe,Successiva,Parola),
	\+ member(Parola,Acc),
	dfs(Successiva,PercorsoParziale,[Parola|Acc],Usate).

verifica([]).
verifica([Colonna|_]) :-
	errata(Colonna), !, fail.
verifica([_|C]) :-
	verifica(C).

errata(Colonna) :-
	append(_,['0'|L],Colonna),
	append(S,['0'|_],L),
        length(S,N), N>=2,
	tuttelettere(S),
	atom_chars(Atomo,S),
	\+ p(Atomo).
errata(Colonna) :-
	append(S,_,Colonna),
        length(S,N), N>=2,
	tuttelettere(S),
	atom_chars(Atomo,S),
	\+ p(Atomo).
errata(Colonna) :-
	append(_,['0'|S],Colonna),
        length(S,N), N>=2,
	tuttelettere(S),
	atom_chars(Atomo,S),
	\+ p(Atomo).

suc(C1,C2,P) :-
	append(RighePrima,[Riga|RigheDopo],C1),
	append(Prima,L1,Riga),
	append(Neri,Dopo,L1),
	tuttineri(Neri),
	length(Neri,NNeri),
	N is NNeri - 2,
	p(P),
	atom_chars(P,Parola),
	length(Parola,N),
	append(Parola,['0'|Dopo],L2),
	append(Prima,['0'|L2],NuovaRiga),
	append(RighePrima,[NuovaRiga|RigheDopo],C2).

tuttineri(['0','0','0','0']) :- !.
tuttineri(['0'|C]) :-
	tuttineri(C).

tuttelettere([A,B]) :-
	char_type(A, alpha),
	char_type(B, alpha).
tuttelettere([T|C]) :-
	char_type(T, alpha),
	tuttelettere(C).

trasposta([[]|_],[]).
trasposta(Matrice,[Colonna|RestoColonne]) :-
	colonna(Matrice,Colonna,RestoMatrice),
	trasposta(RestoMatrice,RestoColonne).

colonna([],[],[]).
colonna([[TR|CR]|CM],[TR|X],[CR|Y]) :-
	colonna(CM,X,Y).


stampa([]).
stampa([T|C]) :-
	stampariga(T),
	nl,
	stampa(C).

stampariga([]).
stampariga([T|C]) :-
	write(T),write(' '),
	stampariga(C).
