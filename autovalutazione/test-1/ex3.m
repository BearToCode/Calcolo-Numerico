clc
clear

f1 = @(x) (x-1).^7;
f2 = @(x) x.^7-7*x.^6+21*x.^5-35*x.^4+35*x.^3-21*x.^2+7*x-1;

x_s = 1.01;
err = 100 * abs(f1(x_s) - f2(x_s)) / abs(f1(x_s));

disp(err);