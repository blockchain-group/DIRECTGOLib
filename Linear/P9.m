function y = P9(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   P9.m
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
% Test problem P09 after reformulation contains 3 variables and 9 
% inequality constraints. In the original problem formulation there were 6 
% variables, 3 equality and 3 inequality constraints.
%
% Globally optimal solution:
%   f* = -13.4019035550508185
%   x* = [1/6; 2; 4] 
%
% Default variable bounds:
%   10^(-5) <= x(1) <= 3;
%   10^(-5) <= x(2, 3) <= 4;
%   
% Problem Properties:
%   n  = 3;
%   #g = 9;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 9;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = x(1)^(0.6) + x(2)^(0.6) + x(3)^(0.4) -...
    (3/2)*x(3) + 2*x(1) - (17/3)*x(2); 
end

function [c, ceq] = funcon( x )
    c(1) = -4*x(1) + (4/3)*x(2) - 6; 
    c(2) = -x(2) + (1/2)*x(3) - 2; 
    c(3) = -x(1) + (1/3)*x(2) - 2; 
    c(4) = x(1) + 2*(-x(1) + (1/3)*x(2)) - 4; 
    c(5) = x(2) + (-x(2) + (1/2)*x(3)) - 4; 
    c(6) = x(3) + (-4*x(1) + (4/3)*x(2)) - 6; 
    c(7) = -(-4*x(1) + (4/3)*x(2)); 
    c(8) = -(-x(2) + (1/2)*x(3)); 
    c(9) = -(-x(1) + (1/3)*x(2)); 
    ceq = [];
end

function xl = get_xl(nx)
    xl = 10^(-5)*ones(nx, 1);
end

function xu = get_xu(~)
    xu = [3; 4; 4];
end

function fmin = get_fmin(~)
    fmin = -13.4019035550508185;
end

function xmin = get_xmin(~)
    xmin = [1/6; 2; 4];
end