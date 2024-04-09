%% 4.10
% Approssimare π utilizzando l'algoritmo di Archimede

iterations = 20;

% Caso monotona crescente

approx_asc = zeros(1, iterations);

a_n = sqrt(2);
for n = 2:iterations 
    a_n = sqrt(2) * sqrt(1 - sqrt(1 - 0.25 * a_n^2));
    approx_asc(n) = 2^n * a_n;
end

p_n = 2^n * a_n;

plot(1:iterations, approx_asc);
fprintf("Monotona crescente: \n iterations: %d, pi: %f\n", iterations, p_n);

%% 4.12

f = @(x) -sqrt(x.^2 - x)       .* (x < 0) + ...
    (-x.^2 + 2*x).*exp(1).^(-x) .* (x >= 0);
x = linspace(-10, 10, 100);
plot(x, f(x));

%% 4.13

K = 8;
n = 4;
my_mat = zeros(n, n);

for i = 1:n
    for j = 1:n
        my_mat(i, j) = 2 * i * j + K + 1;
    end
end

disp(my_mat)

%% 4.14
x = 3;
y = -2;

evaluation = atan(y/x) - sin(x*sqrt(abs(y))) ^ 2;
disp(evaluation);

%% 4.15
iterations = 100;

a = zeros(iterations);
r = @(K) 2.5 + mod(K, 2);
found = @(curr, prev) abs(curr - prev) < exp(1) - 3;
K = 9;

for n = 1:iterations
    if n == 1
        a(n) = 0.5;
    else
        prev = a(n-1);
        curr = r(K) * prev * (1 - prev);
        a(n) = curr;

        if found(curr, prev)
            fprintf("Found for iteration %d => %f", n, curr);
        end
    end
end

plot(1:iterations, a);


