clc
clear

n = 1000;
A = hilb(n);
B = rand(n);
x_exact = ones(1000, 1);
y_exact = ones(1000, 1);

b = A*x_exact;
c = B*y_exact;

x = A \ b;
y = B \ c;

err_rel_x = norm(x_exact - x) / norm(x_exact);
err_rel_y = norm(y_exact - y) / norm(y_exact);

res_nor_x = norm(b - A*x) / norm(b);
res_nor_y = norm(c - B*y) / norm(c);

fprintf("cond: x: %e, y: %e\n", cond(A), cond(B));
fprintf("err: x: %e, y: %e\n", err_rel_x, err_rel_y);
fprintf("nor: x: %e, y: %e\n", res_nor_x, res_nor_y);

