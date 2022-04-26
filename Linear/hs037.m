function y = hs037(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   hs037.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -3456
%   x* = (24, 12, 12) 
%
% Constraints (including variable bounds):
%   g(1): x(1)+2*x(2)+2*x(3)  <= 72;
%   g(2): -x(1)-2*x(2)-2*x(3) <= 0;
%         0 <= x(1) <= 42;
%         0 <= x(2) <= 42;
%         0 <= x(3) <= 42;
%   
% Problem Properties:
%   n  = 3;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(i) 0;
    y.xu = @(i) 42;
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) hs037c(i);
    return
end
if size(x, 2) > size(x, 1)
    x = x'; 
end

y = -x(1)*x(2)*x(3);
end

function [c, ceq] = hs037c( x )
c(1) = x(1) + 2*x(2) + 2*x(3) - 72;
c(2) = -x(1) - 2*x(2) - 2*x(3);
ceq = [];
end

function fmin = get_fmin(~)
    fmin = -3456;
end

function xmin = get_xmin(~)
    xmin = [24; 12; 12];
end