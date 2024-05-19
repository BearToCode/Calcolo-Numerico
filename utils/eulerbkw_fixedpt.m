function [t_h, u_h, iter_pf] = eulerbkw_fixedpt(f, t_max, y0, h)
%% eulerfwd: Metodo di eulero all'indietro per la risoluzione di un problema di Cauchy.

tol  = 10^-5;
nmax = 100;

t0      = 0;
t_h     = t0:h:t_max;
Nh      = length(t_h);
u_h     = zeros(1, Nh);
iter_pf = zeros(1, Nh);

u_h(1) = y0;

for i=1:Nh-1
    % u(n+1) = u(n) + h * f(t(n+1), u(n+1))
    % y = phi(y) dove y = u(n+1)
    % phi(y) = u(n) + h * f(t(n), y)
    
    phi = @(u) u_h(i) + h * f(t_h(i + 1), u);
    
    [succ, it]   = fixedpt(u_h(i), phi, nmax, tol);
    u_h(i+1)     = succ(end);
    iter_pf(i+1) = it;
end

end