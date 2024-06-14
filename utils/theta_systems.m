function [t_h, u_h] = theta_systems(f, tv, y0, Nh, theta)
% THETA_SYSTEMS: risolve un sistema di equazioni differenziali ordinarie
% mediante theta-metodo
%
% Input:
% - f: funzione f(t, y) del problema
% - tv: intervallo temporale [t0, tf]
% - y0: condizione iniziale
% - Nh: numero di passi temporali
% - theta: parametro theta
%
% Output:
% - t_h: tempi discretizzati
% - u_h: approssimazioni della soluzione

t0 = tv(1);
tf = tv(2);

t_h   = linspace(t0, tf, Nh+1);
N_len = length(t_h);
u_h   = zeros(length(y0), N_len);

h = (tf - t0) / Nh;

u_h(:, 1) = y0;
for i=1:N_len-1
    % u(n+1) = u(n) + h * f(t(n+1), u(n+1))
    F = @(u) u - u_h(:, i) - h * ((1 - theta) * f(t_h(i), u_h(:, i)) + theta * f(t_h(i + 1), u));
    
    options = optimoptions('fsolve','Display','none');
    % Richiede MATLAB R2024a o superiore
    sol = fsolve(F, u_h(:, i), options);
    u_h(:, i+1) = sol;
end

end