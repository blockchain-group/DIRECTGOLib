function y = Dejong(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Dejong.m
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
%   -3 <= x(i) <= 7, i = 1...n
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
    y.xl = @(i) -3; 
    y.xu = @(i) 7;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
n = length(x);
s = 0;
for j = 1:n
    s = s+x(j)^2;
end
y = s;
end 

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end