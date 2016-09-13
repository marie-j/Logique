% Mercier Tony
% Jones Marie

% TP3 : Sudoku

grille([[_,_,_,_,_,_,_,_,_],
        [_,_,_,_,_,3,_,8,5],
        [_,_,1,_,2,_,_,_,_],
        [_,_,_,5,_,7,_,_,_],
        [_,_,4,_,_,_,1,_,_],
        [_,9,_,_,_,_,_,_,_],
        [5,_,_,_,_,_,_,7,3],
        [_,_,2,_,1,_,_,_,_],
        [_,_,_,_,4,_,_,_,9]]).

% Q1 :

printline([]) :- writeln(' | ').
printline([X | L]) :- write(' | '),integer(X),write(X),printline(L), !.
printline([_ | L]) :- printline(L).

% Q2 :

print([]).
print([L | G]) :- printline(L),print(G).

% Q3 :

bonnelongueur([],0).
bonnelongueur([_ | L],N) :- bonnelongueur(L,X), N is (X+1).

% Q4 :

bonnetaille([],_).
bonnetaille([L | G],N) :- bonnelongueur(L,N),bonnetaille(G,N).

% Q5 :

:- use_module(library(clpfd)).

verifie([]).
verifie([L | G]) :- L ins 1..9,all_distinct(L),verifie(G).

% Q6 :

eclate([],[],[]).
eclate([X | L],[H | LL], [[X | H ] | R]) :- eclate(L,LL,R) , !.

% Q7 :

transp([],[]).
transp([[X | L]],[[X] | T]) :- transp([L],T), !.
transp([X | L], M) :- eclate(X,T,M),transp(L,T).

% Q8 :

decoupe([],[],[],[]).
decoupe([X,Y,Z | L1],[X1,Y1,Z1 |L2],[X2,Y2,Z2 |L3],[[X,Y,Z,X1,Y1,Z1,X2,Y2,Z2] | C]) :- decoupe(L1,L2,L3,C), !.

% Q9 :

carres([],[]).
carres([L,L1,L2 | LL],C) :- decoupe(L,L1,L2,C1),carres(LL,C2),append(C1,C2,C).

% Q10 :

solution(G) :- bonnetaille(G,9),transp(G,GC),bonnetaille(GC,9),verifie(G),verifie(GC),carres(G,C),verifie(C).

% Q11 :

% diagonale1 selectionne la diagonale "endroit" d'une grille
diagonale1([[X]],[X]) :- !.
diagonale1([[X | _] | G],[X | D]) :- transp(G,[_ | T]),diagonale1(T,D).

% retourne_grille prend une liste de listes et retourne chaque liste une à une
retourne_grille([],[]).
retourne_grille([L | G],G1) :- reverse(L,L1), retourne_grille(G,T),G1 = [L1 | T].

%diagonale2 selectionne la diagonale "envers" d'une grille
diagonale2(G,D) :- retourne_grille(G,T),diagonale1(T,D).

%verifie_ligne verifie les contraintes d'une seule ligne
verifie_ligne(L) :- L ins 1..9, all_distinct(L).

% diagonales verifie les contraintes sur les deux diagonales d une grille
diagonales(G) :- diagonale1(G,D1),verifie_ligne(D1),diagonale2(G,D2),verifie_ligne(D2).

% crossdoku résoud une grille de sudoku tout en verifiant les contraintes sur les diagonales
crossdoku(G):- solution(G),diagonales(G).

% Q12 :

% pour tester le minidoku
 minigrille([[2,_,_,3],
           [_,_,2,_],
           [_,4,1,_],
          [1,_,_,_]]).

% redefinition de verifie
verifie1([]).
verifie1([L | G]) :- L ins 1..4,all_distinct(L),verifie1(G).

% redefinition de decoupe
decoupe1([],[],[]).
decoupe1([X,Y | L1],[X1,Y1 |L2],[[X,Y,X1,Y1] | C]) :- decoupe1(L1,L2,C), !.

% redefinition de carres
carres1([],[]).
carres1([L,L1| LL],C) :- decoupe1(L,L1,D),carres1(LL,T),append(D,T,C).

% resolution
minidoku(G) :- bonnetaille(G,4),transp(G,GC),bonnetaille(GC,4),verifie1(G),verifie1(GC),carres1(G,C),verifie1(C).

% Q13 :

