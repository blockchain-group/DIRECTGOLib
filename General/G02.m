function y = G02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   G02.m
%
% Original source: 
% - Suganthan, P. N., Hansen, N., Liang, J. J., Deb, K., Chen, Y.-P., 
%   Auger, A., & Tiwari, S. (2005). Problem Definitions and Evaluation 
%   Criteria for the CEC 2006 Special Session on Constrained Real-Parameter
%   Optimization. KanGAL, (May), 251–256. https://doi.org/c
%
% Globally optimal solution:
%   f* = -0.80946659915096941251277939954889
%   x* = [3.16246061572185; 3.12833142812967; 3.09479212988791; 
%         3.06145059523469; 3.02792915885555; 2.99382606701730; 
%         2.95866871765285; 2.92184227312450; 0.49482511456933; 
%         0.48835711005490; 0.48231642711865; 0.47664475092742; 
%         0.47129550835493; 0.46623099264167; 0.46142004984199; 
%         0.45683664767217; 0.45245876903267; 0.44826762241853; 
%         0.44424700958760; 0.44038285956317];
%
% Default variable bounds:
%   0 <= x(i) <= 10, i = 1,...n
%   
% Problem Properties:
%   n  = 20;
%   #g = 2;
%   #h = 0;  
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 20;
    y.ng = 2;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.confun = @(i) G02c(i);
    return
end
if size(x, 2) > size(x, 1), x = x'; end

A = transpose(1:20);
y = -abs((sum(cos(x).^4) - 2*prod(cos(x).^4))/sqrt(sum(A.*x.^2)));
end

function [c, ceq] = G02c( x )
c(1) = -prod(x) + 0.75;
c(2) = sum(x) - 7.5*20;
ceq = [];
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = 10*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -0.80946659915096941251277939954889;
end

function xmin = get_xmin(~)
    xmin = [3.16246061572185; 3.12833142812967; 3.09479212988791;...
        3.06145059523469; 3.02792915885555; 2.99382606701730;...
        2.95866871765285; 2.92184227312450; 0.49482511456933;...
        0.48835711005490; 0.48231642711865; 0.47664475092742;...
        0.47129550835493; 0.46623099264167; 0.46142004984199;...
        0.45683664767217; 0.45245876903267; 0.44826762241853;...
        0.44424700958760; 0.44038285956317];
end