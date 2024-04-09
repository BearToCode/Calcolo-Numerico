clc
clear

S = 1e5;
n = 10;

iter(n, S)

function appr = iter(i, S)
    if i == 0
        appr = S;
        return;
    end

    prev = iter(i-1, S);
    appr = 0.5 * (prev + S / prev);
end