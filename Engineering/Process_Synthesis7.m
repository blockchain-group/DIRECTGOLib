function y = Process_Synthesis7(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Process_Synthesis7.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 2.924830553663361
%   x* = [0.198309549468086; 1.28062484748657; 1.95465427188282; 1.28382757046262; -0.0363844630173789; 0.302138123190496; 1.37336086524379]
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
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = (round(x(4)) - 1)^2 + (round(x(5)) - 1)^2 + (round(x(6)) - 1)^2 -...
    log(round(x(7)) + 1) + (x(1) - 1)^22 + (x(2) - 2)^2 + (x(3) - 3)^2;
end

function [g, ceq] = ConFun( x )
    g(1) = x(1) + x(2) + x(3) + round(x(4)) + round(x(5)) + round(x(6)) - 5;
    g(2) = round(x(6))^2 + x(1)^2 + x(2)^2 + x(3)^2 - 5.5;
    g(3) = x(1) + round(x(4)) - 1.2;
    g(4) = x(2) + round(x(5)) - 1.8;
    g(5) = x(3) + round(x(6)) - 2.5;
    g(6) = x(1) + round(x(7)) - 1.2;
    g(7) = round(x(5))^2 + x(2)^2 - 1.64;
    g(8) = round(x(6))^2 + x(3)^2 - 4.25;
    g(9) = round(x(5))^2 + x(3)^2 - 4.64;
    ceq = [];
end

function xl = get_xl(~)
    xl = [0; 0; 0; -0.51; -0.51; -0.51; -0.51];
end

function xu = get_xu(~)
    xu = [100; 100; 100; 1.49; 1.49; 1.49; 1.49];
end

function fmin = get_fmin(~)
    fmin = 2.924830553663361;
end

function xmin = get_xmin(~)
    xmin = [0.198309549468086; 1.28062484748657; 1.95465427188282; 1.28382757046262; -0.0363844630173789; 0.302138123190496; 1.37336086524379];
end