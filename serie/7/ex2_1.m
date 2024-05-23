clc; clear;

target = 0;

syms x;
symf = exp(-x^2) * sin(2*x + 1);
symdf = diff(symf, x);
symd2f = diff(symdf, x);

f = matlabFunction(symf);
df = matlabFunction(symdf);
d2f = matlabFunction(symd2f);

df_exact = df(target);
d2f_exact = d2f(target);

% 1. Si approssimi f′(0) tramite gli schemi alle differenze finite in avanti, all’indietro e centra-
% te, utilizzando un passo h = 0.4, 0.2, 0.1, 0.05, 0.025, 0.0125. Per ciascuno dei tre schemi
% si calcoli l’errore commesso e se ne visualizzi l’andamento in funzione del passo h su
% un grafico in scala logaritmica su entrambu gli assi; verificare che ci sia accordo con i
% risultati teorici.

h_values = [0.4, 0.2, 0.1, 0.05, 0.025, 0.0125];

df_approx_fwd = zeros(1, length(h_values));
df_approx_back = zeros(1, length(h_values));
df_approx_centered = zeros(1, length(h_values));
df_err_abs_fwd = zeros(1, length(h_values));
df_err_abs_back = zeros(1, length(h_values));
df_err_abs_centered = zeros(1, length(h_values));

i = 1;
for h=h_values
    df_approx_fwd(i) = (f(target + h) - f(target)) / h;
    df_approx_back(i) = (f(target) - f(target - h)) / h;
    df_approx_centered(i) = (f(target + h) - f(target - h)) / (2*h);
    
    df_err_abs_fwd(i) = abs(df_exact - df_approx_fwd(i));
    df_err_abs_back(i) = abs(df_exact - df_approx_back(i));
    df_err_abs_centered(i) = abs(df_exact - df_approx_centered(i));
    
    i = i + 1;
end

figure;
loglog(h_values, df_err_abs_fwd, '-o', h_values, df_err_abs_back, '-o', h_values, df_err_abs_centered, '-o', h_values, h_values, '--', h_values, h_values.^2, '--');
legend('Avanti', 'Indietro', 'Centrate');
xlabel('h');
ylabel('Errore assoluto');
title('Errore assoluto in funzione di h');

% 2. Si ripeta il punto 1 per l’approssimazione di f ′′(0) tramite lo schema delle differenze
% finite centrate.

d2f_approx_centered = zeros(1, length(h_values));
d2f_err_abs_centered = zeros(1, length(h_values));

i = 1;
for h=h_values
    d2f_approx_centered(i) = (f(target + h) - 2*f(target) + f(target - h)) / h^2;
    d2f_err_abs_centered(i) = abs(d2f_exact - d2f_approx_centered(i));
    
    i = i + 1;
end

figure;
loglog(h_values, d2f_err_abs_centered, '-o', h_values, h_values.^2, '--');
legend('Centrate');
xlabel('h');
ylabel('Errore assoluto');
title('Errore assoluto in funzione di h');
