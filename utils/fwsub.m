function y = fwsub(L, b)
% Solves Ly = b, where L is a lower triangular squared matrix
    [L_rows, L_cols] = size(L);
    [B_rows, B_cols] = size(b);
    n = L_rows;

    if check()
        assert(L_rows == L_cols, "L is not squared!");
        assert(B_rows == L_rows && B_cols == 1, "Invalid dimensions for L and b");
        assert(isequal(tril(L), L), "L is not lower triangular");
    end

    y = zeros(n, 1);

    for i = 1:n
        if check()
            assert(L(i,i) ~= 0, "L is singular!");
        end

        y(i) = (b(i) - L(i,1:i-1) * y(1:i-1)) / L(i,i);
    end
end