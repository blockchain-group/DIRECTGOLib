function y = Gas_Transmission_Compressor(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Gas_Transmission_Compressor.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 2964895.417339159
%   x* = [49.999999999999616; 1.178283956792145; 24.592590112334335; 0.388353082833753]
%     
% Problem Properties:
%   n  = 4;
%   #g = 1;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 4;
    y.ng = 1;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 8.61*1e5*x(1)^0.5*x(2)*x(3)^(-2/3)*x(4)^(-1/2) + 3.69*1e4*x(3)...
    + 7.72*1e8*x(1)^(-1)*x(2)^(0.219) - 765.43*1e6*x(1)^(-1);
end

function [g, ceq] = ConFun( x )
    g(1) = x(4)*x(2)^(-2) + x(2)^(-2) - 1;
    ceq = [];
end

function xl = get_xl(~)
    xl = [20; 1; 20; 0.1];
end

function xu = get_xu(~)
    xu = [50; 10; 50; 60];
end

function fmin = get_fmin(~)
    fmin = 2964895.417339159;       
end

function xmin = get_xmin(~)
    xmin = [49.999999999999616; 1.178283956792145; 24.592590112334335; 0.388353082833753];
end