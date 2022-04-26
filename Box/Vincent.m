function [y] = Vincent(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Vincent.m
%
% Original source:
%  - http://benchmarkfcns.xyz/benchmarkfcns/alpinen2fcn.html
%
% Globally optimal solution:
%   f = -n
%   x(i) = [7.9170526915515411], i = 1...n
%
% Default variable bounds:
%   0.25 <= x(i) <= 10, i = 1...n
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
    y.xl = @(i) 0.25;
    y.xu = @(i) +10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
n = length(x);

y = 0;

for i = 1:n
    y = y + sin(10*log(x(i)));
end
y = -y;
end

function fmin = get_fmin(nx)
    fmin = -nx;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*exp(pi/20);
end