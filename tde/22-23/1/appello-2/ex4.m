% Si consideri la fattorizzazione LU senza pivoting di una matrice A ∈ Rn×n. Quale
% o quali tra le seguenti affermazioni sono vere?
% 1. Data A = [ 2 4; 1 3 ], abbiamo L = [ 1 0; 0.5 1 ]
% e U = [ 2 4; 0 1 ].
% 2. Se la matrice A è invertibile allora esiste sempre unica la fattorizzazione LU.
% 3. Per n = 300, la costruzione di L e U tramite il MEG richiede ordine
% 18 000 000 operazioni.
% 4. Se la matrice A `e sparsa allora anche L e U sono matrici sparse.
% 5. Se un elemento pivotale `e nullo allora la matrice A `e singolare.


% 1.
A = [2 4; 1 3];
[L, U] = lu(A);
assert(isequal(L, [1 0; 0.5 1]));
assert(isequal(U, [2 4; 0 1]));

% 2. Falso
% 3.
n = 300;
flops = 2/3 * n^3;
disp(flops);

% 4. Falso, possono essere dense (infatti abbiamo anche fattorizazioni con pivoting di righe)
% 5. Falso