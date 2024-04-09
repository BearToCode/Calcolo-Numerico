% Il metodo della fattorizzazione QR pu`o essere utilizzato per risolvere il sistema lin-
% eare Ax = b con A matrice quadrata non singolare. Esso consiste dei seguenti
% passaggi: 
% i) determinazione della fattorizzazione QR di A, ovvero A = Q R,
% con R triangolare superiore; 
% ii) determinazione del vettore ausiliario y = QT b;
% iii) soluzione di R x = y tramite l’algoritmo delle sostituzioni all’indietro. Posti
% A =
% 0 3 −1
% 0 0 2
% 7 −1 2
% 
% b = (1 4 5)T e sapendo che Q =
% 
% 0 1 0
% 0 0 1
% 1 0 0
%
% si determinino e si riportino: (R)33, (y)1 = y1 e (x)1 = x1.

clc; clear;

A = [+0 +3 -1; ...
     +0 +0 +2; ...
     +7 -1 +2;];

b = [1 4 5]';

Q = [0 1 0; ...
     0 0 1; ...
     1 0 0;];

R = Q \ A;
y = Q' * b;
x = R \ y;

R33 = R(3,3);
y1 = y(1);
x1 = x(1);

fprintf('R33 = %f\n', R33);
fprintf('y1 = %f\n', y1);
fprintf('x1 = %f\n', x1);
