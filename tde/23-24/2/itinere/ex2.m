clear; clc;

syms x a;

f(x) = exp(a*x) + (x+2)*(x^2+5);

I = [0 7];

% L'errore di spline dipende dalla derivata quarta

d4f = diff(f, x, 4); % = a^4*exp(a*x)

% L'errore è minimo per a = 0;

disp(d4f);