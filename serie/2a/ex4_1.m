clear
clc

% Confrontare i tempi di calcolo dei metodi LU, Thomas, e Cholesky sul 
% sistema lineare associato al sistema delle molle(3.1), facendo variare 
% il valore del parametro n che definisce la dimensione della matrice A 
% da n = 500 a n = 5000, con passo 500. Per quale valore di n le 
% differenze sono apprezzabili?
intervals = 500:500:5000;
times = zeros(10, 3);

i = 1;
for n = intervals
    fprintf("Running n=%d\n", n);
    [times(i, 1), times(i, 2), times(i, 3)] = sample(n);
    i = i + 1;
end

plot(times(:, 1), "-ob");
hold on
plot(times(:, 2), "-or");
plot(times(:, 3), "-og");
legend('LU', 'Thomas', 'Cholesky');
ylabel('Seconds');
xlabel('n/500');
hold off

function [t_lu, t_th, t_ch] = sample(n)
    N = n + 1;
    n = N - 1;
    L = 20; % [m]
    K = 100; % [N/m]
    
    A = diag(ones(n,1) .* -2) + ...
        diag(ones(n-1,1), -1) + ...
        diag(ones(n-1,1),  1);
    
    b = zeros(n,1);
    b(n) = K * L;
    
    % Risoluzione con metodo LU
    
    tic;
    [L, U, P] = lu(A);
    y = fwsub(L, P*b);  % Ly = Pb
    x_lu = bksub(U, y); % Ux = y
    t_lu = toc;
    
    
    % Risoluzione con Thomas
    
    tic
    [L, U, x_th] = thomas(A, b);
    t_th = toc;
    
    % Risoluzione con Cholesky
    
    tic
    A_tilde = -A;
    b_tilde = -b;
    H = chol(A_tilde);        % A = H'H
    y = fwsub(H', P*b_tilde); % H'y = Pb ?? FIXME: Perche' P?
    x_ch = bksub(H, y);       % Hx = y
    t_ch = toc;
end


