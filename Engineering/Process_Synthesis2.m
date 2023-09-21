function y = Process_Synthesis2(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Process_Synthesis2.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 2
%   x* = [1.5; -0.509723654726881];
%
% Problem Properties:
%   n  = 2;
%   #g = 2;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 2;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
x(2) = round(x(2));
y = 2*x(1) + round(x(2));
end

function [g, ceq] = ConFun( x )
    g(1) = 1.25 - x(1)^2 - round(x(2));
    g(2) = x(1) + round(x(2)) - 1.6;
    ceq = [];
end

function xl = get_xl(~)
    xl = [0; -0.51];
end

function xu = get_xu(~)
    xu = [1.6; 1.49];
end

function fmin = get_fmin(~)
    fmin = 2;
end

function xmin = get_xmin(~)
    xmin = [1.5; -0.509723654726881];
end