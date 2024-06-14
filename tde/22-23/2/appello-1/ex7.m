clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = −3y(t) + y(t)^2 t ∈ (0, +∞)
% y(0) = 2.
% Utilizzando il θ–metodo con parametro θ = 1/2 e passo h = 0.1, si riporti il valore
% calcolato di u1, ovvero l’approssimazione di y(t1), essendo tn = nh per n = 0, 1, . . ..

f  = @(t, y) -3*y + y^2;
y0 = 2;

h = 0.1;
t_max = 0.1;

[~, u] = crank_nicolson(f, t_max, y0, h);

disp(u(end)); % 1.7918
