clear; clc;

% Funzione di stabilità di un metodo di Runge-Kutta
s = 4;

% z = h * lambda
% syms h lambda;
% z = h * lambda;

syms z;
R = sym(0);

for i = 1:s+1
    R = R + z^(i-1) / factorial(i-1);
end

Rf = matlabFunction(R);

% Trovo le soluzioni di |R(z)| - 1 = 0
F = @(z) abs(Rf(z)) - 1;
% Metodo di bisezione per trovare la soluzione non banale
[succ, ~] = bisez(-5, -1, 1e-5, F);
z0 = succ(end);

% Plot della funzione di stabilità

z = linspace(-5, 5, 1000);

figure;
plot(z, abs(Rf(z)));
title('Funzione di stabilità di un metodo di Runge-Kutta');
xlabel('z');
ylabel('|R(z)|');
hold on;
plot(z, ones(size(z)), 'r--');
plot(z0, 1, 'ro');
hold off;