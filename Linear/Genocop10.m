function y = Genocop10(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Genocop10.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = -4.52836567655105
%   x* = [0.00316227773088941; 2; 0; 1]
%
% Default variable bounds:
%   0 <= x(1) <= 3;
%   0 <= x(2, 3) <= 10;
%   0 <= x(4) <= 1;
%   
% Problem Properties:
%   n  = 4;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 4;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) funcon(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -(x(1)^0.6 + x(2)^0.6 - 6*x(1) - 4*x(3) + 3*x(4));
end

function [c, ceq] = funcon(x)
    c(1) = x(2) + 2*x(4) - 4;
    c(2) = x(1) + 2*x(3) - 4;
    ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(~)
    xu = [3; 10; 10; 1];
end

function fmin = get_fmin(~)
    fmin = -4.528365677151072;
end

function xmin = get_xmin(~)
    xmin = [0.00316227773088941; 2; 0; 1];
end