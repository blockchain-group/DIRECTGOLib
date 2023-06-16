function y = BentCigarBBOB(x)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   BentCigarBBOB.m
%
% References:
%  - Nikolaus Hansen, Anne Auger, Steffen Finck, Raymond Ros. Real-Parameter 
%    Black-Box Optimization Benchmarking 2010: Experimental Setup. 
%    [Research Report] RR-7215, INRIA. 2010. ffinria-00462481
%
% Globally optimal solution:
%   f = 295.18
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
%   Differentiable, Non-separable, Scalable, Uni-modal,
%   Non-Convex, Non-plateau, Non-Zero-Solution, Asymmetric
% -------------------------------------------------------------------------
if nargin == 0
    y.nx = 0;
    y.ng = 0;
    y.nh = 0;
    y.xl = @(nx) get_xl(nx); 
    y.xu = @(nx) get_xu(nx);
    y.fmin = @(nx) get_fmin(nx);
    y.xmin = @(nx) get_xmin(nx);
    y.features = [1, 0, 1, 0, 0, 0, 0, 0];
    y.libraries = [0, 0, 0, 0, 0, 1, 0, 0, 0, 0];
    return
end
if size(x, 2) > size(x, 1), x = x'; end

persistent xopt dim fopt funid arrexpo R
if isempty(fopt) || isempty(xopt) || dim ~= length(x) || funid ~= 12 || isempty(arrexpo) || isempty(R)
    dim = length(x);
    xopt = get_xmin(dim);
    fopt = get_fmin(dim);
    funid = 12;
    arrexpo = 0.5.^linspace(0, 1, dim);
    R = compute_rotation(12 + 1e+6, dim);
end

z = x_shift(x, xopt)'*R;
z(z>0) = z(z>0).^(1 + arrexpo(z>0).*sqrt(z(z>0)));
z = z*R;
y = z(1)^2 + (10^6)*sum(z.^2) + fopt;
end

function z = x_shift(x, xopt)
    z = x - xopt;
end

function B = compute_rotation(seed, dim)
    B = reshape(gauss(dim*dim, seed), [dim, dim]);
    for i = 1:dim
        for j = 2:i
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

function xl = get_xl(nx)
    xl = -5*ones(nx, 1);
end

function xu = get_xu(nx)
    xu = 5*ones(nx, 1);
end

function fmin = get_fmin(~)
    fmin = min([1000, max([-1000, (round(100*100*gauss(1, 12)/gauss(1, 12 + 1))/100)])]);
end

function xmin = get_xmin(nx)
    xmin = 8*floor(1e+4*unif(nx, 12 + 1e+6))/1e+4 - 4;
    xmin(xmin == 0) = -1e-5;
end