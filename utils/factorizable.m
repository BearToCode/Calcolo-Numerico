function is_factorizable = factorizable(A)
% Verifica che una matrice sia fattorizzabile

% Data una matrice A ∈ Rn×n non–singolare, la sua fattorizzazione LU esiste
% ed è unica se e solo se det(Ai) != 0 per ogni i = 1, . . . , n − 1
% (ovvero tutte le sottomatrici principali di A di ordine i, 
% con 1 ≤ i ≤ n − 1, sono non–singolari).

    if check()
        [rows, cols] = size(A);
        assert(rows == cols, "La matrice deve essere quadrata");
        assert(det(A) ~= 0, "La matrice deve essere non singolare");
    end

    % Controllo condizioni sufficienti
    % A simmetrica e definita positiva
    if isequal(A, A') && all(eig(A) > 0)
        is_factorizable = true;
        return;
    end

    % A dominanza diagonale stretta per righe
    if rowdiagdom(A, 'strict')
        is_factorizable = true;
        return;
    end

    % A dominanza diagonale stretta per colonne
    if coldiagdom(A, 'strict')
        is_factorizable = true;
        return;
    end

    % Caso generale
    [A_size] = size(A);
    for i = 1:A_size-1
        if det(A(1:i, 1:i)) == 0
            is_factorizable = false;
            return;
        end
    end

    is_factorizable = true;
end