syms x;
symf = x * sin(x);
symdf = diff(symf);

df = matlabFunction(symdf);

a = 0.5;
b = 4.5;

tol = 10^-4;

[xvect, it] = bisez(a, b, tol, df);

fplot(symdf);
hold on;
grid on;
fplot(symf);
hold off;