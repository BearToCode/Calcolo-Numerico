function [t_h,u_h] = heun_systems(f, tv, y0, Nh)
% HEUN_SYSTEMS: metodo di Heun (esplicito) per la soluzione di
% sistemi di EDO di primo ordine.
%
%       [t_h,u_h]= Heun_sistemi(f, tv, y0, Nh)
%
% f tale che y' = f
%
% tv:vettore dell'istante iniziale e finale [t0 tf]
% Nh: numero di sottointervali

% trovo il vettore degli istanti in cui risolvo la ode
t0    = tv(1);
t_max = tv(2);
t_h   = linspace(t0,t_max,Nh+1);

h   = (t_max-t0)/Nh;
Nln = length(t_h);
u_h = zeros(length(y0),Nh+1);


u_h(:,1) = y0;
for it = 1:Nln-1
    u_old       = u_h(:,it);
    u_star      = u_old + h * f(t_h(it),u_old);
    u_h(:,it+1) = u_old + (h/2) * (f(t_h(it),u_old) + f(t_h(it+1),u_star));
end
end