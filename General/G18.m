function y = G18(x)
% ------------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G18.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -0.86602540378443870761060
%   x* = [-0.657776192427943163; -0.153418773482438542; 
%          0.323413871675240938; -0.946257611651304398; 
%         -0.657776194376798906; -0.753213434632691414; 
%          0.323413874123576972; -0.346462947962331735; 
%          0.59979466285217542];
%
% Default variable bounds:
%   -10 <= x(1) <= 10, i = 1,...8
%    0  <= x(9) <= 20;
%   
% Problem Properties:
%   n  = 9;
%   #g = 13;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 9;
    y.ng = 13;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G18c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -0.5*(x(1)*x(4) - x(2)*x(3) + x(3)*x(9) - x(5)*x(9) + x(5)*x(8) -...
    x(6)*x(7));
end

function [c, ceq] = G18c( x )
c(1) = x(3)^2 + x(4)^2 - 1; 
c(2) = x(9)^2 - 1;
c(3) = x(5)^2 + x(6)^2 - 1;  
c(4) = x(1)^2 + (x(2) - x(9))^2 - 1; 
c(5) = (x(1) - x(5))^2 + (x(2) - x(6))^2 - 1; 
c(6) = (x(1) - x(7))^2 + (x(2) - x(8))^2 - 1;
c(7) = (x(3) - x(5))^2 + (x(4) - x(6))^2 - 1; 
c(8) = (x(3) - x(7))^2 + (x(4) - x(8))^2 - 1; 
c(9) = (x(7))^2 + (x(8) - x(9))^2 - 1; 
c(10) = x(2)*x(3) - x(1)*x(4);
c(11) = - x(3)*x(9); 
c(12) = x(5)*x(9);
c(13) = x(6)*x(7) - x(5)*x(8); 
ceq = [];
end

function xl = get_xl(~)
    xl = [-10*ones(8, 1); 0];
end

function xu = get_xu(~)
    xu = [10*ones(8, 1); 20];
end

function fmin = get_fmin(~)
    fmin = -0.86602540378443870761060;
end

function xmin = get_xmin(~)
    xmin = [-0.657776192427943163; -0.153418773482438542;...
        0.323413871675240938; -0.946257611651304398;...
        -0.657776194376798906; -0.753213434632691414;...
        0.323413874123576972;  -0.346462947962331735; 0.59979466285217542];
end