function y = Process_Flow_Sheeting(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%    Process_Flow_Sheeting.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 1.076543083332263
%   x* = [0.941937344729377; -2.10000000000000; 1.23989132604691]
%
% Problem Properties:
%   n  = 3;
%   #g = 3;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 3;
    y.ng = 3;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = -0.7*round(x(3)) + 5*(x(1) - 0.5)^2 + 0.8;
end

function [g, ceq] = ConFun( x )
    g(1) = -exp(x(1) - 0.2) - x(2);
    g(2) = x(2) + 1.1*round(x(3)) + 1;
    g(3) = x(1) - round(x(3)) - 0.2;
    ceq = [];
end

function xl = get_xl(~)
    xl = [0.2; -2.22554; -0.51];
end

function xu = get_xu(~)
    xu = [1; -1; 1.49];
end

function fmin = get_fmin(~)
    fmin = 1.076543083332263;
end

function xmin = get_xmin(~)
    xmin = [0.941937344729377; -2.10000000000000; 1.23989132604691];
end