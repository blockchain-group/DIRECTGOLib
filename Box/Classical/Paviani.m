function y = Paviani(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Paviani.m
%
% References:
%  - Gavana, A.: Global optimization benchmarks and ampgo. 
%    URL: http://infinity77.net/global_optimization/index.html	
%  - Momin Jamil and Xin-She Yang, A literature survey of benchmark functions for
%    global optimization problems, Int. Journal of Mathematical Modelling and
%    Numerical Optimisation, Vol. 4, No. 2, pp. 150–194 (2013).
%    DOI: 10.1504/IJMMNO.2013.055204
%
% Globally optimal solution:
%   f = -45.77846970744631249772
%   x = [9.35026582995394761610; 9.35026582884526469286; ...
%        9.35026583156596657886; 9.35026582665137873107; ...
%        9.35026582900679947841; 9.35026583061411820097; ...
%        9.35026582986468390857; 9.35026583138120592764; ...
%        9.35026582990899157721; 9.35026583453920068223];
%
% Variable bounds:
%   2.001 <= x(i) <= 9.999, i = 1,...,n
%
% Problem Properties:
%   n  = 10;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Uni-modal,
%   Convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 10;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 0, 1, 0, 0, 0];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = sum(log(x - 2).^2 + log(10 - x).^2) - (prod(x)^0.2);
end

function xl = get_xl(nx)
    xl = 2.001*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 9.999*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -45.77846970744631249772;
end

function xmin = get_xmin(~)
    xmin = [9.35026582995394761610; 9.35026582884526469286; ...
            9.35026583156596657886; 9.35026582665137873107; ...
            9.35026582900679947841; 9.35026583061411820097; ...
            9.35026582986468390857; 9.35026583138120592764; ...
            9.35026582990899157721; 9.35026583453920068223];
end