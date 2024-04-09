clc
clear

N = 10^6;
M = 0;

inside_circle = @(x, y) x^2 + y^2 < 1;

for i = 1:N
   x = rand();
   y = rand();

   if inside_circle(x, y)
       M = M + 1;
   end
end

S_n = 4*M/N;

fprintf("S_n: %f\n", S_n);