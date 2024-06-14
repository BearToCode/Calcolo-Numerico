% Si consideri la matrice A =
% [ 3 1;
%   2 8 ] 
% e il metodo della fattorizzazione QR per
% l’approssimazione dei suoi autovalori λ1 e λ2. Si applichino 3 iterazioni del metodo
% e si riportino le approssimazioni λ(3)_1 e λ(3)_2 cos`ı ottenute.

A = [ 3 1; 2 8 ];

[D] = qrbasic(A, 0, 3);
disp(D);