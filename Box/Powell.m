function y = Powell(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Powell.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page2720.htm
%
% Globally optimal solution:
%   f = 0
%   x = zeros(4, 1);
%
% Default variable bounds:
%   -4 <= x(i) <= 4, i = 1...n
%   
% Problem Properties:
%   n  = 4;
%   #g = 0;
%   #h = 0;
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(i) -4;
    y.xu = @(i) +4;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

d = length(x);
sum = 0;

for ii = 1:(d/4)
	term1 = (x(4*ii - 3) + 10*x(4*ii - 2))^2;
	term2 = 5 * (x(4*ii - 1) - x(4*ii))^2;
	term3 = (x(4*ii - 2) - 2*x(4*ii - 1))^4;
	term4 = 10 * (x(4*ii-3) - x(4*ii))^4;
	sum = sum + term1 + term2 + term3 + term4;
end

y = sum;
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(nx)
    xmin = zeros(nx, 1);
end