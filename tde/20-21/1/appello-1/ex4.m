% Dato il sistema lineare A x = b, con A =
% 10 −1 0
% 0 3 5
% 2 4 1
% e b = (1 2 3)T , si
% consideri la sua risoluzione tramite il metodo della fattorizzazione LU con pivot-
% ing per righe (permutazione della seconda e terza riga). Si riportino gli elementi
% l21 = (L)21 e u33 = (U )33 dei fattori L ed U della matrice permutata e la terza com-
% ponente y3 del vettore ausiliario y associato alla soluzione del sistema triangolare
% inferiore che compare durante l’applicazione del metodo.

A = [10 -1 0; 0 3 5; 2 4 1];
b = [1; 2; 3];

[L, U, P] = lu(A);

y = fwsub(L, P*b);
x = bksub(U, y);

l21 = L(2, 1);
u33 = U(3, 3);
y3 = y(3);

fprintf('l21 = %f\n', l21);
fprintf('u33 = %f\n', u33);
fprintf('y3 = %f\n', y3);