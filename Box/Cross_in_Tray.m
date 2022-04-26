function y = Cross_in_Tray(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Cross_in_Tray.m
%
% Original source:
%  - https://www.sfu.ca/~ssurjano/crossit.html
%
% Globally optimal solution:
%   f = -2.0626118708227392 
%   x(i) = [1.3494066; 1.3494066]
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...2
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
    y.xl = @(i) -10;
    y.xu = @(i) 10;
    y.fmin = @(i) -2.0626118708227392;
    y.xmin = @(i) 1.3494066;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

fact1 = sin(x(1))*sin(x(2));
fact2 = exp(abs(100 - sqrt(x(1)^2 + x(2)^2)/pi));
y = -0.0001*(abs(fact1*fact2) + 1)^0.1;
end

function fmin = get_fmin(~)
    fmin = -2.0626118708227392;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*1.3494066;
end