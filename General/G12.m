function y = G12(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G12.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -1
%   x* = [5; 5; 5]
%
% Default variable bounds:
%   0.2 <= x(1) <= 10, i = 1,...n
%   
% Problem Properties:
%   n  = 3;
%   #g = 1;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 3;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G12c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -(100 - (x(1) - 5)^2 - (x(2) - 5)^2 - (x(3) - 5)^2)/100;
end

function [c, ceq] = G12c( x)
for p = 1:9
    for q = 1:9
        for r = 1:9
            z(p, q, r) = (x(1) - p)^2 + (x(2)-q)^2 + (x(3) - r)^2 - 0.0625;
        end
    end
end
for p = 1:9
    for q = 1:9
        Z1(p, q) = min(z(p, q, :));    
    end
    Z2(p) = min(Z1(p, :));
end
c = min(Z2);
ceq = [];
end

function xl = get_xl(nx)
    xl = 0.2*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(~)
    xmin = [5; 5; 5];
end