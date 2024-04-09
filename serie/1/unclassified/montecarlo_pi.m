clear
clc


r = 1;
N = 10000;
M = 0;
for n = 1:N
    x = rand(1);
    y = rand(1);

    if x^2 + y^2 <= 1
        M = M + 1;
    end
end

approx = 4 * (M / N)