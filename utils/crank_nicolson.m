function [t_h, u_h, iter_pf] = crank_nicolson(f, t_max, y0, h)
% CRANK_NICOLSON: risolve una equazione differenziale ordinaria
% mediante il metodo di Crank-Nicolson (metodo di punto fisso)
%
% Input:
% - f: funzione f(t, y) del problema
% - t_max: tempo massimo
% - y0: condizione iniziale
% - h: passo temporale
%
% Output:
% - t_h: tempi discretizzati
% - u_h: approssimazioni della soluzione

tol  = 10^-5;
nmax = 100;

t0      = 0;
t_h     = t0:h:t_max;
Nh      = length(t_h);
u_h     = zeros(1, Nh);
iter_pf = zeros(1, Nh);

u_h(1) = y0;

for i=1:Nh-1
    % u(n+1) = u(n) + h/2 * (f(t(n), u(n)) + f(t(n+1), u(n+1)))
    % y = phi(y) dove y = u(n+1)
    % phi(y) = u(n) + h/2 * (f(t(n), u(n)) + f(t(n+1), y))
    
    phi = @(u) u_h(i) + h / 2 * (f(t_h(i), u_h(i)) + f(t_h(i + 1), u));
    
    [succ, it]   = fixedpt(u_h(i), phi, nmax, tol);
    u_h(i+1)     = succ(end);
    iter_pf(i+1) = it;
end

end