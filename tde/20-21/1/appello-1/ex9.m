% Si consideri la funzione di iterazione φ(x) = cos(x). Si applichi il metodo delle
% iterazioni di punto fisso partendo dall’iterata iniziale x(0) = 0.9. Si riporti il valore
% dell’iterata x(3) cos`ı ottenuta.

phi = @(x) cos(x);
x0 = 0.9;

[succ] = ptofis(x0, phi, 3, 0, -1, 1);
disp(succ);