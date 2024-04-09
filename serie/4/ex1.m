clear; clc; close all;

% Vogliamo risolvere il problema della ricerca degli zeri dell’equazione non lineare f (x) = 0,
% dove f `e definita da:
% f (x) = x^3 − (2 + e)x^2 + (2e + 1)x + (1 − e) − cosh(x − 1), x ∈ [0.5, 6.5]

f = @(x) x.^3 - (2 + exp(1)).*x.^2 + (2*exp(1) + 1).*x + (1 - exp(1)) - cosh(x - 1);

% 1. Disegnare il grafico della funzione f nell’intervallo [0.5, 6.5] ed evidenziare le radici
% dell’equazione

x = linspace(0.5, 6.5, 1000);
y = f(x);

figure(1);
plot(x, y, 'DisplayName', 'f(x)');
hold on;
grid on;
xlabel('x');
ylabel('f(x)');
title('Grafico della funzione f(x)');
legend('show');


% 2. Si dica per quali radici il metodo di bisezione `e applicabile a partire dal grafico della
% funzione.

intervals = [0.5 1.5;
             3   4  ;
             6   6.5;];

% 4. Calcolare le radici di f per le quali il metodo di bisezione risulta applicabile, utilizzando
% la funzione bisez.m con una tolleranza di 10^−12.

tol = 10^-12;

for i = 1:size(intervals, 1)
    a = intervals(i, 1);
    b = intervals(i, 2);

    if f(a)*f(b) > 0
        fprintf('Intervallo [%f, %f] non valido\n\n', a, b);
        continue;
    end

    [xvect, it] = bisez(a, b, tol, f);
    x = xvect(end);
    
    fprintf('Radice %d: %.15f\n', i, x);
    fprintf('Iterazioni: %d\n\n', it);

    % Plot radice
    plot(x, f(x), 'ro', 'DisplayName', 'Radice');
end