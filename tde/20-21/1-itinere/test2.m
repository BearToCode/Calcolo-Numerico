% Si consideri il seguente algoritmo: dati a0 ∈ R, positivo, e b0 = 1, si pongano
% a_n+1 = (a_n + b_n) / 2 e b_n+1 = sqrt(a_n + b_n) 
% per n = 0, 1, 2, . . .. Il valore Sn = π/2 * a_0 / b_n
% fornisce un’approssimazione di log(4 * a_0) per n “grande”. 
% Posto a_0 = 2500, si riporti il valore approssimato S4 ottenuto 
% applicando l’algoritmo precedente.

clc; clear;

S = s(10);
fprintf('S = %f\n', S);

function A = a(n)
	if n == 0
		A = 2500;
	else    
		A = (a(n-1) + b(n-1)) / 2;
	end
end

function B = b(n)
	if n == 0
		B = 1;
	else
		B = sqrt(a(n-1) * b(n-1));
	end
end

function S = s(n)
	S = (pi / 2) * a(0) / b(n);
end