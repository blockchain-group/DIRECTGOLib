function y = Himmelblaus(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Himmelblaus.m
%
% Original source: 
% - Hu, X., Eberhart, R. C., & Shi, Y. (2003). Engineering
%   optimization with particle swarm. Swarm Intelligence Symposium, 
%   2003. SIS ’03. Proceedings of the 2003 IEEE, 53–57. 
%   https://doi.org/10.1109/SIS.2003.1202247
%
% Globally optimal solution:
%   f* = -31025.5602424976241309
%   x* = [78.0000000000015774; 33.0000000000023590;
%         27.0709971051783000; 44.9999999999988205; 44.9692425500985635];
%
% Default variable bounds:
%   78 <= x(1) <= 102;
%   33 <= x(2) <= 45;
%   27 <= x(i) <= 45, i = 3,...5
%   
% Problem Properties:
%   n  = 5;
%   #g = 6;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 5;
    y.ng = 6;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) Himmelblausc(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = 5.3578547*x(3)^2 + 0.8356891*x(1)*x(5) + 37.293239*x(1) - 40792.141;
end

function [c, ceq] = Himmelblausc( x )
c(1) = 85.334407 + 0.0056858*x(2)*x(5) + 0.00026*x(1)*x(4) -...
    0.0022053*x(3)*x(5) - 92;  
c(2) = -85.334407 - 0.0056858*x(2)*x(5) - 0.00026*x(1)*x(4) +...
    0.0022053*x(3)*x(5); 
c(3) = 80.51249 + 0.0071317*x(2)*x(5) + 0.0029955*x(1)*x(2) +... 
    0.0021813*x(3)^2 - 110;
c(4) = -80.51249 - 0.0071317*x(2)*x(5) - 0.0029955*x(1)*x(2) -... 
    0.0021813*x(3)^2 + 90; 
c(5) = 9.300961 + 0.0047026*x(3)*x(5) + 0.0012547*x(1)*x(3) +... 
    0.0019085*x(3)*x(4) - 25;  
c(6) = -9.300961 - 0.0047026*x(3)*x(5) - 0.0012547*x(1)*x(3) -...
    0.0019085*x(3)*x(4) + 20;  
ceq = [];
end

function xl = get_xl(~)
    xl = [78; 33; 27; 27; 27];
end

function xu = get_xu(~)
    xu = [102; 45; 45; 45; 45];
end

function fmin = get_fmin(~)
    fmin = -31025.5602424976241309;
end

function xmin = get_xmin(~)
    xmin = [78.0000000000015774; 33.0000000000023590;...
        27.0709971051783000; 44.9999999999988205; 44.9692425500985635];
end