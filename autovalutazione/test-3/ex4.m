clc; clear;

n = 3;
A = [10^-6 10^6 1;
     1     0    1;
     1     1    1;];
e_m = 2^-52;

[L, U] = lu(A);

A_k = U;

max_start = 0;
for i = 1:n
	for j = 1:n
		if abs(A_k(i, j)) > max_start
			max_start = abs(A_k(i, j));
		end
	end
end

max_iter = 0;
for i = 1:n
	for j = 1:n
		if abs(A_k(i, j)) > max_iter
			max_iter = abs(A_k(i, j));
		end
	end
end

ep = 2^-52;

disp(8*n^3*ep*(max_iter/max_start));
