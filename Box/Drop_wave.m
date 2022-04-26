function y = Drop_wave(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Drop_wave.m
%
% Original source:
%  - http://www.sfu.ca/~ssurjano/
%
% Globally optimal solution:
%   f = -1
%   x(i) = [0; 0]
% 
% Default variable bounds:
%   -5.12 <= x(i) <= 5.12, i = 1...n
%   
% Problem Properties:
%   n  = 2;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -5.12; 
    y.xu = @(i) 5.12; 
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

frac1 = 1 + cos(12*sqrt(x(1)^2 + x(2)^2));
frac2 = 0.5*(x(1)^2 + x(2)^2) + 2;
y = -frac1/frac2;
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end