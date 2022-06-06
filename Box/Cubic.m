function y = Cubic(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Cubic.m
%
% Original source:
%  - Tavassoli, A., Haji Hajikolaei, K., Sadeqi, S., Wang, G. G., 
%    & Kjeang, E. (2014). Modification of DIRECT for high-dimensional 
%    design problems. Engineering Optimization, 46(6), 810–823. 
%    https://doi.org/10.1080/0305215X.2013.800057
%
% Globally optimal solution:
%   f = 0
%   x(i) = [0], i = 1...n
%
% Default variable bounds:
%   -4 <= x(i) <= 3, i = 1...n
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
    y.xl = @(i) -4; 
    y.xu = @(i) 3;
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
    s = s + j^3*((x(j) - 1)^2);
end
y = s^3;
end  

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end