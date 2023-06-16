function y = P3b(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   P3b.m
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
%   f* = -0.3888114342917279
%   x* = [3.0355671161060096; 5.0972639399376654]
%
% Default variable bounds:
%   10^(-5) <= x(i) <= 16, i = 1,...n
%   
% Problem Properties:
%   n  = 2;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) P3bc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

k1 = 0.09755988;
k2 = 0.99*k1;
k3 = 0.03919080;
k4 = 0.9*k3;
y = -(((k1*x(1))/((1 + k1*x(1))*(1 + k3*x(1))*(1 + k4*x(2)))) +...
    ((k2*x(2))/((1 + k1*x(1))*(1 + k2*x(2))*(1 + k4*x(2))))); 
end

function [c, ceq] = P3bc( x )
c   = sqrt(x(1)) + sqrt(x(2)) - 4;   
ceq = [];
end

function xl = get_xl(nx)
    xl = 10^(-5)*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 16*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -0.3888114342917279;
end

function xmin = get_xmin(~)
    xmin = [3.0355671161060096; 5.0972639399376654];
end