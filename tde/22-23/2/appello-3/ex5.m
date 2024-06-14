clear; clc;

% Sia f(x) = 4x^3 − 3x + 12 e si consideri l’approssimazione della sua derivata seconda
% con differenze finite centrate e passo di ampiezza h > 0 nel punto x = β ∈ R.
% Quanto vale l’errore commesso Ec(β) = f′′(β) − δ^2c f (β), in funzione di h e di β?

% L'errore dell'approssimazione della derivata seconda con differenze finite
% dipende dalla derivata quarta della funzione (pagina 136 delle note) => la
% funzione è un polinomio di grado 3, quindi la derivata quarta è 0.

err = 0;