function y = Rastrigin(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Rastrigin.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page2607.htm
%
% Globally optimal solution:
%   f = 0
%   x = zeros(n, 1);
%
% Default variable bounds:
%   -5.12 <= x(i) <= 5.12, i = 1...n
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
    y.xl = @(i) -5.12;  
    y.xu = @(i) 5.12; 
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
    s = s + (x(j)^2 - 10*cos(2*pi*x(j)));
end
y = 10*n + s;
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end