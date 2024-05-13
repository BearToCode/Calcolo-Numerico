function [y_i] = cubicspline(x_nod, y_nod, x_i)
%
% [y_i] = cubicspline(x_nod, y_nod, x_i)
% 
% Interpolazione con Spline Cubica Naturale.
% Input: 
%   x_nod, y_nod :  ascisse e ordinate dei nodi di interpolazione
%   x_i          :  ascisse in cui si vuole valutare la spline
% Output:
%   y_i          :  ordinate della spline in corrispondenza di x_i        

SP_nat = csape(x_nod, y_nod, 'variational');
y_i    = fnval(SP_nat, x_i);
