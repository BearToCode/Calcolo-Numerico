clear; clc;

A = [+3 -1 +0;
     -1 +2 -1;
     +0 -1 +5;];

nmax = 3;
tol = 0;
x0 = ones(3,1);

eig_max = eigpower(A,tol,nmax,x0);
eig_min = invpower(A,tol,nmax,x0);

c = eig_max / eig_min;

disp(c);


