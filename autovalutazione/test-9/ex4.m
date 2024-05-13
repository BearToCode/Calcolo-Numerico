f = @(x) 1 + x;

n_half = 1;

I = clenshawcurtis(n_half, f);

disp(I);