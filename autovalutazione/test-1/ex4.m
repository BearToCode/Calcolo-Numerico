clc
clear

n = 100;

c = @(k) n - abs(k);
a = @(i,j) c(i - j);

A = zeros(n,n);

for i = 1:n
    for j = 1:n
        A(i,j) = a(i,j);
    end
end

s_1 = sum(A(end, :));
s_2 = sum(A(n:n-1:end-1));
