% Si consideri il metodo di Richardson stazionario precondizionato per risolvere il
% sistema lineare Ax = b, dove A =
%
% 8 −2 0
% −2 10 −2
% 0 −2 11
%
% e b = 1. Posto il precondizionatore P =
%
% 6 0 0
% 0 6 0
% 0 0 9
%
% si calcoli il valore ottimale del parametro α_opt ∈ R
% e lo si utilizzi per determinare l’iterata x(6) ∈ R3 del metodo usando opportuna-
% mente la funzione Matlab richardson.m e avendo scelto x(0) = b. Si riportino
% αopt e x(6)

A = [8 -2 0; 
    -2 10 -2; 
     0 -2 11];

b = [1; 1; 1];

P = [6 0 0; 
     0 6 0; 
     0 0 9];

x0 = b;

% Valore ottimare parametro a_opt per richardson stazionario
a_opt = 2 / (max(eig(P^-1 * A)) + min(eig(P^-1 * A)));

% Iterata x(6) del metodo di Richardson

[x] = richardson(A, b, P, x0, 0, 6, a_opt);

fprintf('Il valore ottimale del parametro α_opt è: %d\n', a_opt);
fprintf("L\'iterata x(6) è: \n");
disp(x);