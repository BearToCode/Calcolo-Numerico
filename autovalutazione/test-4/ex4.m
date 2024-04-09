A = [3  -1;...
     -1  2;];

b = ones(2, 1);

syms x

P = [x -1;
     0  2;];

B = P^-1 * (P-A);

disp(eig(B));