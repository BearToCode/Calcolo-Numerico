clear; clc;

f  = @(t, y) sin(pi * t) - y^2;
t0 = 0;
tf = 3;
y0 = 2;
h  = 0.2;
u1 = 1.2;
u2 = 0.912;

% Metodo di Adams-Bashforth a tre passi
t  = t0:h:tf;
Nh = length(t);
u  = zeros(1, Nh);

u(1) = y0;
u(2) = u1;
u(3) = u2;

for n = 3:Nh-1
    u(n+1) = u(n) + h * (...
        23/12 * f(t(n), u(n)) - 4/3 * f(t(n-1), u(n-1)) + 5/12 * f(t(n-2), u(n-2))...
        );
end

disp(u(end))