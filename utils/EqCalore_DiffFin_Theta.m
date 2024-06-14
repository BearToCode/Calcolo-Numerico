function [u, x, t] = EqCalore_DiffFin_Theta(mu, f, a, b, us, ud, g0, T, h, delta_t, theta)
% [u, x, t] = EqCalore_DiffFin_Theta(f, a, b, us, ud, g0, T, h, delta_t, theta)
% Soluzione del seguente problema per l'equazione del calore:
%   du/dt - mu d2u/dx2 = f    x in (a, b), t in (0, T]
%   u(0,x) = g0(x)            x in (a, b)
%   u(t,a) = us(t)            t in (0, T]
%   u(t,b) = ud(t)            t in (0, T]
%
% INPUT:
%   - mu: coefficiente
%   - f(x,t): forzante
%   - a, b: estremi del dominio
%   - us(t), ud(t): dati di Dirichlet rispettivamente in x = a e x = b
%   - g0(x): dato iniziale
%   - T: tempo finale
%   - h: passo di discretizzazione spaziale
%   - delta_t: passo di discretizzazione temporale
%   - theta: parametro del theta-metodo
% OUTPUT:
%   - u: soluzione numerica; il primo indice determina il nodo
%        nello spazio, il secondo indice l'istante temporale
%        (u(i,j) = soluzione approssimata al nodo x_i, al tempo t_j)
%   - x: vettore dei nodi di discretizzazione
%   - t: vettore dei tempi
x = a:h:b;
t = 0:delta_t:T;

Nx = length(x) - 2;
Nt = length(t);

u = zeros(length(x), length(t));
u(:, 1) = g0(x);

A = mu / h^2 .* sparsemdiag([-1 2 -1], Nx);
A_theta = speye(Nx) + delta_t * theta * A;

% Ciclo discretizzazione temporale
for k = 1:Nt-1
    curr_t = t(k);
    next_t = t(k+1);
    
    % Assemblo il sistema lineare
    F_curr = arrayfun(@(x) f(x, curr_t), x(2:end-1))';
    F_next = arrayfun(@(x) f(x, next_t), x(2:end-1))';
    
    F_curr(1) = F_curr(1) + us(curr_t) * mu/h^2;
    F_curr(end) = F_curr(end) + ud(curr_t) * mu/h^2;
    
    F_next(1) = F_next(1) + us(next_t) * mu/h^2;
    F_next(end) = F_next(end) + ud(next_t) * mu/h^2;
    
    
    u_curr = u(2:end-1, k);
    
    b_next = (speye(Nx) - delta_t * (1 - theta) * A) * u_curr + ...
        delta_t * theta * F_next + delta_t * (1 - theta) * F_curr;
    
    
    % Risolvo il sistema lineare
    u(2:end-1, k+1) = A_theta \ b_next;
    u(1,k+1)        = us(next_t);
    u(end,k+1)      = ud(next_t);
end

end