clc; clear;

% 2. Si consideri la seguente famiglia di matrici:

A = @(x) [x  2  3 13;
          5 11 10  8;
          9  7  6 12;
          4 14 15  1;];

% Con α = 30, si effettui il calcolo degli autovalori di A(30) con la function qrbasic.
% Si riporti il numero di iterazioni necessario per giungere a convergenza imponendo
% una tolleranza pari a 10^−10

alpha = 30;
A_alpha = A(alpha);
tol = 10^-10;
nmax = 1000;

D1 = qrbasic(A_alpha, tol, nmax);

fprintf('Autovalori di A(30):\n');
disp(D1);

% Con la stessa tolleranza, ma α = −30, si effettui il calcolo degli autovalori di
% A(−30). Si riporti il numero di iterazioni necessario per giungere a convergenza, e
% si commenti il risultato ottenuto alla luce delle stime teoriche.

alpha = -30;
A_alpha = A(alpha);

D2 = qrbasic(A_alpha, tol, nmax);

fprintf('Autovalori di A(-30):\n');
disp(D2);

v1 = zeros(length(D1)-1, 1);
v2 = zeros(length(D1)-1, 1);

for i = 1:length(D1) - 1
    v1(i) = abs(D1(i+1)/D1(i));
end
V1 = max(v1);

for i = 1:length(D2) - 1
    v2(i) = abs(D2(i+1)/D2(i));
end
V2 = max(v2);

fprintf("Primo fattore di abbattimento per alpha = 30: %f\n", V1);
fprintf("Primo fattore di abbattimento per alpha = -30: %f\n", V2);