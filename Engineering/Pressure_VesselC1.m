function y = Pressure_VesselC1(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Pressure_VesselC1.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 6059.714335048436
%   x* = [13.1198365035544; 6.75678906380168; 42.0984455958549; 176.636595842439]
%    
% Problem Properties:
%   n  = 4;
%   #g = 4;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 4;
    y.ng = 4;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) NASA_speed_reducerc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = 0.6224*(0.0625*round(x(1)))*x(3)*x(4) + 1.7781*(0.0625*round(x(2)))*x(3)^2 +...
    3.1661*(0.0625*round(x(1)))^2*x(4) + 19.84*(0.0625*round(x(1)))^2*x(3);
end

function [g, ceq] = NASA_speed_reducerc( x )
    g(1) = -0.0625*round(x(1)) + 0.0193*x(3);
    g(2) = -0.0625*round(x(2)) + 0.00954*x(3);
    g(3) = -pi*x(3)^2*x(4) - 4/3*pi*x(3)^3 + 1296000;
    g(4) = x(4) - 240;
    ceq = [];
end

function xl = get_xl(~)
    xl = [0.51; 0.51; 10; 10];
end

function xu = get_xu(~)
    xu = [99.49; 99.49; 200; 200];
end

function fmin = get_fmin(~)
    fmin = 6059.714335048436;
end

function xmin = get_xmin(~)
    xmin = [13.1198365035544; 6.75678906380168; 42.0984455958549; 176.636595842439];
end