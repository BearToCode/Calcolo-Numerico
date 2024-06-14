clear; clc;

% Si consideri il seguente problema di diffusione:
% ∂u/∂t(x, t) − 8 ∂2u/∂x2(x, t) = 0 x ∈ (0, 1), t > 0,
% u(0, t) = u(1, t) = 1 t > 0,
% u(x, 0) = 5 sin(πx) x ∈ (0, 1).
% Si consideri l’approssimazione di tale problema tramite il metodo delle differenze
% finite centrate con passo di discretizzazione spaziale h = 1/10 e il metodo di Eulero
% in avanti con passo di discretizzazione temporale ∆t > 0. Per quali valori di ∆t è
% garantita l’assoluta stabilità?

% ∆t < h^2/2μ

h = 1/10;
mu = 8;

dt = h^2/(2*mu);

disp(dt); % dt < 6.2500e-04