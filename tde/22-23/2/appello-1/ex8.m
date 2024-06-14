clear; clc;

% Si consideri il seguente problema ai limiti:
% −u′′(x) + 2u′(x) = 1 x ∈ (0, 1),
% u′(0) = u(1) = 0.
% Si consideri una discretizzione del problema con il metodo delle differenze finite
% centrate con passi di discretizzazione h = 1/10, 1/20, 1/40 e si valuti il numero di
% condizionamento della matrice (del sistema lineare condensato) ottenuta da tale
% discretizzazione per i tre passi h considerati.

mu    = 1;
eta   = 2;
sigma = 0;
f     = @(x) 1;
a = 0; a_cond = "neumann";   alpha = 0;
b = 1; b_cond = "dirichlet"; beta  = 0;

h_values = [1/10, 1/20, 1/40];

for h = h_values
    [~, ~, A, ~] = dtr(mu, eta, sigma, f, a, b, a_cond, b_cond, alpha, beta, h);
    disp(cond(full(A)));
end

% 2.7071e+03
% 1.5896e+04
% 9.1226e+04
