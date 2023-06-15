function y = s331(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s331.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 4.2583846832
%   x* = [0.6189551423; 0.1035582260]
%
% Default variable bounds:
%   0.0001 <= x(i) <= 10, i = 1,...,n
%   
% Problem Properties:
%   n  = 2;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 2;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(i) 0.0001; 
    y.xu = @(i) 10;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end
y = (1/x(1))*log(2*log(x(2))/log(x(1) + x(2)));
end

function [c, ceq] = funcon( x )
    c = -1 + x(1) + x(2);
    ceq = [];
end

function fmin = get_fmin(~)
    fmin = 4.2583846832;
end

function xmin = get_xmin(~)
    xmin = [0.6189551423; 0.1035582260];
end