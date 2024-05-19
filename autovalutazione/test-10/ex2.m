clear; clc;

% f(x) = (gamma * x^3 + 7x - 53)

% Differenze finitie centrate, valutare errore in funzione
% di gamma, con h = 1/2

% Ec = -h^2/12 * (f'''(xi) + f'''(eta))

% f'''(x) = 6 * gamma

% f'''(xi) = 6 * gamma
% f'''(eta) = 6 * gamma

% Ec = -h^2/12 * (6 * gamma + 6 * gamma) = -h^2 * gamma

% Ec = -1/4 * gamma