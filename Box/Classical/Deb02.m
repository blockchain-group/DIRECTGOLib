function y = Deb02(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Deb02.m
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
%   f = -1
%   x(i) = for each x(i) = (0.05 + m/10)^(4/3), m in {1,3,5,7,9}, Hence
%   there are 5^n minimizers in [0,1]^n.
%
% Default variable bounds:
%   0 <= x(i) <= 1, i = 1,...,n
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx, varargin) get_xmin(nx, varargin{:});
    y.features = [1, 1, 1, 1, 0, 0, 0, 1];
    y.libraries = [0, 0, 0, 1, 1, 0, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

y = -(1/length(x))*sum(sin(5*pi*(x.^(3/4) - 0.05)).^6);
end

function xl = get_xl(nx)
    xl = zeros(nx, 1);
end

function xu = get_xu(nx)
    xu = ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = -1;
end

function xmin = get_xmin(nx, mode)
    % xmin = GET_XMIN(nx)         returns one minimizer (default).
    % xmin = GET_XMIN(nx,'all')   returns all 5^nx minimizers.

    if nargin < 2 || isempty(mode)
        mode = 'one';
    end

    m = [1, 3, 5, 7, 9];
    vals = (0.05 + m/10).^(4/3);

    if strcmpi(mode, 'one')
        % Deterministic choice: first value in each coordinate
        xmin = vals(1)*ones(1, nx);
        return
    end

    % Otherwise: return all minimizers
    grids = cell(1, nx);
    [grids{:}] = ndgrid(vals);

    xmin = zeros(nx, 5^nx);
    for k = 1:nx
        xmin(k, :) = grids{k}(:);
    end
end