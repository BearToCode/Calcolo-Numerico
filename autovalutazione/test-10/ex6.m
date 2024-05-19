clear; clc;

f  = @(t, y) -y * exp(t * y);
y0 = 2;

t_max = 7;
h = 0.1;

[u_values] = approx_diff_eq(f, y0, h, t_max);
u3 = u_values(4);

disp(u3);


function [u] = approx_diff_eq(f, y0, h, t_max)

t = 0:h:t_max;
u = zeros(1, length(t));

u(1) = y0;

for i = 1:length(t) - 1
    half = u(i) + h/2 * f(t(i), u(i));
    next = u(i) + h * f(t(i) + h/2, half);
    
    u(i + 1) = next;
end
end