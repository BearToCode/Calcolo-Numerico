% Si consideri il seguente problema di Cauchy:
% y′(t) = −√((10 y(t))/(10 + t)) t ∈ (0, 4),
% y(0) = 9.
% Utilizzando il metodo di Heun con passo h = 0.2, si riporti il valore calcolato di
% uNt , ovvero l’approssimazione di y(4), essendo tn = n*h per n = 0, . . . , Nt

f     = @(t, y) -sqrt((10 * y) / (10 + t));
t_max = 4;
y0    = 9;
h     = 0.2;

Nt = t_max / h;

[t_h, u_h] = heun(f, t_max, y0, h);

uNt = u_h(end);

disp(uNt);