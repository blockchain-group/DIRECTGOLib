function y = Industrial_Refrigeration_System(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Industrial_Refrigeration_System.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 0.032213000883957
%   x* = [0.001; 0.001; 0.001; 0.001; 0.001; 0.001; 1.524; 1.524; 5; 2; 0.001; 0.001; 0.00729340078098931; 0.0875558317045535];
%   
% Problem Properties:
%   n  = 14;
%   #g = 15;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 14;
    y.ng = 15;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end

if size(x, 2) > size(x, 1)
    x = x'; 
end

y = 63098.88*x(2)*x(4)*x(12) + 5441.5*x(2)^2*x(12) + 115055.5*x(2)^1.664*x(6).....
    + 6172.27*x(2)^2*x(6) + 63098.88*x(1)*x(3)*x(11) + 5441.5*x(1)^2*x(11).....
    + 115055.5*x(1)^1.664*x(5) + 6172.27*x(1)^2*x(5) + 140.53*x(1)*x(11) + 281.29*x(3)*x(11)....
    + 70.26*x(1)^2 + 281.29*x(1)*x(3) + 281.29*x(3)^2 + 14437*x(8)^1.8812*x(12)^0.3424....
    *x(10)*x(14)^(-1)*x(1)^2*x(7)*x(9)^(-1) + 20470.2*x(7)^(2.893)*x(11)^0.316*x(1)^2;
end

function [g, ceq] = ConFun(x)
    % Constraints
    g(1) = 1.524 * x(7)^(-1) - 1;
    g(2) = 1.524 * x(8)^(-1) - 1;
    g(3) = 0.07789 * x(1) - 2 * x(7)^(-1) * x(9) - 1;
    g(4) = 7.05305 * x(9)^(-1) * x(1)^2 * x(10) * x(8)^(-1) * x(2)^(-1) * x(14)^(-1) - 1;
    g(5) = 0.0833 / x(13) * x(14) - 1;
    g(6) = 0.04771 * x(10) * x(8)^1.8812 * x(12)^0.3424 - 1;
    g(7) = 0.0488 * x(9) * x(7)^1.893 * x(11)^0.316 - 1;
    g(8) = 0.0099 * x(1) / x(3) - 1;
    g(9) = 0.0193 * x(2) / x(4) - 1;
    g(10) = 0.0298 * x(1) / x(5) - 1;
    g(11) = 47.136 * x(2)^0.333 / x(10) * x(12) - 1.333 * x(8) * x(13)^2.1195 + 62.08 * x(13)^2.1195 * x(8)^0.2 / (x(12) * x(10)) - 1;
    g(12) = 0.056 * x(2) / x(6) - 1;
    g(13) = 2 / x(9) - 1;
    g(14) = 2 / x(10) - 1;
    g(15) = x(12) / x(11) - 1;

    % No equality constraints
    ceq = [];
end


function xl = get_xl(nx)
    xl = 0.001*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = 0.032213000883957;
end

function xmin = get_xmin(~)
    xmin = [0.001; 0.001; 0.001; 0.001; 0.001; 0.001; 1.524; 1.524; 5; 2; 0.001; 0.001; 0.00729340078098931; 0.0875558317045535];
end