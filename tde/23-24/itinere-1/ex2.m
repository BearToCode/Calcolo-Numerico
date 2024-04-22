n = 30;
n_systems = 50;

% A bidiagonale superiore => sosti indietro di Thomas

flops_sol = 3 * (n-1) + 1;

flops = n_systems * flops_sol;
disp(flops);