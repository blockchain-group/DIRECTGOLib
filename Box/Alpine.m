function y = Alpine(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Alpine.m
%
% Original source:
%  - http://benchmarkfcns.xyz/benchmarkfcns/alpinen2fcn.html
%
% Globally optimal solution:
%   f = -2.8081311800070050^n
%   x(i) = [7.9170526915515411], i = 1...n
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1...n
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
    y.xl = @(i) 0; 
    y.xu = @(i) 10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = -prod(sqrt(abs(x)).* sin(abs(x)), 1);
end 

function fmin = get_fmin(nx)
    fmin = -2.8081311800070050^nx;
end

function xmin = get_xmin(nx)
    xmin = ones(nx, 1)*7.9170526915515411;
end