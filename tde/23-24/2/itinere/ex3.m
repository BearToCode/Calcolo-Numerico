clear; clc;

syms a x;

f(x) = 2 * (a - 4*x^2);
I = [1,5];

% 40 intervalli equispaziati

nodes = linspace(I(1), I(2), 41);
a = nodes(1);
b = nodes(end);
H = nodes(2) - nodes(1);


df_sym = diff(f, x, 2);

% Determino il massimo valore assunto da df_sym in [a b]

% df_sym = -16 => max_df_sym = 16;

max_df = 16;

err = H^2 / 8 * max_df;

disp(err);