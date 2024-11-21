function y = SphereBBOB(x, inst)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   SphereBBOB.m
%
% References:
%  - Nikolaus Hansen, Anne Auger, Steffen Finck, Raymond Ros. Real-Parameter 
%    Black-Box Optimization Benchmarking 2010: Experimental Setup. 
%    [Research Report] RR-7215, INRIA. 2010. ffinria-00462481
%
% Globally optimal solution:
%   f = -92.65
%   x = Depends on dimension
%
% Default variable bounds:
%   -5 <= x(i) <= 5, i = 1,...,n
%   
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Separable, Scalable, Uni-modal,
%   Convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx, varargin) get_xmin(nx, varargin{:});
    y.features = [1, 1, 1, 0, 1, 0, 0, 0];
    y.libraries = [0, 0, 0, 0, 0, 1, 0, 0, 0, 0];
    return
elseif nargin == 1
    inst = 1;
end
if size(x, 2) > size(x, 1), x = x'; end

persistent xopt dim fopt funid
if isempty(fopt) ||isempty(xopt) || dim ~= length(x) || funid ~= inst
    dim = length(x);
    xopt = get_xmin(dim, inst);
    fopt = get_fmin(dim);
    funid = inst;
end
z = x_shift(x, xopt);
y = sum(z.^2) + fopt;
end

function xl = get_xl(nx)
    xl = -5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function z = x_shift(x, xopt)
    z = x - xopt;
end

function g = gauss(N, seed)
    r = unif(2*N, seed);
    g = sqrt(-2*log(r(1:N))).*cos(2*pi*r(N+1:2*N));
    g(g == 0) = 1e-99;
end

function r = unif(N, inseed)
    inseed = abs(inseed); if inseed < 1, inseed = 1; end
    rgrand = zeros(32, 1); aktseed = inseed;
    for i = 39:-1:0
        tmp = floor(aktseed/127773);
        aktseed = 16807*(aktseed - tmp*127773) - 2836*tmp;
        if aktseed < 0
            aktseed = aktseed + 2147483647;
        end
        if i < 32
            rgrand(i + 1) = aktseed;
        end
    end
    aktrand = rgrand(1);
    r = zeros(N, 1);
    for i = 1:N
        tmp = floor(aktseed/127773);
        aktseed = 16807*(aktseed - tmp*127773) - 2836*tmp;
        if aktseed < 0
            aktseed = aktseed + 2147483647;
        end
        tmp = floor(aktrand/67108865) + 1;
        aktrand = rgrand(tmp);
        rgrand(tmp) = aktseed;
        r(i) = aktrand/2147483647;
    end
    r(r == 0) = 1e-15;
end

function fmin = get_fmin(~)
    funid = 1;
    fmin = min([1000, max([-1000, (round(100*100*gauss(1, funid)/gauss(1, funid + 1))/100)])]);
end

function xmin = get_xmin(nx, inst)
    if nargin == 1
        inst = 1;
    end
    xmin = 8*floor(1e+4*unif(nx, inst))/1e+4 - 4;
    xmin(xmin == 0) = -1e-5;
end