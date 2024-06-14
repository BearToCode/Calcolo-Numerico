function [t_h, u_h] = eulerfwd(f, t_max, y0, h)
% EULERFWD: Metodo di eulero in avanti per la risoluzione di un problema di Cauchy.
%
% [t_h, u_h] = eulerfwd(f, t_max, y0, h) risolve il problema di Cauchy
%
% Input:
% - f: funzione del problema di Cauchy
% - t_max: tempo massimo
% - y0: condizione iniziale
% - h: passo
%
% Output:
% - t_h: vettore dei tempi
% - u_h: vettore delle approssimazioni

t_h = 0:h:t_max;
u_h = zeros(1, length(t_h));

u_h(1) = y0;

for i=1:length(t_h)-1
    u_h(i + 1) = u_h(i) + h * f(t_h(i), u_h(i));
end

end