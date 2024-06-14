% Dato il sistema lineare A x = b, con A =
% 4 6 2 1
% 2 3 −1 1
% 2 1 2 1
% 1 1 1 1
% 
% e b = (1 2 3 4)T , si
% consideri la sua risoluzione tramite il metodo della fattorizzazione LU con pivoting
% per riga. Si riportino il valore dell’ultima componente della soluzione (x)4 e gli
% indici delle righe di A che sono state permutate.

A = [4 6 2 1; 
     2 3 -1 1;
     2 1 2 1; 
     1 1 1 1];
b = [1; 2; 3; 4];

[L, U, P] = lu(A);

y = fwsub(L, P * b);
x = bksub(U, y);

x4 = x(4);

disp(P);

fprintf("L'ultima componente della soluzione è %f\n", x4);