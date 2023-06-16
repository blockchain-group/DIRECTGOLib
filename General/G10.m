function y = G10(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G010.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = 7049.2480229286575195
%   x* = [579.3067200186684431;  1359.9706200647983678;
%         5109.9706828451908223; 182.0177024870247067; 
%         295.6011727181924016;  217.9822974315108297; 
%         286.4165297381263144;  395.6011727103645512];
%
% Default variable bounds:
%   100  <= x(1) <= 10000;
%   1000 <= x(2, 3) <= 10000;
%   10   <= x(4) <= 1000, i = 4,...n
%   
% Problem Properties:
%   n  = 8;
%   #g = 6;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 8;
    y.ng = 6;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G10c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = x(1) + x(2) + x(3);  
end

function [c, ceq] = G10c( x )
c(1) = -1 + 0.0025*(x(4) + x(6)); 
c(2) = -1 + 0.0025*(x(5) + x(7)-x(4));  
c(3) = -1 + 0.01*(x(8) - x(5)); 
c(4) = -x(1)*x(6) + 833.33252*x(4) + 100*x(1) - 83333.333;  
c(5) = -x(2)*x(7) + 1250*x(5) + x(2)*x(4) - 1250*x(4);
c(6) = -x(3)*x(8) + 1250000 + x(3)*x(5) - 2500*x(5); 
ceq = [];
end

function xl = get_xl(~)
    xl = [100; 1000; 1000; 10; 10; 10; 10; 10];
end

function xu = get_xu(~)
    xu = [10000; 10000; 10000; 1000; 1000; 1000; 1000; 1000];
end

function fmin = get_fmin(~)
    fmin = 7049.2480229286575195;
end

function xmin = get_xmin(~)
    xmin = [579.3067200186684431; 1359.9706200647983678;...
        5109.9706828451908223; 182.0177024870247067; 295.6011727181924016;...
        217.9822974315108297; 286.4165297381263144; 395.6011727103645512];
end