

:-op(30, fx,non).
:-op(100,xfy,or).
:-op(100,xfy,and).

traduci(Formula):-
    exists( p(q,s) and p(x,d)) = exists(Formula).
