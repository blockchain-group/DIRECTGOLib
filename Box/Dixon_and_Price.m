function y = Dixon_and_Price(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Dixon_and_Price.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page1240.htm
%
% Globally optimal solution:
%   f = 0
%   x(i) = [2^(-((2^i - 2)/(2^i)))] i = 1...n;
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
    y.xu = @(i) +10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

n = length(x);
s1 = 0;
for j = 2:n
    s1 = s1 + j*(2*x(j)^2 - x(j - 1))^2;
end
y = s1 + (x(1) - 1)^2;
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
xmin = ones(nx, 1);
for i = 1:nx
    xmin(i) = 2^(-((2^i - 2)/(2^i)));
end
end