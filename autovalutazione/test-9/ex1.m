a = -1;
b = 1;
f = @(x) cos(pi * x);

res = simpson_simple(a, b, f);

disp(res);

% Quadratura di simpsone semplice
function I = simpson_simple(a, b, fun)
I = (b - a) / 6 * (fun(a) + 4 * fun((a + b) / 2) + fun(b));
end