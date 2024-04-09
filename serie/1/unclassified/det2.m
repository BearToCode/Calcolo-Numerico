function det = det2(A)
    [n, m] = size(A);
    if n == m
        if n == 2
            det = A(1,1)*A(2,2) - A(1,2)*A(2,1);
        else
            error("La matrice non è 2x2")
        end
    else
        error("La matrice non è quadrata")
    end
end