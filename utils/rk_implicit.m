function [t, u] = rk_implicit(f, B, tv, y0, h)
% RK_SYSTEMS: metodo di Runge-Kutta (implicito) per sistemi di equazioni differenziali ordinarie
%
% Input:
% - f: function che descrive il problema di Cauchy f(t,y(t))
% - B: matrice dei coefficienti del metodo di Runge-Kutta
% - tv: vettore che contiene l'istante iniziale e finale dell'intervallo temporale
% - y0: il dato iniziale del problema di cauchy: y(t=0)=dato_iniziale
% - h: l'ampiezza del passo di discretizzazione temporale.
%
% Output:
% - t: vettore contenente gli istanti in cui si calcola la soluzione discreta
% - u: la soluzione discreta calcolata nei nodi temporali t


t0 = tv(1);
tf = tv(2);

t  = t0:h:tf;
Nh = length(t);

u = zeros(length(y0), Nh);

c = B(1:end-1, 1    );
b = B(end,     2:end);
A = B(1:end-1, 2:end);

s = length(c);
assert(size(A, 1) == s && size(A, 2) == s, 'La matrice A deve essere quadrata');
assert(length(b) == s, 'Il vettore b deve avere la stessa dimensione di c');

u(:, 1) = y0;
for i = 2:Nh
    tn = t(i-1);
    un = u(:, i-1);
    
    % Caso implicito, trovo la matrice k risolvendo un sistema vettoriale non lineare
    F = @(k) k - cell2mat(arrayfun(                     ...
        @(j) f(tn + c(j) * h, un + (h * A(j, :) * k)'), ...
        1:s,                                            ...
        'UniformOutput', false                          ...
        ))';
    options = optimoptions('fsolve','Display','none');
    % Richiede MATLAB R2024a o superiore
    k = fsolve(F, zeros(s, length(y0)), options);
    
    u(:, i) = un + h * (b * k)';
end
end