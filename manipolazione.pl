% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

% stampa a video tutti i files della directory corrente
elenca_files :-
	working_directory(D,D),
	directory_files(D, Files),
	stampa_video(Files).

% restituisce a secondo membro tutti e solo i files
% della directory passata al primo membro
elenca_files(D, Files) :-
	working_directory(_, D),
	directory_files(D, Fs),
	selez_file(Fs, Files).

% restituisce a secondo membro tutti e solo i files
% della directory passata al primo membro
elenca_subdir(D, Dirs) :-
	working_directory(_, D),
	directory_files(D, Fs),
	selez_dir(Fs, [_,_|Dirs]).

% presente(File) verifica che il +File sia nella directory corrente
% oppure instanzia -File al nome di un file o di una directory
presente(File) :-
	working_directory(D,D),
	directory_files(D, Files),
	member(File,Files).

% stampa a video solo le sottodirectory della directory corrente
elenca_subdir :-
	working_directory(D,D),
	directory_files(D, Files),
	selez_dir(Files,Dir),
	stampa_video(Dir).

selez_dir([],[]).
selez_dir([T|C],[T|C1]) :-
	exists_directory(T),
	!,
	selez_dir(C,C1).
selez_dir([_|C],C1) :-
	selez_dir(C,C1).

selez_file([],[]).
selez_file([T|C],[T|C1]) :-
	exists_file(T),
	!,
	selez_file(C,C1).
selez_file([_|C],C1) :-
	selez_file(C,C1).


% stampa a video tutti i files nelle directores D e discendenti
stampa_tutti_files(D,Files) :-
	findall(A,file_sotto_directory(D,A),Files),
	stampa_video(1,Files).

file_sotto_directory(D,File) :-
	directory_files(D, Files),
	member(X,Files),
	X \= '.', X \= '..',
	directory_file_path(D,X,Path),
	(
	    \+ exists_directory(Path),
	    File = Path
	    ;
	    exists_directory(Path),
	    file_sotto_directory(Path,File)
	).

% Come stampa_tutti_files ma in ListaPiatta non esistono files
% con lo stesso nome; se questo dovesse capitare il file che si sta per
% aggiungere mantiene il proprio pathname
appiattisci_tutti_files(D,ListaPiatta) :-
	findall(A,file_sotto_directory(D,A),Files),
	appiattisce(Files,[],ListaPiatta).

appiattisce([],L,L) :- !.
appiattisce([File|Resto],Parziale,L) :-
	file_base_name(File,F),
	(
	    \+ member(F,Parziale),
	    appiattisce(Resto,[F|Parziale],L)
	    ;
	    member(F,Parziale),
	    appiattisce(Resto,[File|Parziale],L)
	).

% sposta_appiattendo(+Origine,+Destinazione) sposta tutti i Files
% dalla cartella Origine e sue sottocartelle nella Destinazione
sposta_appiattendo(Origine,Destinazione) :-
	findall(A,file_sotto_directory(Origine,A),Files),
	make_directory(Destinazione),
	sposta(Files,[],Destinazione),
	!.

sposta([],_,_) :- !.
sposta([File|Rest],Moved,D) :-
	file_base_name(File,F),
	(
	    \+ member(F,Moved),
	    directory_file_path(D,F,NewFile),
	    rename_file(File,NewFile),
	    sposta(Rest,[F|Moved],D)
	    ;
	    member(F,Moved),
	    directory_file_path(D,File,NewFile),
	    rename_file(File,NewFile),
	    sposta(Rest,Moved,D)
	).


stampa_video(X) :-
	stampa_video(1,X).
stampa_video(_,[]) :- !.
stampa_video(N,[T|C]) :-
	write(N), N1 is N+1, write(' '),
	write(T), nl,
	stampa_video(N1,C).
