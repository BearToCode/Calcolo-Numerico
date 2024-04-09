clear
clc


A = [50 1  3;
     1  6  0;
     3  0  1;];

B = [50 1  10;
     3  20 1 ;
     10 4  70;];

C = [7 8 9;
     5 4 3;
     1 2 6;];

A_factorizable = factorizable(A);
B_factorizable = factorizable(B);
C_factorizable = factorizable(C);

assert(A_factorizable, "A is not factorizable!");
assert(B_factorizable, "B is not factorizable!");
assert(C_factorizable, "C is not factorizable!");

[LA, UA] = lu(A);
[LB, UB] = lu(B);
[LC, UC] = lu(C);

% In questo caso non c'è bisogno di Pivoting
assert(isequal(A - LA*UA, zeros(size(A))), "Wrong factorization for A");
assert(isequal(B - LB*UB, zeros(size(B))), "Wrong factorization for B");
assert(isequal(C - LC*UC, zeros(size(C))), "Wrong factorization for C");

fwsub(LA, [1; 2; 3]);
bksub(UA, [1; 2; 3]);

% 1.4
x_exact = [1 1 1]';
b = A * x_exact;
[LA, UA] = lu(A);
y = fwsub(LA, b); % ATTENZIONE: se c'è pivoting usare fwsub(LA, P*b)
x = bksub(UA, y);

% 1.5
e_rel = norm(x_exact - x) / norm(x_exact);
res_norm = norm(b - A*x) / norm(b);
fprintf("e_rel: %e, res_norm: %e", e_rel, res_norm);



