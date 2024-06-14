clear; clc;

% Sia f (x) = 5x^3 − 2x2 + 9 e si consideri l’approssimazione della sua derivata prima
% con differenze finite centrate e passo di ampiezza h > 0 nel punto x = α ∈ R.
% Quanto vale l’errore commesso Ec(α) = f′(α) − δcf (α), in funzione di h e di α?

syms x;
f = 5*x^3 - 2*x^2 + 9;

d3f = diff(f, x, 3);
disp(d3f); % 30

% Poiché la derivata è costante posso ottenere il valore esatto in funzione di h
syms h;
err = -1/12 * h^2 * (2 * d3f);

disp(err); % -5*h^2
