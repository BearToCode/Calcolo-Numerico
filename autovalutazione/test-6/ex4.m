clc; clear;

syms x

A = [9 x 0;
     x 1 0;
     0 0 2];

disp(eig(A));

%% Gershgorin Circles
close all;

A = [9 .5 0;
     .5 1 0;
     0 0 2];

gershcircles(A);

%% Gershgorin Circles
close all;

A = [9 5 0;
     5 1 0;
     0 0 2];

gershcircles(A);

