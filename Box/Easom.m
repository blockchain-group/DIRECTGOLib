function y = Easom(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Easom.m
%
% Original source:
%  - http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO_files/Page1361.htm
%
% Globally optimal solution:
%   f = -1
%   x = [pi; pi]
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1...2
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
    y.xl = @(i) -100; 
    y.xu = @(i) +100; 
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = -cos(x(1))*cos(x(2))*exp(-(x(1) - pi)^2 - (x(2) - pi)^2);
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*pi;
end