clear; clc;

f  = @(t, y) t * sin(y);
y0 = 3;
h  = 0.2;
tf = 3;

[t, u] = eulerfwd(f, tf, y0, h);

u_end = u(end);

disp(u_end);

% Approssimo integrale usando formula dei trapezi composita

% I = h/2 * (fun(a) + fun(b)) + h * sum(arrayfun(fun, a+h:h:b-h));

I = h/2 * (u(1) + u_end) + h * sum(u(2:end-1));

disp(I);