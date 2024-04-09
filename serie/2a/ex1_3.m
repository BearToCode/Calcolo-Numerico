clear
clc

% Un generatore di corrente genera una corrente I0 che fluisce nelle n 
% resistenze elettriche R1, R2, . . . Rn in parallelo.
% Nota la corrente I0, vogliamo calcolare le correnti Ik, 
% con k = 1, . . . , n, che fluiscono negli n rami. La tensione V ai 
% capi di ogni resistenza Rk segue la legge di Ohm:
% V = RkIk.
% Per ottenere le n equazioni che ci servono per risolvere il sistema,
% utilizziamo le leggi di Kirchhoff alle maglie e ai nodi dello schema 
% elettrico.
% Per la legge di Kirchhoff ai nodi otteniamo l’equazione:
% I0 = I1 + I2 + · · · + In;
% per la legge di Kirchhoff alle maglie, otteniamo le rimanenti 
% n − 1 equazioni Rk−1Ik−1 = RkIk con k = 2, .., n.

n = 20;
R_k = 1;
I_0 = 2;

R = ones(n, 1) .* R_k;
A = -diag(R) + diag(R(1:n-1), -1);
A(1,1:end) = 1;
b = zeros(n,1);
b(1) = I_0;

[L, U, P] = lu(A);
% Richiesta: verificare che il pivoting non è stato usato
assert(isequal(P, eye(n)), "E' stato usato pivoting!");

% Ai = b
y = fwsub(L, P*b);
i = bksub(U, y);

i_exact = ones(n,1) .* I_0 / n;
err_rel = norm(i_exact - i) / norm(i_exact);
res_norm = norm(b - A*i) / norm(b);
fprintf("err_rel: %e, res_norm: %e, cond: %f\n", err_rel, res_norm, cond(A));

% R_1 = 10^3
R(1) = 10^3;
A = -diag(R) + diag(R(1:n-1), -1);
A(1,1:end) = 1;
b = zeros(n,1);
b(1) = I_0;
[L, U, P] = lu(A);
y = fwsub(L, P*b);
i = bksub(U, y);
fprintf("cond2: %f\n", cond(A));



