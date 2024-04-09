function is_sdp = sdp(A)
    is_sdp = isequal(A', A) && all(eig(A) >= 0);
end