function y = Trid10(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Trid.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page2904.htm
%
% Globally optimal solution:
%   f = -n*(n + 4)*(n - 1)/6
%   x(i) = [i*(10 + 1 - i)], i = 1...n
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1...n
%   
% Problem Properties:
%   n  = 0;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -100;
    y.xu = @(i) +100;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

n = length(x);
s1 = 0;
s2 = 0;
for j = 1:n
    s1 = s1 + (x(j) - 1)^2;
end
for j = 2:n
    s2 = s2 + x(j)*x(j - 1);
end
y = s1 - s2;
end

function fmin = get_fmin(nx)
[~, fmin] = solve_trid(nx);
end

function xmin = get_xmin(nx)
[xmin, ~] = solve_trid(nx);
end

function [xmin,fmin] = solve_trid(nx)
A = zeros(nx, nx);
A(1, 1) = 2;
A(1, 2) = -1;
for i = 2:nx - 1
    A(i, i - 1) = -1;
    A(i, i) = 2;
    A(i, i + 1) = -1;
end
A(nx, nx - 1) = -1;
A(nx, nx) = 2;
b = 2*ones(nx, 1);
xmin = A \ b;
fmin = get_y(xmin);
end

function y = get_y(x)
n = length(x);
s1 = 0;
s2 = 0;
for j = 1:n
    s1 = s1 + (x(j) - 1)^2;
end
for j = 2:n
    s2 = s2 + x(j)*x(j - 1);
end
y = s1 - s2;
end