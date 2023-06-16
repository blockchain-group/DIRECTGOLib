function y = P7(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   P7.m
%
% Original source: 
% - Christodoulos A. Floudas, Panos M. Pardalos, Claire S. Adjiman, 
%   William R. Esposito, Zeynep H. Gumus, Stephen T. Harding, 
%   John L. Klepeis, Clifford A. Meyer, Carl A. Schweiger. 1999. Handbook 
%   of Test Problems in Local and Global Optimization. Nonconvex 
%   Optimization and Its Applications, Vol. 33. Springer Science Business 
%   Media, B.V. https://doi.org/10.1007/978-1-4757-3040-1
%
% Globally optimal solution:
%   f* = -2.8284271047
%   x* = [-1.4142141971953714; -1.4142129275505337]
%
% Default variable bounds:
%   -2 <= x(i) <= 2, i = 1,...n
%   
% Problem Properties:
%   n  = 2;
%   #g = 4;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 4;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) P7c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = x(1) + x(2); 
end

function [c, ceq] = P7c( x )
c(1) = -x(1) + x(2) - 1; 
c(2) = x(1) - x(2) - 1;
c(3) = -x(1)^2 - x(2)^2 + 1;
c(4) = x(1)^2 + x(2)^2 - 4; 
ceq = [];
end

function xl = get_xl(nx)
    xl = -2*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 2*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -2.8284271247459052;
end

function xmin = get_xmin(~)
    xmin = [-1.4142141971953714; -1.4142129275505337];
end