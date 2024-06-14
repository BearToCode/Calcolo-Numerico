% Il metodo delle secanti approssima lo zero α di una funzione f (x) applicando la
% seguente iterata: ...
% Posti f (x) = 2 log(x^2 + 1) − 1, x(0) = 0 e x(1) = 2, si riporti il valore 
% dell’iterata x(3) ottenuta applicando il metodo.

x0 = 0;
x1 = 2;
f = @(x) 2*log(x^2 + 1) - 1;

[xvect] = secanti(x0, x1, 3, 0, f);

disp(xvect);