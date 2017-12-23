% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%lanciato cosi:
%metainterprete_base(progr_oggetto(X,Y,Z)).
%cioè 'progr_oggetto(X,Y,Z)', verrà visto come un unico termine
%

progr_oggetto(X,Y,Z):-
    progr_oggetto_pred1(X),
    progr_oggetto_pred1(Y),
    progr_oggetto_pred1(Z).

progr_oggetto_pred1(a).
progr_oggetto_pred1(b).
progr_oggetto_pred1(c).


metainterprete((Goal, Goals)):-
    metainterprete_base(Goal),
    metainterprete_base(Goals).

metainterprete_base(true).

metainterprete_base(Goal):-
    clause(Goal,Body),     %built-in --> esamina il Db per vedere se abbia una testa che sintitticamente coincide con  goal,SE è SI NE PRENDE IL BODY.
    %se però la clausole non presenta il corpo Body è settato a true
    metainterprete_base(Body).


spiega(Sintomi,Cause):-
    abduci( Sintomi,[],Cause,0,_).

abduci(true,Cause,Cause,N,N):-!.
