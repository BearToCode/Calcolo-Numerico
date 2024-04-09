function x = bksub(U, y)
% Solves Ux = y, where U is an upper triangular squared matrix
    [U_rows, U_cols] = size(U);
    [B_rows, B_cols] = size(y);
    n = U_rows;

    if check()
        assert(U_rows == U_cols, "U is not squared!");
        assert(B_rows == U_rows && B_cols == 1, "Invalid dimensions for U and y");
        assert(isequal(triu(U), U), "U is not upper triangular");
    end

    x = zeros(n, 1);

    x(n) = y(n)/U(n,n);

    for i = n:-1:1
        if check()
            assert(U(i,i) ~= 0, "U is singular");
        end

        x(i)= (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i,i);
    end
end