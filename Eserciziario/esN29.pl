% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%es N 29
%verificare e creare il fontore di uscita
%

%PER L OPERAZIONE DI +
op1(+,+,N1,N2,+,N):-
    N is N1+N2.

op1(+,-,N1,N2,S,N):-
    (
       N1 >= N2,
       S = '+'
       ;
       S = '-'
     ),
    N is abs(N1-N2).


op1(-,+,N1,N2,S,N):-
    (
       N1 >= N2,
       S = '-'
       ;
       S = '+'
     ),
    N is abs(-N1+N2).

op1(-,-,N1,N2,-,N):-
    N is abs(N1+N2).


%PER L OPERAZIONE DI -

%IL SECONDO + diventa -
op2(+,+,N1,N2,s,N):-
  (
    N1 >= N2,
    S = '+'
    ;
    S = '-'
  ),
  N is abs(N1-N2).


%il secondo - diventa +
op2(+,-,N1,N2,+,N):-
    N is N1+N2.

%il secondo + diventa -
op2(-,+,N1,N2,-,N):-
    N is abs(N1+N2).

%il secondo - diventa +
op2(-,-,N1,N2,-,N):-
    (
       N1 >= N2,
       S = '-'
       ;
       S = '+'
     ),
    N is abs(-N1+N2).





calc:-
    write('Dai il primo numero complesso: '),
    read(Numero1),
    write('Dai il secondo numero complesso: '),
    read(Numero2),
    write('dai l operazione da eseguire: '),
    read(Operazione),
    decompNum(Numero1,SR1,R1,SI1,I1),
    decompNum(Numero2,SR2,R2,SI2,I2),
    (
        Operazione = '+',
        op1(SR1,SR2,R1,R2,SR,R),
        op1(SI1,SI2,I1,I2,SI,I)
        ;
        Operazione = '-',
        op2(SR1,SR2,R1,R2,SR,R),
        op2(SI1,SI2,I1,I2,SI,I)
    ).






decompNum(Numero,SR,R,SI,I):-
    arg(1,Numero,SR),
    arg(2,Numero,R),
    arg(3,Numero,SI),
    arg(4,Numero,I).



