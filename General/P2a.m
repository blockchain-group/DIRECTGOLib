function y = P2a(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   P2a.m
%
% Original source: 
% - Christodoulos A. Floudas, Panos M. Pardalos, Claire S. Adjiman, 
%   William R. Esposito, Zeynep H. Gumus, Stephen T. Harding, 
%   John L. Klepeis, Clifford A. Meyer, Carl A. Schweiger. 1999. Handbook 
%   of Test Problems in Local and Global Optimization. Nonconvex 
%   Optimization and Its Applications, Vol. 33. Springer Science Business 
%   Media, B.V. https://doi.org/10.1007/978-1-4757-3040-1
%
% Problem have been reformulated by some algebraic manipulation aiming to 
% reduce the number of variables and equality constraints.
% - Costa, M. F. P., Rocha, A. M. A. C., & Fernandes, E. M. G. P.  
%   Filter-based DIRECT method for constrained global optimization. 
%   Journal of Global Optimization, 71(3), 517–536. (2018) 
%
% Test problem P2a after reformulation contain 5 variables and 10 
% inequality constraints. In the original problem formulation there were 
% 9 variables, 4 equality and 2 inequality constraints.
%
% Globally optimal solution:
%   f* = -400
%   x* = [0; 100; 1; 0; 100]
%
% Default variable bounds:
%   0 <= x(i) <= 500, i = 1,...n
%   
% Problem Properties:
%   n  = 5;
%   #g = 10;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 5;
    y.ng = 10;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) P2ac(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -9*(x(4) + x(1)) - 15*(x(5) + x(2)) + 6*(((x(3)*x(4) +...
    x(3)*x(5) - x(4) - x(5))/2)) + 16*(x(4) + x(5) - ((x(3)*x(4) +...
    x(3)*x(5) - x(4) - x(5))/2)) + 10*(x(1) + x(2)); 
end

function [c, ceq] = P2ac( x )
c(1) = x(4) + x(1) - 100;
c(2) = -(x(4) + x(1));
c(3) = x(5) + x(2) - 200;
c(4) = -(x(5) + x(2));
c(5) = x(3)*x(5) + 2*x(2) - 1.5*(x(5) + x(2));
c(6) = x(3)*x(4) + 2*x(1) - 2.5*(x(4) + x(1));
c(7) =((x(3)*x(4) + x(3)*x(5) - x(4) - x(5))/2);
c(8) = -((x(3)*x(4) + x(3)*x(5) - x(4) - x(5))/2);
c(9) = x(4) + x(5) - ((x(3)*x(4) + x(3)*x(5) - x(4) - x(5))/2) - 500;
c(10) = -(x(4) + x(5) - ((x(3)*x(4) + x(3)*x(5) - x(4) - x(5))/2));
ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 500*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -400;
end

function xmin = get_xmin(~)
    xmin = [0; 100; 1; 0; 100];
end