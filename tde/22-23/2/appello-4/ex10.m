clear; clc;

% Si consideri il seguente problema di diffusione:
% ∂u/∂t(x, t) − 2 ∂2u/∂x2(x, t) = 0 x ∈ (0, 1), t > 0,
% u(0, t) = u(1, t) = 0 t > 0,
% u(x, 0) = 20 sin(πx) x ∈ (0, 1).
% Si consideri l’approssimazione di tale problema tramite il metodo delle differenze
% finite centrate con passo di discretizzazione spaziale h = 0.1 e il metodo di Eulero
% in avanti con passo di discretizzazione temporale ∆t = 10−3. Si calcoli u3_1, ovvero
% l’approssimazione di u(0.1, 0.003).

mu = 2;
f  = @(x, t) 0;
a  = 0;
b  = 1;
us = @(t) 0;
ud = @(t) 0;
g0 = @(x) 20 * sin(pi * x);
tf = 1;
h  = 0.1;
dt = 1e-3;
theta = 0; % Eulero in avanti

[u, x, t] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, tf, h, dt, theta);

u3_1 = u(1 + 1, 1 + 3);

disp(u3_1); % 5.8244