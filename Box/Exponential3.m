function [y] = Exponential3(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Exponential3.m
%
% Original source:
%  - Molga, M., and C. Smutnicki. 2005. “Test Functions for Optimization 
%    Needs." Accessed February 5, 2013.
%    http://www.zsd.ict.pwr.wroc.pl/files/docs/functions.pdf
%
% Globally optimal solution:
%   f = 0
%   x(i) = [0], i = 1...n
%
% Default variable bounds:
%   -30 <= x(i) <= 20, i = 1...n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -30; 
    y.xu = @(i) 20;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
d = length(x);
sum1 = 0;
sum2 = 0;
for ii = 1:d
	xi = x(ii);
	sum1 = sum1 + xi^2;
	sum2 = sum2 + cos(2*pi*xi);
end
term1 = -20 * exp(-0.2*sqrt(sum1/d));
term2 = -exp(sum2/d);
y = term1 + term2 + 20 + exp(1);
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end