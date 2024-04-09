clc; clear; close all;

syms x;
symf = cos(2*x)^2 - x^2;
symdf = diff(symf);

a = -1;
b = 1;

f = matlabFunction(symf);
df = matlabFunction(symdf);

%% 1. Si disegni la funzione e si individuino graficamente i punti in cui f (x) = 0.

x = linspace(-2, 2, 1000);
y = f(x);

figure;
plot(x, y);
grid on;

%% 2. Si consideri la funzione di iterazione seguente, dipendente da un parametro A ∈ R
% (costante)
% φ(x) = x + A f (x).
% Si verifichi teoricamente per quale intervallo di valori della costante A il metodo delle
% iterazioni punto fisso, qui usato per la ricerca degli zeri α di f (x), pu`o convergere allo
% zero α > 0 per una scelta opportuna del dato iniziale.
A = 0.1;
phi = @(x) x + A*f(x);
dphi = @(x) 1 + A*df(x);

% |φ'(x)| < 1
% |1 + A*df(x)| < 1
% -2 < A*df(x) < 0

%% 3. Si utilizzi ora la function ptofis.m con A = 0.1 e x(0) = 0.1 per ottenere un valore
% dello zero α, scegliendo come tolleranza 10−10. Si usi il valore dello zero ottenuto per
% verificare numericamente il range di valori ammissibili per A ottenuto teoricamente al
% punto precedente. Si studi la sensibilità della convergenza del metodo al variare di A e
% x(0).

x0 = 0.1;
tol = 1e-10;

ptofis(x0, phi, 1000, tol, a, b);

lb = 0;
alpha_num = 0.51493326;
ub = -2 / df(alpha_num);

%% 

% A = 0.6;
% phi = @(x) x + A*f(x);
% ptofis(x0, phi, 1000, tol, a, b);


%% 4. Stimare l’ordine di convergenza e il fattore di convergenza del metodo di punto fisso
% al variare di A utilizzando la funzione stimap.m, verificando l’affidabilit`a delle stime
% teoriche.

A = [0.1, 0.3, 0.5, 0.7];

for i = 1:length(A)
    fprintf('A = %.1f\n', A(i));
    phi = @(x) x + A(i)*f(x);
    [xvect, ~] = ptofis(x0, phi, 1000, tol, a, b);
    close all;
    [ord, conv] = stimap(xvect);
    fprintf('\n');

    % Stima teorica % NON FUNZIONA... fixme
    dphi2 = @(x) 1 + A(i)*df(x);
    dphi2(xvect(end))
end

%% 5. Fornire un valore di A tale da ottenere un metodo convergente del secondo ordine.

Aopt = -1 / df(alpha_num);

fprintf('Aopt = %.2f\n', Aopt);

%% 6. Ricordando che il metodo di Newton pu`o essere riletto come metodo di punto fisso,
% implementarlo utilizzando la function ptofis.m. Determinare sperimentalmente gli
% intervalli in cui scegliere il dato iniziale in modo che il metodo converga allo zero α
% positivo.

phiN = @(x) x - f(x) ./ df(x);
% plot(x, phiN(x)); => discontinuità in 0

sols = [];
x0v = 0.01:0.01:1;

for x0 = x0v
    [xvect, it] = ptofis(x0, phiN, 1000, tol, a, b);
    sols = [sols, xvect(end)];
end

% Use dots for plot
figure;
plot(x0v, sols, 'o--');

% 0.12 < x0 < 0.88

x0 = 0.6;

[succ, it] = ptofis(x0, phiN, 1000, tol, a, b);