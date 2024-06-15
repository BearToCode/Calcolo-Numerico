clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = −3 y(t) t ∈ (0, +∞),
% y(0) = 4.
% Utilizzando il θ-metodo con parametro θ = 1 e passo h = 0.1, si riporti il valore
% calcolato di u1, ovvero l’approssimazione di y(t1), essendo tn = n h per n = 0, 1, . . ..

f     = @(t, y) -3 * y;
y0    = 4;
tf    = 0.1;
h     = 0.1;
theta = 1;

Nh    = tf / h;

[t, u] = theta_systems(f, [0, tf], y0, Nh, theta);

disp(u(1 + 1)); % 3.0769