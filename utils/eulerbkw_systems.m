function [t_h, u_h] = eulerbkw_systems(f, tv, y0, Nh)
% EULERBKW_SYSTEMS: risolve un sistema di equazioni differenziali ordinarie
% tramite il metodo di Eulero all'indietro.
%
% Input:
% - f: function che descrive il problema di Cauchy f(t,y)
% - tv: vettore che contiene l'istante iniziale e finale dell'intervallo temporale
% - y0: il dato iniziale del problema di cauchy: y(t=0)=dato_iniziale
% - Nh: il numero di sottointervalli in cui si suddivide l'intervallo temporale
%
% Output:
% - t_h: vettore contenente gli istanti in cui si calcola la soluzione discreta
% - u_h: la soluzione discreta calcolata nei nodi temporali t

nmax = 1000;
toll = 1e-6;

t0 = tv(1);
tf = tv(2);

t_h   = linspace(t0, tf, Nh+1);
N_len = length(t_h);
u_h   = zeros(length(y0), N_len);

h = (tf - t0) / Nh;

u_h(:, 1) = y0;
for i=1:N_len-1
    % u(n+1) = u(n) + h * f(t(n+1), u(n+1))
    phi = @(u) u_h(:, i) + h * f(t_h(i + 1), u);
    x0  = u_h(:, i);
    
    [succ] = fixedpt_systems(x0, phi, nmax, toll);
    sol    = succ(:, end);
    
    u_h(:, i+1) = sol;
end

end