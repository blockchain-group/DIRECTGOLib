function y = Schaffer7BBOB(x, inst)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   Schaffer7BBOB.m
%
% References:
%  - Nikolaus Hansen, Anne Auger, Steffen Finck, Raymond Ros. Real-Parameter 
%    Black-Box Optimization Benchmarking 2010: Experimental Setup. 
%    [Research Report] RR-7215, INRIA. 2010. ffinria-00462481
%
% Globally optimal solution:
%   f = -38.72
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
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx, varargin) get_xmin(nx, varargin{:});
    y.features = [1, 0, 1, 1, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 0, 0, 1, 0, 0, 0, 0];
    return
elseif nargin == 1
    inst = 17;
end
if size(x, 2) > size(x, 1), x = x'; end

persistent xopt dim fopt funid rotation linearTF arrexpo
if isempty(fopt) || isempty(xopt) || dim ~= length(x) || funid ~= inst ...
   || isempty(rotation) || isempty(linearTF) || isempty(arrexpo)
    dim = length(x);
    xopt = get_xmin(dim, inst);
    fopt = get_fmin(dim);
    funid = inst;
    rotation = compute_rotation(inst + 1e+6, dim);
    linearTF = compute_rotation(inst, dim)*diag(sqrt(10).^linspace(0, 1 , dim));
    arrexpo = 0.5*linspace(0, 1, dim);
end
z = x_shift(x, xopt)*rotation;
idx = z > 0;
z(idx) = z(idx).^(1 + arrexpo(idx).*sqrt(z(idx)));
z = z*linearTF;
s = z(1:end - 1).^2 + z(2:end).^2;

y = mean((s.^0.25).*(sin(50*s.^(0.1)).^2 + 1)).^2 + 10*pen(x) + fopt;
end

function xl = get_xl(nx)
    xl = -5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function z = pen(x)
    z = sum((max([zeros(length(x), 1), (abs(x) - 5)], [], 2).*sign(x)).^2);
end

function z = x_shift(x, xopt)
    z = (x - xopt)';
end

function B = compute_rotation(seed, dim)
    B = reshape(gauss(dim*dim, seed), [dim, dim])';
    for i = 1:dim
        for j = 1:i-1
            B(i, :) = B(i, :) - sum(B(i, :).*B(j, :))*B(j, :);
        end
        B(i, :) = B(i, :)/sqrt(sum(B(i, :).^2));
    end
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
    funid = 17;
    fmin = min([1000, max([-1000, (round(100*100*gauss(1, funid)/gauss(1, funid + 1))/100)])]);
end

function xmin = get_xmin(nx, inst)
    if nargin == 1
        inst = 17;
    end
    xmin = 8*floor(1e+4*unif(nx, inst))/1e+4 - 4;
    xmin(xmin == 0) = -1e-5;
end