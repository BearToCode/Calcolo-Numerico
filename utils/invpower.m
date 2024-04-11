function [lambda, x, iter, lambdavec] = invpower(A, tol, nmax, x0)
%% INVPOWER 
% metodo delle potenze inverse per la ricerca dell’autovalore di modulo massimo e dell’autovettore associato.
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
% lambda = autovalore di modulo minimo
% x = autovettore associato
% iter = numero di iterazioni
% lambdavec = vettore degli autovalori calcolati ad ogni iterazione
%             [ lambda0, lambda1, ..., lambda_iter ] dimensione (iter + 1) x 1

	warning('invpower - Controlla gli indici dei vettori!');

	if check()
		[rows, cols] = size(A);
		assert(rows == cols, 'A deve essere una matrice quadrata');
		eigs = eig(A);
		sorted_eigs = sort(eigs, 'ascend');
		assert(sorted_eigs(1) ~= sorted_eigs(2), 'A deve avere un autovalore minimo singolare');
	end

	y0 = x0 / norm(x0);
	lambda0 = y0' * A * y0;

	lambdavec = zeros(nmax + 1, 1);
	lambdavec(1) = lambda0;

	prev_y = y0;
	prev_lambda = lambda0;

	err = tol + 1;
	
	iter = 0;
	while err > tol && iter < nmax
		iter = iter + 1;
		
		x = A \ prev_y;
		y = x / norm(x);
		
		lambda = y' * A * y;
		
		err = abs(lambda - prev_lambda) / abs(lambda);
		prev_lambda = lambda;
		prev_y = y;
		lambdavec(iter + 1) = lambda;
	end

	lambdavec = lambdavec(1:iter + 1);

	if iter == nmax
		warning('invpower - numero massimo di iterazioni raggiunto');
	end
end