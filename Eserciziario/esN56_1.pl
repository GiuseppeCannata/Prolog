

:-op(30,fx,non).

refuta_lin(S):-
    refuta(S,[]).

%produzione clausola vuota
refuta(_,[[]|_]).
%al passo 1
refuta([Clausola|C],[]):-
      member(Clausola2,C),
      complementare(Clausola,Clausola2,Lett1,Lett2,Stop),
      Stop = 1,     %ok c è un complementare tra Clausola e X e sono in Lett1 Lett2
      risolvente(Clausola,Clausola2,Lett1,Lett2,Risolvente),
      stampa(Clausola,Clausola2,Risolvente),
      refuta([Clausola|C],[Risolvente]).

refuta(S,Risolventi):-
     Risolventi = [RisolventePrec|R],
     (
         member(Clausola2,S),
         \+ Clausola2 = RisolventePrec
         ;
         member(Clausola2,R),
         \+ Clausola2 = RisolventePrec
      ),
      complementare(RisolventePrec,Clausola2,Lett1,Lett2,Stop),
      Stop = 1,     %ok c è un complementare tra Clausola e X e sono in Lett1 Lett2
      risolvente(RisolventePrec,Clausola2,Lett1,Lett2,Risolvente),
      %TO DO: Sort risolvente e risolventi
      \+ member(Risolvente, Risolventi),
      stampa(RisolventePrec,Clausola2,Risolvente),
      refuta(S,[Risolvente|Risolventi]).



complementare([],_,_,_,0).
complementare([non(Ground)|_],Clausola2,non(Ground),Ground,1):-
    member(Ground,Clausola2).
complementare([Ground|_],Clausola2,Ground,non(Ground),1):-
    \+ Ground = non(_),
    member(non(Ground),Clausola2).
complementare([_|C],[_|C1],Lett1,Lett2,Stop):-
    complementare(C,C1,Lett1,Lett2,Stop).


risolvente(Clausola1,Clausola2,Lett1,Lett2,Risolvente):-
    findall(Letterale, (
                        member(Letterale,Clausola1),
                        \+ Letterale = Lett1
                        ),
            Lista1),
    findall(Letterale, (
                        member(Letterale,Clausola2),
                        \+ Letterale = Lett2
                        ),
            Lista2),
    append(Lista1,Lista2,R),
    eliminaDoppioni(R,[],Risolvente).

eliminaDoppioni([],_,[]).
eliminaDoppioni([T|C],Usati,[T|U]):-
    \+ member(T,Usati),
    eliminaDoppioni(C,[T|Usati],U).
eliminaDoppioni([_|C],Usati,U):-
    eliminaDoppioni(C,Usati,U).








stampa(C1,C2,Risolvente):-
      write(C1),write('         '),write(C2),
      nl,
      write(Risolvente),
      nl.



