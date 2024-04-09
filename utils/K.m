function spectral_conditioning = K(A)
  % K(A) = max(|lambda_i|) / min(|lambda_i|)
  spectral_conditioning = max(abs(eig(A))) / min(abs(eig(A)));
end