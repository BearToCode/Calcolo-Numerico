function [ X, Y, U ] = Poisson_Dirichlet_diff_finite_5punti( mu, f, g, Omega, hx, hy )
%
% Schema alle differenze finite a 5 punti per l'approssimazione del 
% problema di Poisson-Dirichlet a coefficienti costanti in un 
% dominio rettangolare  
%
% - \mu u''(x,y) = f(x,y)   (x,y) \in \Omega = ( a, b ) x ( c, d )
% u(x,y) = g(x,y)           (x,y) \in \partial \Omega
%
% Inputs: 
%        mu = coefficiente diffusione/elastico, mu \in R, mu > 0
%         f = funzione inline o function per termine forzante,  f = f(x,y)
%         g = funzione inline o function per dato di Dirichlet, g = g(x,y)
%     Omega = [ a, b, c, d ] limiti dominio rettangolare
%        hx = ampiezza elementi griglia in direzione x
%        hy = ampiezza elementi griglia in direzione x
% 
% Outputs: 
%      X, Y = matrici contenenti coordinate dei nodi della griglia
%         U = matrice contenente la soluzione approssimata nei nodi
%
% L. Dede', MOX - Politecnico di Milano, 25 Maggio 2020
%

% Griglia computazionale
x0 = Omega( 1 );    xNxp1 = Omega( 2 );
Nx = round( ( xNxp1 - x0 ) / hx ) - 1;
xnodes = linspace( x0, xNxp1, Nx + 2 );
hx = ( xNxp1 - x0 ) / ( Nx + 1 );

y0 = Omega( 3 );    yNyp1 = Omega( 4 );
Ny = round( ( yNyp1 - y0 ) / hy ) - 1;
ynodes = linspace( y0, yNyp1, Ny + 2 );
hy = ( yNyp1 - y0 ) / ( Ny + 1 );

% Assemblaggio matrice e vettore
dim = ( Nx + 2 ) * ( Ny + 2 ); 
A = speye( dim, dim );
b = zeros( dim, 1 );

for m = 2 : Ny + 1    
    for n = 2 : Nx + 1
        i = n + ( m - 1 ) * ( Nx + 2 );
        A( i, i ) = mu * ( 2 / hx^2 + 2 / hy^2 );
        A( i, i + 1 ) = - mu * ( 1 / hx^2 );
        A( i, i - 1 ) = - mu * ( 1 / hx^2 );
        A( i, i + ( Nx + 2 ) ) = - mu * ( 1 / hy^2 );
        A( i, i - ( Nx + 2 ) ) = - mu * ( 1 / hy^2 );
        b( i ) = f( xnodes( n ), ynodes( m ) );        
    end
end

% condizioni al bordo
ub = zeros(  dim, 1 );
ub( 1 : Nx + 2 ) = g( xnodes, ynodes( 1 ) ); 
ub( dim - Nx - 1 : dim ) = g( xnodes, ynodes( end ) ); 
ub( 1 : Nx + 2 : dim - Nx - 1 ) = g( xnodes( 1 ), ynodes ); 
ub( Nx + 2 : Nx + 2 : dim ) = g( xnodes( end ), ynodes );  

b = b - A * ub;

nbound = [ ( 1 : Nx + 2 ), ( dim - Nx - 1 : dim ), ...
           ( 1 : Nx + 2 : dim - Nx - 1  ), ( Nx + 2 : Nx + 2 : dim ) ];
ninternal = setdiff( 1 : dim, nbound );

% soluzione sistema lineare e assegnamento soluzione
A = A( ninternal, ninternal );
b = b( ninternal );

u = ub;
u( ninternal ) = A \ b;

% output
i = 1;
X = zeros( Nx + 2, Ny + 2 );
Y = X;
U = X;
for m = 1 : Ny + 2
    for n = 1 : Nx + 2
        X( n, m ) = xnodes( n );
        Y( n, m ) = ynodes( m );
        U( n, m ) = u( i );
        i = i + 1;
    end
end

end