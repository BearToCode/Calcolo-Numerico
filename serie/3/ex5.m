clc; clear; close all;

%% 1. Caricare in memoria, in Matlab, una delle immagini del dataset di esempio 

image = imread('saturn.png');
image = rgb2gray(image);
imshow(image);
A = double(image);

[m, n] = size(A);
p = min(m, n);

[U,S,V] = svd(A);

%% 2. Si calcoli la SVD della matrice A utilizzando il comando Matlab svd, ottenendo così
% le matrici U ∈ Rm×m, S ∈ Rm×n, e V ∈ Rn×n tali che U*S*V^T = A. Definita ora A_k
% la matrice ridotta di rango k ≤ min{m, n} (per A a rango pieno) ottenuta troncando i
% fattori della SVD di A, si assembli tale matrice per il valore k = 10, per esempio.

k = 50;
A_k = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';

%% 3. Si confronti l’immagine cos`ı ottenuta con l’immagine di partenza. N.B.: per visualizzare
% Ak con il comando imshow `e necessario prima convertire Ak con il comando uint8.

compressed = uint8(A_k);
figure;
imshow(compressed);

figure;
loglog(1:p, diag(S), '-', 'LineWidth', 2);
hold on;
loglog([k k], [S(p,p) S(1, 1)], '--r', 'LineWidth', 2);
legend('Singular values', strcat('k = ', num2str(k)));

size_uncompressed = m*n;
size_compressed = m*k + k + n*k;
compression_ratio = size_uncompressed/size_compressed;

fprintf('Compression ratio with k=%d: %f\n', k, compression_ratio);

% ||A - A_k||_F / ||A||_F
rel_err = sqrt(sum(diag(S(k+1:end, k+1:end)).^2))/sqrt(sum(diag(S).^2));

fprintf('Relative error with k=%d: %dpercent\n', k, rel_err * 100);