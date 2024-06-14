clear; clc;

% Si consideri il metodo di Eulero all’indietro per l’approssimazione di un sistema di
% equazioni differenziali ordinarie lineari a coefficienti costanti, nella forma
% y′(t) = Ay(t) + g(t), t ∈ (0, +∞),
% y(0) = y0.
% Si indichino le affermazioni vere:
% 1. Se la matrice A è simmetrica, allora il metodo è incondizionatamente asso-
% lutamente stabile per qualsiasi scelta di h e di y0.
% 2. Se gli autovalori di A possiedono tutti parte reale negativa, il metodo nu-
% merico è sempre assolutamente stabile, indipendentemente dal valore di h.
% 3. Il metodo è zero–stabile e accurato al primo ordine.
% 4. Se per il passo h1 = 0.1 si ottiene un errore pari a e1 = 10−2, quando
% h2 = 0.025 l’errore atteso `e pari a e2 = 6.25 · 10−4.

% 1. FALSA, la matrice A simmetrica non implica stabilità incondizionata. Dipende dal metodo.
% 2. VERA, il metodo di eulero all'indietro è incondizionatamente stabile(autovalore con Re < 0)
% 3. VERA, il metodo è zero-stabile e accurato al primo ordine (consistente e convergente).

e1 = 1e-2;
h1 = 0.1;
h2 = 0.025;

e2 = e1 * (h2 / h1);

% FALSA, l'errore atteso è e2 = 2.5e-4.