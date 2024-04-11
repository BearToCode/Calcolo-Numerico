function D = qrbasic(A, tol, nmax)

    if check()
        [rows, cols] = size(A);
        assert(rows == cols, 'A deve essere quadrata');
    end

    A_k = A;
    iter = 0;
    err = tol + 1;

    while err > tol && iter < nmax
        iter = iter + 1;

        [Q, R] = qr(A_k);
        A_k = R * Q;

        err = max(max(abs(tril(A_k, -1))));
        % fprintf('Iterazione %d, errore = %e\n', iter, err);
    end

    if iter == nmax
        warning('qrbasic - numero massimo di iterazioni raggiunto');
    end

    D = diag(A_k);
end