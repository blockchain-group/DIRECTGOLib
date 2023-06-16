function y = G07(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G07.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251�256. https://doi.org/c
%
% Globally optimal solution:
%   f* = 24.3062114682119343
%   x* = [2.1719963832143501; 2.3636831783441412; 8.7739252719711676;
%         5.0959847833389196; 0.9906546223828404; 1.4305737791857069;
%         1.3216441491157800; 9.8287256433047112; 8.2800916213197873;
%         8.3759268441446704];
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...n
%   
% Problem Properties:
%   n  = 10;
%   #g = 8;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 10;
    y.ng = 8;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G07c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = x(1)^2 + x(2)^2 + x(1)*x(2) - 14*x(1) - 16*x(2) + (x(3) - 10)^2 +...
    4*(x(4) - 5)^2 + (x(5) - 3)^2 + 2*(x(6) - 1)^2 + 5*x(7)^2 +...
    7*(x(8) - 11)^2 + 2*(x(9) - 10)^2 + (x(10) - 7)^2 + 45;
end

function [c, ceq] = G07c( x )
c(1) = -105 + 4*x(1) + 5*x(2) - 3*x(7) + 9*x(8);
c(2) = 10*x(1) - 8*x(2) - 17*x(7) + 2*x(8); 
c(3) = -8*x(1) + 2*x(2) + 5*x(9) - 2*x(10) - 12;
c(4) = 3*((x(1)-2)^2) + 4*((x(2)-3)^2) + 2*(x(3)^2) - 7*x(4) - 120;
c(5) = 5*(x(1)^2) + 8*x(2) + (x(3)-6)^2 - 2*x(4) - 40;
c(6) = x(1)^2 + 2*((x(2)-2)^2) - 2*x(1)*x(2) + 14*x(5) - 6*x(6);
c(7) = 0.5*((x(1)-8)^2) + 2*((x(2)-4)^2) + 3*(x(5)^2) - x(6) - 30;
c(8) = -3*x(1) + 6*x(2) + 12*((x(9)-8)^2) - 7*x(10);
ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 24.3062114682119343;
end

function xmin = get_xmin(~)
    xmin = [2.1719963832143501; 2.3636831783441412; 8.7739252719711676;...
        5.0959847833389196; 0.9906546223828404; 1.4305737791857069;...
        1.3216441491157800; 9.8287256433047112; 8.2800916213197873;...
        8.3759268441446704];
end