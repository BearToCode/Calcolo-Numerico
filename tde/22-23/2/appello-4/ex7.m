clear; clc;

% Si consideri il metodo di Eulero in avanti per l’approssimazione di un sistema di
% equazioni differenziali ordinarie lineari a coefficienti costanti, nella forma
% y′(t) = Ay(t) + g(t), t ∈ (0, 1)
% y(0) = y0
% Si indichino le affermazioni vere:
% 1. Se gli autovalori di A sono tutti complessi ma hanno parte reale negativa, il
% metodo `e sempre assolutamente stabile, indipendentemente dal valore di h.
% 2. Se gli autovalori di A sono tutti numeri reali negativi, il metodo `e sempre
% assolutamente stabile, indipendentemente dal valore di h.
% 3. Il metodo è zero stabile.
% 4. Se per h1 = 0.1 si ottiene un errore pari a e1 = 10−2, quando h2 = 0.025 si
% ha che l’errore `e pari a e2 = 2.5 · 10−3

% 1. FALSA, il metodo di eulero non è incodizionatamente assolutamente stabile
% 2. FALSA, il metodo di eulero non è incodizionatamente assolutamente stabile
% 3. VERA, poiché f (t, y) è Lipschitz-continua

h1 = 0.1;
h2 = 0.025;
E1 = 10^-2;
E2 = 2.5 * 10^-3;

p = log(E2 / E1) / log(h2 / h1); % = 1 => VERO