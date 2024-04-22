n = 10;

A = zeros(n, n);

for i = 1:n
    for j = 1:n
        if j >= i
            A(i, j) = 21 - i - j;
        end
    end
end

disp(A);

res_norm = 10^(-14);
err_rel = cond(A) * res_norm;

disp(err_rel);