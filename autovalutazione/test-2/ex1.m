clc
clear

exact = exp(2);
appr = 0;
err = abs(exact - appr);

n = 1;
while err >= 10^-1
    appr = appr_exp(2, n);
    err = abs(exact - appr);
    
    fprintf("%d: err=%f, value=%f, exact=%f\n", n, err, appr, exact);
    n = n + 1;
end



function appr = appr_exp(x, n)
    appr = 1;
    for k = 1:n
        appr = appr + x^k / factorial(k);
    end
end