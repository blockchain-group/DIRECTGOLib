function y = Multi_Product_Batch_Plant(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Multi_Product_Batch_Plant.m
%
% Original source: 
% - Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & 
%   Das, S. (2020). A test-suite of non-convex constrained optimization 
%   problems from the real-world and some baseline results. Swarm and 
%   Evolutionary Computation, 56, 100693.
%
% Known optimal solution:
%   f* = 58505.44989024540
%   x* = [2.35963625830157; 2.07895156949155; 1.21348757369724; 479.606700022850;
%         719.410050034275; 661.839716107868; 10; 8;120.853876436292; 59.4747367875665]
%  
% Problem Properties:
%   n  = 10;
%   #g = 10;
%   #h = 0;  
% ------------------------------------------------------------------------- 
if nargin == 0
    y.nx = 10;
    y.ng = 10;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) ConFun(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end
y = 250*(round(x(1))*x(4)^0.6 + round(x(2))*x(5)^0.6 + round(x(3))*x(6)^0.6);
end

function [g, ceq] = ConFun( x )
    g(1) = 40000*x(7)/x(9) + 20000*x(8)/x(10) - 6000;
    g(2) = 2*x(9) + 4*x(10) - x(4);
    g(3) = 3*x(9) + 6*x(10) - x(5);
    g(4) = 4*x(9) + 3*x(10) - x(6);
    g(5) = 8 - round(x(1)).*x(7);
    g(6) = 20 - round(x(2)).*x(7);
    g(7) = 8 - round(x(3)).*x(7);
    g(8) = 16 - round(x(1)).*x(8);
    g(9) = 4 - round(x(2)).*x(8);
    g(10) = 4 - round(x(3)).*x(8);
    ceq = [];
end

function xl = get_xl(~)
    xl = [0.51; 0.51; 0.51; 250; 250; 250; 6; 4; 40; 10];
end

function xu = get_xu(~)
    xu = [3.49; 3.49; 3.49; 2500; 2500; 2500; 20; 16; 700; 450];
end

function fmin = get_fmin(~)
    fmin = 58505.44989024540;
end

function xmin = get_xmin(~)
    xmin = [2.35963625830157; 2.07895156949155; 1.21348757369724; 479.606700022850;...
        719.410050034275; 661.839716107868; 10; 8;120.853876436292; 59.4747367875665];
end