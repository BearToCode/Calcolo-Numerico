function [L, U, x] = thomas(A, b)
    [A_rows, A_cols] = size(A);
    [B_rows, B_cols] = size(b);
    
    if check()
        assert(A_rows == A_cols, 'A deve essere quadrata');
        assert(B_cols == 1, 'b deve essere un vettore colonna');
        assert(A_rows == B_rows, 'A e b devono avere lo stesso numero di righe');
        assert(isequal(A, tril(A, 1)), 'A deve essere tridiagonale');
        assert(isequal(A, triu(A, -1)), 'A deve essere tridiagonale');
        assert(factorizable(A), 'A non è fattorizzabile')
    end

    n = A_rows;

    % Estraggo diagonali da A
    a_diag = diag(A);
    c_diag = diag(A, 1);
    e_diag = diag(A, -1);

    % Calcolo alpha e delta e construisco L e U
    alpha = zeros(n, 1);
    delta = zeros(n-1, 1);
    alpha(1) = a_diag(1);
    for i = 2:n
        delta(i-1) = e_diag(i-1) / alpha(i-1);
        alpha(i) = a_diag(i) - delta(i-1) * c_diag(i-1);
    end

    L = eye(n) + diag(delta, -1);
    U = diag(alpha) + diag(c_diag, 1);

    % Calcolo x
    y = zeros(n, 1);
    y(1) = b(1);
    for i = 2:n
        y(i) = b(i) - delta(i-1) * y(i-1);
    end
    
    x = zeros(n, 1);
    x(n) = y(n) / alpha(n);

    for i = n-1:-1:1
        x(i) = (y(i) - c_diag(i) * x(i+1)) / alpha(i);
    end
end