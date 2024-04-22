x0 = 1;

N = 100;
xvect = zeros(N, 1);
xvect(1) = x0;

for i = 1:N-1
    xvect(i+1) = 1/2 * (xvect(i) + 15/xvect(i));
end

disp(xvect(end));

stimap(xvect);