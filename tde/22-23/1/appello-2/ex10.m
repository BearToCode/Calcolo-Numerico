% Si consideri il metodo delle iterazioni di punto fisso per trovare l’unica soluzione
% dell’equazione non lineare x + log x = 0. Date le seguenti funzioni di iterazione
% 1. φ1(x) = −log x,
% 2. φ2(x) = e^−x,
% 3. φ3(x) = 1/2 (x + e^−x),
% 4. φ4(x) = x(1 − log x) / (x + 1) ,
% si indichi per quale delle precedenti funzioni di iterazione il metodo delle iterazioni
% di punto fisso converge con ordine quadratico per x(0) “sufficientemente” vicino al
% punto fisso.

syms x;

phi1 = -log(x);
phi2 = exp(-x);
phi3 = 1/2 * (x + exp(-x));
phi4 = x*(1 - log(x)) / (x + 1);

eq = x + log(x) == 0;
sol = solve(eq);

m1 = mzero(phi1, sol);
m2 = mzero(phi2, sol);
m3 = mzero(phi3, sol);
m4 = mzero(phi4, sol);

fprintf('phi1: %d\n', m1);
fprintf('phi2: %d\n', m2);
fprintf('phi3: %d\n', m3);
fprintf('phi4: %d\n', m4);