function norm = normA(x, A)
% NORMA: norma dell'energia  
  assert(sdp(A), 'A deve essere una matrice sdp');
  norm = sqrt(x' * A * x);
end