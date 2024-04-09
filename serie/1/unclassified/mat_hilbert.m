function mat = mat_hilbert(size)
    mat = zeros(size, size);

    for i = 1:size
        for j = 1:size
            mat(i, j) = 1 / (i + j - 1);
        end
    end
end