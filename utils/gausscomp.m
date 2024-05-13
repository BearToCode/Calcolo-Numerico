function I = gausscomp(a, b, N, fun)
%% gausscomp: formula di quadratura di Gauss–Legendre composita a due punti

h = (b - a) / N;

xm = a+h/2:h:b-h/2;

x0 = xm - h / (2 * sqrt(3));
x1 = xm + h / (2 * sqrt(3));

y0 = fun(x0);
y1 = fun(x1);

I = h / 2 * sum(y0 + y1);

end
