f = @(x) exp(x) + exp(sin(2 * pi * x));
n = 1;
a = -2;
b = 2;
N = 8;

I = glquad(a, b, N, n, f);

disp(I);