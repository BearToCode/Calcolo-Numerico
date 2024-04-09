function [lambda, x, iter, lambda_vect] = eigpower(A, tol, nmax, x0)
  	%% EIGPOWER 
  	% metodo delle potenze per la ricerca dell’autovalore di modulo massimo e dell’autovettore associato.
  	% A = matrice quadrata
  	% tol = tolleranza
  	% nmax = numero massimo di iterazioni
  	% x0 = vettore iniziale

	if check()
		[rows, cols] = size(A);
		assert(rows == cols, 'A deve essere una matrice quadrata');
		eigs = eig(A);
		sorted_eigs = sort(eigs, 'descend');
		assert(sorted_eigs(1) ~= sorted_eigs(2), 'A deve avere un autovalore dominante');
	end

	y0 = x0 / norm(x0);
	lambda0 = y0' * A * y0;

	prev_y = y0;
	prev_lambda = lambda0;
	lambda_vect = zeros(nmax, 1);
	
	iter = 0;
	while 1
		iter = iter + 1;

		x = A * prev_y;
		y = x / norm(x);

		lambda = y' * A * y;
		lambda_vect(iter) = lambda;
		
		if (abs(lambda - prev_lambda) < (tol * abs(lambda))) || (iter >= nmax)
			break;
		end

		prev_lambda = lambda;
		prev_y = y;
	end

	lambda_vect = lambda_vect(1:iter);

	if iter == nmax
		warning('eigpower - numero massimo di iterazioni raggiunto');
	end
end