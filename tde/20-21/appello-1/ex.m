% Si consideri il sistema lineare A x = b, dove A ∈ Rn×n `e una matrice simmetrica
% e definita positiva, e x, b ∈ Rn per n ≥ 1.
% In particolare, poniamo n = 100, A corrispondente alla seguente matrice pen-
% tadiagonale
% A = pentadiag ( 1, −11, 20, −11, 1 ) ∈ R100×100,
% mentre b ∈ R100 tale per cui la soluzione esatta del sistema lineare `e x = 2 ∈
% R100.

n = 100;
A = mdiag([1, -11, 20, -11, 1], n);

% 7. Si consideri ora il seguente sistema di equazioni non lineari
% F(x) = A x + e−2x − 1 = 0,
% dove F : R100 → R100 e la matrice A `e stata definita precedentemente.
% Si approssimi lo zero α = 0 ∈ R100 del precedente sistema di equazioni non
% lineari implementando opportunamente il metodo di Newton in Matlabr .
% Si riportino:
% • l’espressione della generica matrice Jacobiana JF(x);
% • i valori della prima componente della prima, seconda e terza iterata, ovvero
% (x(1))1, (x(2))1 e (x(3))1, ottenute applicando il metodo di Newton a partire
% dal vettore iniziale x(0) = (0.3, 0.3, . . . , 0.3)T ∈ R100;
% • i comandi Matlabr usati.

syms x [n 1];

x0 = 0.3 * ones(n, 1);
F = A*x + exp(-2*x) - 1;

% Jacobiana automatica
[~, ~, xvect] = symnewton(x0, 3, 0, F);

% Jacobiana manuale
JF = A - 2*diag(exp(-2*x));
[~, ~, xvect] = symnewton(x0, 3, 0, F, JF);