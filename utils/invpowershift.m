function [lambda, x, iter] = invpowershift(A, mu, tol, nmax, x0)
	%% INVPOWER 
	% metodo delle potenze per la ricerca dell’autovalore di modulo massimo e dell’autovettore associato.
	% A = matrice quadrata
    % mu = shift
	% tol = tolleranza
	% nmax = numero massimo di iterazioni
	% x0 = vettore iniziale

	if check()
		[rows, cols] = size(A);
		assert(rows == cols, 'A deve essere una matrice quadrata');
	end

	n = size(A);
	n = n(1);

	M = A - mu * eye(n);

	y0 = x0 / norm(x0);
	lambda0 = y0' * A * y0;
	lambda = lambda0;

	prev_y = y0;
	prev_lambda = lambda0;
	
	err = tol + 1;

	iter = 0;
	while err > tol && iter < nmax
		iter = iter + 1;
		
		x = M \ prev_y;
		y = x / norm(x);
		
		lambda = y' * A * y;

		err = abs(lambda - prev_lambda) / abs(lambda);
		prev_lambda = lambda;
		prev_y = y;
	end

	if iter == nmax
		warning('invpowershift - numero massimo di iterazioni raggiunto');
	end
end