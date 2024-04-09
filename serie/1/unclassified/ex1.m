clc
clear

% Ex 1.1
v1 = 2 .^ (0:10);
v2 = cos(pi ./ (1:10))';
v3 = .1 ./ (2 .^ (0:5));

a = (ones(1, 10) .* -1) .^ (0:9);

steps = 0:pi/2:2*pi;
cosenato = cos(steps);
(cosenato .* ((0:4) + 2)) .* 2.5

v4 = (exp(1) .^ (0:0.5:10));

% Ex 1.2
A = diag(2  * ones(5,1))      + ...
    diag(5  * ones(4,1),  -1) + ...
    diag(10 * ones(3, 1), -2) + ...
    diag(10 * ones(3, 1),  2) + ...
    diag(40, -4)              + ...
    diag(40, 4);
