clc; clear;

A = [11 0 0;
     5 -2 0;
     3 0 -9;];

x = linspace(-20, 20, 200);
y = zeros(200, 1);

it = 0;
for i=x
    it = it + 1;
    approx = invpowershift(A, i, 10^-3, 100, [1;1;1]);
    disp(approx)
    y(it) = approx;
end

plot(x, y);