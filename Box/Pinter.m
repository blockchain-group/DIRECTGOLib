function y = Pinter(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Pinter.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_P.html
%
% Globally optimal solution:
%   f = 0
%   x(i) = 0, i = 1...n
%
% Default variable bounds:
%   -10 <= x(i) <= 10, i = 1...n
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
    y.xl = @(i) -10;
    y.xu = @(i) 10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
n = length(x);
sum1 = 0;
sum2 = 0;
sum3 = 0;
for ii = 1:n
    if ii == 1 
        aa = x(n);
        bb = x(ii + 1);
    elseif ii == n 
        aa = x(ii-1);
        bb = x(1);
    else
        aa = x(ii-1);
        bb = x(ii + 1);
    end
    A = aa*sin(x(ii)) + sin(bb);
    B = aa^2 - 2*x(ii) + 3*bb - cos(x(ii)) + 1;
	sum1 = sum1 + ii*x(ii)^2;
	sum2 = sum2 + 20*ii*(sin(A))^2;
    sum3 = sum3 + ii*log10(1+ii*B^2);
end
y = sum1 + sum2 + sum3;
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end