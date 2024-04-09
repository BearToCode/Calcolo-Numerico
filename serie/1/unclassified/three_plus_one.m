n0 = 7;

s = [];

n = n0;

while n > 1
    if mod(n, 2) == 0
        n = n / 2;
    else
        n = 3 * n + 1;
    end

    s = [s n];
end
s