grillehex([[b,2,_,7,_,_,_,f,6,e,_,_,_,3,_,d],
           [_,_,_,9,b,_,2,_,_,_,_,_,f,1,_,6],
           [_,a,_,c,_,_,7,_,4,_,8,_,_,_,e,_],
           [_,8,_,3,_,_,1,_,_,_,f,c,a,_,4,2],
           [_,_,e,_,_,_,_,_,1,6,a,_,_,_,3,_],
           [3,_,_,_,_,_,_,_,_,4,_,f,8,_,6,b],
           [_,_,_,d,2,_,_,_,_,b,_,_,7,4,_,_],
           [_,b,8,4,0,_,_,d,7,_,9,3,e,_,_,_],
           [_,_,_,f,3,7,_,4,5,_,_,9,0,d,c,_],
           [_,_,c,8,_,_,a,_,_,_,_,b,4,_,_,_],
           [4,9,_,5,e,_,d,_,_,_,_,_,_,_,_,a],
           [_,d,_,_,_,6,c,1,_,_,_,_,_,7,_,_],
           [9,1,_,e,7,4,_,_,_,f,_,_,3,_,d,_],
           [_,3,_,_,_,9,_,2,_,1,_,_,5,_,0,_],
           [f,_,4,b,_,_,_,_,_,3,_,d,1,_,_,_],
           [5,_,d,_,_,_,f,e,9,_,_,_,2,_,b,4]]).

%fonctions d'impression pour une grille hexadecimale
printh(X) :- convert(Y,X), write(Y),!.

printlinehex([]) :- writeln(' | ').
printlinehex([X | L]) :- write(' | '),printh(X),printlinehex(L), !.
printlinehex([_ | L]) :- printline(L).

printhex([]).
printhex([L | G]) :- printlinehex(L),printhex(G).

%fonction de conversion de caractère hexadecimal en decimal
convert('_',16).
convert('a',10).
convert('b',11).
convert('c',12).
convert('d',13).
convert('e',14).
convert('f',15).
convert(C,C).

%fonction qui transforme une ligne
convert_ligne([],[]).
convert_ligne([X | L],N) :- convert(X,Y),convert_ligne(L,T), N = [Y | T] ,!.

%fonction qui transforme une grille
convert_grille([],[]).
convert_grille([L | G],G1) :- convert_ligne(L,T),convert_grille(G,G2),G1 = [T |G2].

%fonction qui remplace les 16 par des _
remplace(16,_) :- !.
remplace(C,C).

remplace_ligne([],[]).
remplace_ligne([X | L],N) :- remplace(X,Y),remplace_ligne(L,T), N = [Y | T],!.

remplace_grille([],[]).
remplace_grille([L | G],G1) :- remplace_ligne(L,L1),remplace_grille(G,G2) , G1 = [L1 | G2].

% redefinition de verifie
verifie2([]).
verifie2([L | G]) :-L ins 0..15,all_distinct(L),verifie2(G).

% redefinition de decoupe
decoupe2([],[],[],[],[]).
decoupe2([W,X,Y,Z | L],[W1,X1,Y1,Z1 | L1],[W2,X2,Y2,Z2 | L2],[W3,X3,Y3,Z3 | L3],[[W,X,Y,Z,W1,X1,Y1,Z1,W2,X2,Y2,Z2,W3,X3,Y3,Z3] | R]) :- decoupe2(L,L1,L2,L3,R).

% redefinition de carres
carres2([],[]).
carres2([L,L1,L2,L3| LL],C) :- decoupe2(L,L1,L2,L3,D),carres2(LL,T),append(D,T,C).

% resolution
maxidoku(G,T) :- bonnetaille(G,16),convert_grille(G,G1),remplace_grille(G1,T),verifie2(T),transp(T,TC),bonnetaille(TC,16),verifie2(TC),carres2(T,C),verifie2(C).

% Q14 :

% pour tester les fonctions sur une grille 3D 4x4x4
grillemini3D(G) :- minigrille(L), G = [L,L,L,L].

%pour tester sur une grille 3D 9x9x9
grille3D(G) :- grille(L), G = [L,L,L,L,L,L,L,L,L].

%fonction d'impression
print3D([]).
print3D([G | C]) :- print(G),print3D(C).

%verification de la taille
bonnetaille3D([],_).
bonnetaille3D([G | C],N) :- bonnetaille(G,N),bonnetaille3D(C,N).

%transposition du cube
transp3D([],[]).
transp3D([G | C],T) :- transp(G,T1),transp3D(C,T2), T = [T1 | T2].

%creation des carres
carres3D([],[]).
carres3D([G | C],L) :- carres1(G,L1),carres3D(C,L2),L =[L1 | L2] .

%fonction de verication
verifiemini3D([]).
verifiemini3D([G | C]) :- verifie1(G),verifie3D(C).

verifie3D([]).
verifie3D([G | C]) :- verifie(G),verifie3D(C).

%resolution
minidoku3D(G) :- bonnetaille3D(G,4),verifiemini3D(G),transp(G,T),transp3D(T,T1),verifiemini3D(T1),carres3D(G,C),verifiemini3D(C).
sudoku3D(G) :- bonnetaille3D(G,9),verifie3D(G),transp(G,T),transp3D(T,T1),verifie3D(T1),carres3D(G,C),verifie3D(C).
