function dom = coldiagdom(A, strict)
	if strcmp(strict, 'strict')
		dom = all(abs(diag(A)) .* 2 >= sum(abs(A))');
		return;
	end 
	
	if strcmp(strict, 'weak')
		dom = all(abs(diag(A)) .* 2 > sum(abs(A))');
		return;
	end

	error('Invalid argument: strict must be either "strict" or "weak"');
end