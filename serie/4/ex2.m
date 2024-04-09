clc; clear; close all;

f = @(x) x.^3 - (2 + exp(1)).*x.^2 + (2*exp(1) + 1).*x + (1 - exp(1)) - cosh(x - 1);
df = @(x) 2.*exp(1) - sinh(x - 1) - 2.*x.*(exp(1) + 2) + 3.*x.^2 + 1;
d2f = @(x) 6*x - 2*(2+exp(1)) - cosh(x-1);

% 1. Dal grafico di f e di f' discutere le proprietà di convergenza del metodo di Newton
% per tutti gli zeri, valutando l’opportunità di applicare il metodo di Newton modificato.
% Noto il valore esatto della radice α1 = 1 si valuti la molteplicità della radice.

x = linspace(0.5, 6.5, 1000);
y = f(x);

figure(1);
plot(x, y, 'DisplayName', 'f(x)');
grid on;
hold on;
plot(x, df(x), 'DisplayName', 'f''(x)');
plot(x, d2f(x), 'DisplayName', 'f''''(x)');
legend('show');
hold off;

% 3. 3. Risolvere il problema della ricerca degli zeri di f tramite il metodo di Newton, uti-
% lizzando la funzione newton.m con tolleranza 10−6. Si utilizzi per il calcolo di ogni
% radice un opportuno valore x0. Nel caso della radice α1 = 1 si riporti su un grafico in
% scala semilogaritmica l’andamento degli errori in funzione del numero di iterazioni per
% il metodo di Newton standard e per quello modificato.

intervals = [0.5 1.5;
             3   4  ;
             6   6.5;];
x0 = [0.5;
        3;
      6.5;];
tol = 1e-6;
nmax = 1000;

for i = 1:size(intervals, 1)
    [xvect, it] = newton(x0(i), nmax, tol, f, df);
    x = xvect(end);
    fprintf('Root: %.15f\nIterations: %d\n\n', x, it);

    if i == 1
        [xvect_mod, it_mod] = newton(x0(i), nmax, tol, f, df, 2);
        x_mod = xvect_mod(end);
        fprintf('Root (modified): %.15f\nIterations (modified): %d\n\n', x_mod, it_mod);

        figure(2);
        radix = 1;
        semilogy(1:it, abs(xvect - radix), 'DisplayName', 'Newton');
        hold on;
        semilogy(1:it_mod, abs(xvect_mod - radix), 'DisplayName', 'Newton modified');
        grid on;
        legend('show');
        title('Errore in scala semilogaritmica');
        xlabel('Iterazioni');
        ylabel('Errore');
        hold off;
    end
end