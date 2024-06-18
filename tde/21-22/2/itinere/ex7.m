clear; clc;

% Si consideri il seguente problema di Cauchy:
% y′(t) = − 1/81 (1 + sin(t)) (y(t))2 t ∈ (0, 5),
% y(0) = 9.
% Utilizzando il metodo di Eulero all’indietro basato sul metodo di Newton imple-
% mentato nella funzione eulero indietro newton.m e passo h = 0.2, si riporti il
% valore calcolato di uNt , ovvero l’approssimazione di y(5), essendo tn = n h per
% n = 0, . . . , Nt.


f  = @(t, y) -1/81 * (1 + sin(t)) * y^2;
y0 = 9;
tf = 5;
h  = 0.2;

df_du = @(t, y) -2/81 * (1 + sin(t)) * y;

[t,u] = eulerbkw_newton(f, df_du, tf, y0, h);

uNt = u(end);

disp(uNt); % 5.5989