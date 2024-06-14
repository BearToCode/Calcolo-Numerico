clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = − 1/81 (1 + sin(t)) (y(t))2 t ∈ (0, 5),
% y(0) = 9.
% Utilizzando il metodo di Eulero all’indietro basato sul metodo di Newton imple-
% mentato nella funzione eulero indietro newton.m e passo h = 0.2, si riporti il
% valore calcolato di uNt , ovvero l’approssimazione di y(5), essendo tn = n h per
% n = 0, . . . , Nt

syms t u

symf = -1/81 * (1 + sin(t)) * u^2;
symdf_du = diff(symf, u);

f = matlabFunction(symf);
df_du = matlabFunction(symdf_du);

t_max = 5;
u0 = 9;
dt = 0.2;

[t, u] = eulerbkw_newton(f, df_du, t_max, u0, dt);

disp(u(end));