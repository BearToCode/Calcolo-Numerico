function [lambda, x, iter, lambdavec] = eigpower(A, tol, nmax, x0)
%% EIGPOWER 
% metodo delle potenze per la ricerca dell’autovalore di modulo massimo e dell’autovettore associato.
%
% Input:
% 
% A = matrice quadrata
% tol = tolleranza
% nmax = numero massimo di iterazioni
% x0 = vettore iniziale
%
% Output:
%
% lambda = autovalore di modulo massimo
% x = autovettore associato
% iter = numero di iterazioni
% lambdavec = vettore degli autovalori calcolati ad ogni iterazione
%             [ lambda0, lambda1, ..., lambda_iter ] dimensione (iter + 1) x 1


	warning('invpower - Controlla gli indici dei vettori!');


	if check()
		[rows, cols] = size(A);
		assert(rows == cols, 'A deve essere una matrice quadrata');
		eigs = eig(A);
		sorted_eigs = sort(eigs, 'descend');
		assert(sorted_eigs(1) ~= sorted_eigs(2), 'A deve avere un autovalore dominante');
	end

	y0 = x0 / norm(x0);
	lambda0 = y0' * A * y0;

	lambdavec = zeros(nmax + 1, 1);
	lambdavec(1) = lambda0;
	
	prev_y = y0;
	prev_lambda = lambda0;
	
	iter = 0;
	while 1
		iter = iter + 1;

		x = A * prev_y;
		y = x / norm(x);

		lambda = y' * A * y;
		lambdavec(iter + 1) = lambda;
		
		if (abs(lambda - prev_lambda) < (tol * abs(lambda))) || (iter >= nmax)
			break;
		end

		prev_lambda = lambda;
		prev_y = y;
	end

	lambdavec = lambdavec(1:iter + 1);

	if iter == nmax
		warning('eigpower - numero massimo di iterazioni raggiunto');
	end
end