clear; clc;

f  = @(t, y) -2 * (1 + sinpi(t)) * (2 - y)^2;
t0 = 0;
tf = 5;
y0 = 3;

h = 1/4;

% Metodo di Runge Kutta

c = [0;  3/4];
b = [1/3 2/3];
A = [0   0;
    3/4 0];

B = zeros(3, 3);
B(1:end-1, 1    ) = c;
B(end,     2:end) = b;
B(1:end-1, 2:end) = A;

[t, u] = rk(f, B, [t0 tf], y0, h);

% plot(t, u, 'LineWidth', 2);
% title('Soluzione approssimata vs t');

disp(u(end));