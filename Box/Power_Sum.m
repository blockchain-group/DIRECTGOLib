function y = Power_Sum(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Power_Sum.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page670.htm
%
% Globally optimal solution:
%   f = 0
%   x = [1; 3; 2; 2]
%
% Default variable bounds:
%   0 <= x(i) <= 4, i = 1...n
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
    y.xl = @(i) 0;
    y.xu = @(i) 4;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

n = length(x);
b = [8, 18, 44, 114];
s_out = 0;
for k = 1:n
    s_in = 0;
    for j = 1:n
        s_in = s_in + x(j)^k;
    end
    s_out = s_out + (s_in - b(k))^2;
end
y = s_out;
end

function fmin = get_fmin(~)
    fmin = 0;
end

function xmin = get_xmin(~)
    xmin = [1; 3; 2; 2];
end