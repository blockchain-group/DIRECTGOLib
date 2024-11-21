function y = GallagherGaussian21BBOB(x, inst)
% -------------------------------------------------------------------------
% MATLAB coding by: Linas Stripinis
% Name:
%   GallagherGaussian21BBOB.m
%
% References:
%  - Nikolaus Hansen, Anne Auger, Steffen Finck, Raymond Ros. Real-Parameter 
%    Black-Box Optimization Benchmarking 2010: Experimental Setup. 
%    [Research Report] RR-7215, INRIA. 2010. ffinria-00462481
%
% Globally optimal solution:
%   f = 42.98
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
    inst = 22;
end
if size(x, 2) > size(x, 1), x = x'; end

persistent dim fopt funid xlocal nhighpeaks peakvalues fac arrscales rotation
if isempty(fopt) || dim ~= length(x) || funid ~= inst || isempty(xlocal) ...
   || isempty(nhighpeaks) || isempty(peakvalues) || isempty(fac) || ...
   isempty(arrscales) || isempty(rotation)
    dim = length(x);
    fopt = get_fmin(dim);
    funid = inst;
    fitvalues = [1.1, 9.1]; 
    nhighpeaks = 21; 
    fac2 = 0.98; 
    highpeakcond = 1000;
    maxcondition = 1000;
    rotation = compute_rotation(inst, dim);
    arrcondition = (maxcondition.^linspace(0, 1, nhighpeaks - 1))';
    idx = argsort(unif(nhighpeaks - 1, inst));
    arrcondition = [highpeakcond; arrcondition(idx)];
    arrscales = zeros(nhighpeaks, dim);
    for i = 1:length(arrcondition)
        s = arrcondition(i).^linspace(-0.5, 0.5, dim);
        idx = argsort(unif(dim, inst + (1e+3)*(i - 1)));
        arrscales(i, :) = s(idx);
    end
    peakvalues = [10, linspace(fitvalues(1), fitvalues(2), nhighpeaks - 1)];  
    fac = -0.5/dim;
    xlocal = fac2*reshape(10*unif(dim*nhighpeaks, inst) - 5, [dim, nhighpeaks])'*rotation;
    xlocal(1, :) = 0.8*xlocal(1, :);
end
z = x'*rotation;
xx = (ones(1, nhighpeaks).*z')' - xlocal;
f = (peakvalues'.*exp(fac*sum(arrscales.*xx.^2, 2)));
y = sum(toz(10 - max([max(f), -1])).^2)  + pen(x) + fopt;
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

function z = toz(x)
    z = x;
    for i = 1:length(x)
        if x(i) ~= 0, xx = log(abs(x(i))); else, xx = 0; end
        if x(i) > 0, c1 = 10; else, c1 = 5.5; end
        if x(i) > 0, c2 = 7.9; else, c2 = 3.1; end
        z(i) = sign(x(i))*exp(xx + 0.049*(sin(c1*xx) + sin(c2*xx)));
    end
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

function [sorted_indices, sorted_M] = argsort(M, mode)   
    if (~exist('mode', 'var'))
        mode = 'ascend';
    end    
    
    nRows = size(M, 1);
    indices = (1 : nRows)';
    
    M_with_indices = horzcat(M, indices);
    [sorted_M, sorted_indices] = sort(M_with_indices(:,1), mode);
end

function fmin = get_fmin(~)
    funid = 22;
    fmin = min([1000, max([-1000, (round(100*100*gauss(1, funid)/gauss(1, funid + 1))/100)])]);
end

function xmin = get_xmin(nx, inst)
    if nargin == 1
        inst = 22;
    end
    fac2 = 0.98;
    rotation = compute_rotation(inst, nx);
    xlocal = fac2*reshape(10*unif(nx*21, inst) - 5, [nx, 21])'*rotation;
    xlocal(1, :) = 0.8*xlocal(1, :);
    xmin = (xlocal(1, :)*transpose(rotation))';
end