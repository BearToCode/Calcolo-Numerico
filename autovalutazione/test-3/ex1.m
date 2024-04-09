clc; clear;

n = 100;
A = zeros(n, n);

for i = 1:n
  A(i, i) = 2;
end

for i = 1:n-1
  A(i, i+1) = -1;
end

A(n, 1) = 1;
A = sparse(A);

b = ones(n, 1);

[L, U, P, Q] = lu(A);
y = fwsub(L, P*b);
z = bksub(U, y);
x = Q * z;

l21 = full(L(2, 1));
yn = full(y(n));
zn = full(z(n));

assert(all(abs(x - A \ b) < 1e5));

fprintf('l21 = %f\n', l21);
fprintf('yn = %f\n', yn);
fprintf('zn = %f\n', zn);