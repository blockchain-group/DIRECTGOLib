function y = zecevic3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   zecevic3.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 97.3094501419674316
%   x* = [2.7955451883416216; 1.0885435682323457]
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...,n
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
    y.confun = @(i) zecevic3c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 7*x(1)^2 + 3*x(2)^2 - 84*x(1) - 24*x(2) + 300;
end

function [Ineq, eq] = zecevic3c(x)
    Ineq(1) = -x(1)*x(2) + 1;  
    Ineq(2) = x(1)^2+x(2)^2 - 9; 
    eq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 97.3094501419674316;
end

function xmin = get_xmin(~)
    xmin = [2.7955451883416216; 1.0885435682323457];
end