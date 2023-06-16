function y = s365mod(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   s365mod.m
%
% Original source: 
% - Vaz, A.I.F.: PSwarm solver home page (2010).
%   http://www.norg.uminho.pt/aivaz/pswarm/. Accessed 12 Dec 2013  
%
% Globally optimal solution:
%   f* = 52.139904360199466
%   x* = [15.8148544447801; 15.3148550782495;   3.29689448120853;...
%         14.5873679261804; 1;12.5873678784540; 1]
%
% Default variable bounds:
%   0 <= x(i) <= 19, i = 1,...,n
%   
% Problem Properties:
%   n  = 7;
%   #g = 9;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 7;
    y.ng = 9;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) s365modc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = x(1)*x(3);
end

function [Ineq, eq] = s365modc(x)
    P = sqrt(x(2)^2) + x(3)^2;
    Q = sqrt(x(3)^2) + (x(2) - x(1))^2;
    Ineq(1) = -((x(4) - x(6))^2 + (x(5) - x(7))^2 - 4);  
    Ineq(2) = -((x(3)*x(4) - x(2)*x(5))/P - 1); 
    Ineq(3) = -((x(3)*x(6) - x(2)*x(7))/P - 1);
    Ineq(4) = -((x(1)*x(3) + (x(2) - x(1))*x(5) - x(3)*x(4))/Q - 1);
    Ineq(5) = -((x(1)*x(3) + (x(2) - x(1))*x(7) - x(3)*x(6))/Q - 1);
    Ineq(6) = 0.5 - x(1);
    Ineq(7) = 0.5 - x(3);
    Ineq(8) = 1 - x(5);
    Ineq(9) = 1 - x(7);
    eq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 19*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 52.1399063401117004;
end

function xmin = get_xmin(~)
    xmin = [15.8148544447801; 15.3148550782495; 3.29689448120853;...
        14.5873679261804; 1;12.5873678784540; 1];
end