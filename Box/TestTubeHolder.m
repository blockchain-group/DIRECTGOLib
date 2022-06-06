function y = TestTubeHolder(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   TestTubeHolder.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_T.html
%
% Globally optimal solution:
%   f = -10.87229990155800
%   x = [-pi/2, 0]
%
% Default variable bounds:
%   -10 <= x(1) <= 10
%   -10 <= x(2) <= 10
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
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = -4*abs(sin(x(1))*cos(x(2))*exp(abs(cos((x(1)^2 + x(2)^2)/200))));
end 

function fmin = get_fmin(~)
    fmin = -10.87229990155800;
end

function xmin = get_xmin(~)
    xmin = [-pi/2; 0];
end