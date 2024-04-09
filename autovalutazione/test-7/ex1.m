clc; clear;

IM = rgb2gray(imread("ngc6543a.jpg"));
A = double(IM);
[m, n] = size(A);

size_uncompressed = m*n;

[U, S, V] = svd(A);

normF = @(X) sqrt(sum(sum(X.^2))); % = norm(A, "fro");
A_k = @(k) U(:,1:k)*S(1:k,1:k)*V(:,1:k)';

% A,B
k = 28;
A_28 = A_k(k);
err_rel_F = normF(A-A_28)/normF(A);
err_rel_2 = norm(A-A_28)/norm(A);
size_compressed = m*k + k + n*k;

comp = size_uncompressed/size_compressed;

fprintf("A,B\n");
fprintf("Relative error F: %f\n", err_rel_F);
fprintf("Relative error 2: %f\n", err_rel_2);
fprintf("Compression ratio: %f\n", comp);

% C, plot compression ratio for k = 1,2,...,500

k = 1:500;
comp = k.*(m+n+1)./(m*n);
plot(k, comp);
% Plot line for k = 313
hold on;
plot([313, 313], [0, 1], 'r');
hold off;

% D 