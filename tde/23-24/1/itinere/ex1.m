b = 2;
x = sqrt(pi);

syms t;
eps_F = b^(1-t);

tol = 10^(-12);

sol_ex = solve(tol == 0.5 * eps_F * x);
sol = ceil(sol_ex);

disp(sol);
