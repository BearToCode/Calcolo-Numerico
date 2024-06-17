clear; clc;

% Si consideri il seguente problema di diffusione:
% ∂u/∂t (x, t) − ∂2u/∂x2 (x, t) = 0     x ∈ (0, 1), t > 0,
% u(0, t) = u(1, t) = 0                 t > 0,
% u(x, 0) = 10 sin(π x)                 x ∈ (0, 1).
% Si consideri l’approssimazione di tale problema tramite il metodo delle differenze
% finite centrate con passo di discretizzazione spaziale h = 0.5 e il metodo di Eulero
% in avanti con passo di discretizzazione temporale ∆t = 0.1. Si calcoli u3_1,
% ovvero l’approssimazione di u(0.5, 0.3).

mu = 1;
f  = @(x, t) 0;
a  = 0;
b  = 1;
us = @(t) 0;
ud = @(t) 0;
g0 = @(x) 10 * sin(pi * x);
T  = 0.5;
h  = 0.5;
dt = 0.1;
theta = 0; % Eulero in avanti

[u, x, t] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, dt, theta);

disp(u(1 + 1, 3 + 1)) % 0.0800