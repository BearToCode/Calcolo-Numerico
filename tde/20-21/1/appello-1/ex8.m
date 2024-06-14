% Il metodo delle corde approssima lo zero α di una funzione f(x) applicando la
% seguente iterata: ...
% dati x(0) e qc = (f(b) − f(a)) / (b − a) per α ∈ (a, b). Posti f(x) = e^x − 2, a = 0, b = 2 e
% x(0) = 2, si riporti il valore dell’iterata x(2) ottenuta applicando il metodo.

f = @(x) exp(x) - 2;
x0 = 2;
a = 0;
b = 2;

[xvect] = corde(a, b, x0, 2, 0, f);
disp(xvect)