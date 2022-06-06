function y = Giunta(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Giunta.m
%
% Original source:
%  - http://infinity77.net/global_optimization/test_functions_nd_G.html
%
% Globally optimal solution:
%   f = 0.06447042053690566
%   x = [0.4673200277395354, 0.4673200169591304]
%
% Default variable bounds:
%   -1 <= x(1) <= 1
%   -1 <= x(2) <= 1
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
    y.xl = @(i) -1;
    y.xu = @(i) 1;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
arg = 16*x/15 - 1;
y = 0.6 + sum(sin(arg) + sin(arg).^2 + sin(4*arg)/50, 1);
end 

function fmin = get_fmin(~)
    fmin = 0.06447042053690566;
end

function xmin = get_xmin(~)
    xmin = [0.4673200277395354; 0.4673200169591304];
end