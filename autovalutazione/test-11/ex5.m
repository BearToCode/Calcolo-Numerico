clear; clc;

f  = @(t, y, v) sin(pi * t) - y^2 - 3 * v;

t0 = 0;
tf = 10;

y0 = 1;
v0 = 0;

h = 0.2;

Nmax = 100;
toll = 1e-5;

% Metodo le Leap Frog per problemi di Cauchy del secondo ordine

t  = t0:h:tf;
Nh = length(t);

u = zeros(1, Nh);
v = zeros(1, Nh);

u(1) = y0;
v(1) = v0;

for n = 1:Nh-1
    u(n+1) = u(n) + h * v(n) + (h^2)/2 * f(t(n), u(n), v(n));
    
    % v(n+1) = v(n) + h/2 * (f(t(n), u(n), v(n)) + f(t(n+1), u(n+1), v(n+1)));
    
    % Risolvo con metodo di punto fisso
    phi = @(y) v(n) + h/2 * (f(t(n), u(n), v(n)) + f(t(n+1), u(n+1), y));
    [succ, it] = fixedpt(v(n), phi, Nmax, toll);
    v(n+1) = succ(end);
end

fprintf('u_Nh = %f\n', u(end));
fprintf('v_Nh = %f\n', v(end));