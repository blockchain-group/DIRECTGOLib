function y = Rotated_H_Ellip(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Rotated_H_Ellip.m
%
% Original source:
%  - https://www.sfu.ca/~ssurjano/rothyp.html
%
% Globally optimal solution:
%   f = 0
%   x = zeros(n, 1);
%
% Default variable bounds:
%   -65.536 <= x(i) <= 65.536, i = 1...n
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
    y.xl = @(i) -65.536; 
    y.xu = @(i) 65.536; 
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

d = length(x);
outer = 0;
for ii = 1:d
    inner = 0;
    for jj = 1:ii
        xj = x(jj);
        inner = inner + xj^2;
    end
    outer = outer + inner;
end
y = outer;
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end