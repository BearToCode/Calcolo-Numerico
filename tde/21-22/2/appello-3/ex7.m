clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = −2 y(t)                              t ∈ (0, +∞),
% y(0) = 10.
% Utilizzando il θ-metodo con parametro θ = 3/4 e passo h = 0.1, si riporti il valore
% calcolato di u1, ovvero l’approssimazione di y(t1), essendo tn = n h per n = 0, 1, . . .

f  = @(t, y) -2 * y;
y0 = 10;


theta = 3/4;
h     = 0.1;
tf    = 10;
Nh    = tf / h;

[t, u] = theta_systems(f, [0 tf], y0, Nh, theta);
u1 = u(1+1);

disp(u1); % 8.2609