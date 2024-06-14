clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = −t y(t)^4 − 6t t ∈ (0, +∞),
% y(0) = 1,
% e lo si approssimi mediante il metodo di Eulero in avanti con passo h = 0.05.
% Quanto vale u2, ovvero l’approssimazione di y(t2), essendo tn = n h per n =
% 0, 1, . . .?

f    = @(t, y) -t * y^4 - 6 * t;
y0   = 1;
h    = 0.05;
tmax = 2;

[t_h, u_h] = eulerfwd(f, tmax, y0, h);

u2 = u_h(2 + 1);

disp(u2); % 0.9825