%Mercier Tony
%Jones Marie

%TP1 Logique

% question 1 :
contenu(tigre).
contenu(princesse).


% question 2 :
pancarte1(tigre,_).
pancarte1(princesse,princesse).
pancarte2(princesse,_).

% question 3 :
salle1(X,Y) :- contenu(X),contenu(Y), not(pancarte1(X,Y)) , not(pancarte2(X,Y)).
salle1(X,Y) :- pancarte1(X,Y) , pancarte2(X,Y).

% question 6 :
pancarte3(princesse,tigre).
pancarte4(princesse,tigre).
pancarte4(tigre,princesse).

salle2(X,Y) :- contenu(X),contenu(Y), pancarte3(X,Y) , not(pancarte4(X,Y)).
salle2(X,Y) :- contenu(X),contenu(Y), not(pancarte3(X,Y)), pancarte4(X,Y).

% question 11 :

contenu(rien).

pancarte5(_,_,rien).
pancarte6(tigre,_,_).
pancarte7(_,_,rien).

porte1(princesse,Y,Z) :- pancarte5(princesse,Y,Z),pancarte7(princesse,Y,Z).
porte1(tigre,Y,Z) :- not(pancarte5(tigre,Y,Z)),not(pancarte7(tigre,Y,Z)).

porte2(X,tigre,Z) :- not(pancarte6(X,tigre,Z)).
porte2(X,princesse,Z) :- pancarte6(X,princesse,Z).

porte3(X,Y,rien):-pancarte7(X,Y,Z),pancarte5(X,Y,Z).

% question 12 :

salle3(X,Y,Z) :- contenu(X),contenu(Y),contenu(Z),porte1(X,Y,Z),porte2(X,Y,Z),porte3(X,Y,Z), X\=Y , Y\=Z , X\=Z.
