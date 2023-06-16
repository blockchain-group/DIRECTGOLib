function y = P8(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   P8.m
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
%   f* = -118.7048597749956969
%   x* = [-3.1735990999628472; 1.7245330473592981]
%
% Default variable bounds:
%   -8 <= x(1) <= 10;
%   0  <= x(2) <= 10;
%   
% Problem Properties:
%   n  = 2;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) P8c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = x(1)^4 - 14*x(1)^2 + 24*x(1) - x(2)^2;
end

function [c, ceq] = P8c( x )
c(1) = x(2) - x(1)^2 - 2*x(1) + 2;
c(2) = -x(1) + x(2) - 8;
ceq = [];
end

function xl = get_xl(~)
    xl = [-8; 0];
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -118.7048597749956969;
end

function xmin = get_xmin(~)
    xmin = [-3.1735990999628472; 1.7245330473592981];
end