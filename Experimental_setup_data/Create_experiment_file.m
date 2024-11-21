% -------------------------------------------------------------------------
% Script: The MATLAB script will cycle through all the box-constrained test 
%         problems in the DIRECTGOLib v2.0 in all five instances 
%         recommended in [1].
%
% Created on: 07/31/2024
%
% Purpose: Creates the mat-file with experimental settings from [1]
%
% References
% [1] Stripinis, L., Kůdela, J., & R. Paulavičius, "Benchmarking 
%     Derivative-Free Global Optimization Algorithms Under Limited 
%     Dimensions and Large Evaluation Budgets." IEEE Transactions on 
%     Evolutionary Computation. DOI: 10.1109/TEVC.2024.3379756.
%--------------------------------------------------------------------------

clear;clc;
%% Experimental Setup
% Considered dimensions for scalable test functions
Dimensions = [2, 5, 10, 20];

% Considered number of instances - first two with shift only, other ones with shift and rotation
Instances = 5;

%% Path for test functions
% Load paths to test problems:
parts = strsplit(pwd, filesep); parts(end) = []; parts{end + 1} = 'Box';  
parent_path = strjoin(parts(1:end), filesep); addpath(genpath(parent_path));

%% Load test functions:  
load('ListOfProblems.mat');
DIRECTGOLib_Results = DIRECTGOLib_problems(1, 1:2); DIRECTGOLib_Results{1, 3} = "Dimension"; DIRECTGOLib_Results{1, 4} = "Instance";
DIRECTGOLib_Results{1, 5} = "M"; DIRECTGOLib_Results{1, 6} = "Shift"; DIRECTGOLib_Results{1, 7} = "Fmin"; 
DIRECTGOLib_Results{1, 8} = "History"; DIRECTGOLib_Results{1, 9} = "Fbest"; DIRECTGOLib_Results{1, 10} = "Xbest";

%% Prepare test functions:
for h = 2:size(DIRECTGOLib_problems, 1)
    for j = 1:length(Dimensions)
        ii = size(DIRECTGOLib_Results, 1);
        if length(DIRECTGOLib_problems{h, 3}) ~= 1
            if ismember(Dimensions(j),DIRECTGOLib_problems{h, 3})
                for jj=1:Instances
                    DIRECTGOLib_Results{ii + jj, 1} = ii;
                    DIRECTGOLib_Results{ii + jj, 2} = DIRECTGOLib_problems{h, 2};
                    DIRECTGOLib_Results{ii + jj, 3} = Dimensions(j);
                    DIRECTGOLib_Results{ii + jj, 4} = jj;
                end
            end
        elseif DIRECTGOLib_problems{h, 3} == 0
            for jj=1:Instances
                DIRECTGOLib_Results{ii + jj, 1} = ii;
                DIRECTGOLib_Results{ii + jj, 2} = DIRECTGOLib_problems{h, 2};
                DIRECTGOLib_Results{ii + jj, 3} = Dimensions(j);
                DIRECTGOLib_Results{ii + jj, 4} = jj;
            end
        else
            for jj=1:Instances
                DIRECTGOLib_Results{ii + jj, 1} = ii;
                DIRECTGOLib_Results{ii + jj, 2} = DIRECTGOLib_problems{h, 2};
                DIRECTGOLib_Results{ii + jj, 3} = DIRECTGOLib_problems{h, 3};
                DIRECTGOLib_Results{ii + jj, 4} = jj;
            end
            break;
        end
    end
end

%% Loop over all prepared test problems:
for h = 2:size(DIRECTGOLib_Results, 1)
    % Extract info from the problem:
    [dim, fun, inst, xL, xU, ~, Xmin] = ExtractingInfo(DIRECTGOLib_Results, h);
    [~, M, shift] = compute_function(inst, dim, Xmin, xL, xU, fun);

    % Record algorithm performance results
    DIRECTGOLib_Results{h, 5} = M;
    DIRECTGOLib_Results{h, 6} = shift;
end

%% Store results:
save( 'DIRECTGOLib_settings_all.mat', 'DIRECTGOLib_Results' );

%% Extract info from the problem:
function [dim, fun, inst, xL, xU, Fmin, Xmin] = ExtractingInfo(DIRECTGOLib_Results, h)
    % Select dimension of the test problem
    dim = DIRECTGOLib_Results{h, 3}; 

    % Select the test problem
    fun = DIRECTGOLib_Results{h, 2}; 

    % Select instance
    inst = DIRECTGOLib_Results{h, 4}; 

    % Extract information from the test problem
    getInfo = feval(fun);

    % Bound constraints
    xL = getInfo.xl(dim);
    xU = getInfo.xu(dim);

    % Solution
    Fmin = getInfo.fmin(dim);
    Xmin = getInfo.xmin(dim);
end

function [Problem, M, shift] = compute_function(inst, dim, Xmin, xL, xU, fun)
    getInfo = feval(fun);
    xM = (xL + xU)/2;
    if getInfo.libraries(9) ~= 1 && getInfo.libraries(10) ~= 1
        if inst == 1 || inst == 2
            M = eye(dim);
            [shift_min, shift_max] = compute_shift_bounds(M,Xmin,xL,xU,xM,inst);
            rng(inst,'twister'); %seed inst for shift
            shift = (shift_min + 0.1*(shift_max - shift_min).*rand(dim,1));
        else
            M = compute_rotation(inst,dim); %seed inst for M
            [shift_min, shift_max] = compute_shift_bounds(M,Xmin,xL,xU,xM,inst);
            rng(inst,'twister');   %seed inst for shift
            shift = (shift_min + 0.1*(shift_max - shift_min).*rand(dim,1));
        end
        func = str2func(['@(x) ',fun,'(x)']);
        temp_vec = -M*shift - M*xM + xM;
        fun_rot = @(x) func(min(max(M*x + temp_vec,xL),xU));
        Problem.f = fun_rot;
    else
        if inst == 1 || inst == 2
            M = eye(dim);
            rng(inst,'twister'); %seed inst for shift
            shift = (xL + (xU - xL).*rand(dim,1));
        else
            M = compute_rotation(inst,dim); %seed inst for M
            rng(inst,'twister');   %seed inst for shift
            shift = (xL + (xU - xL).*rand(dim,1));
        end
        func = str2func(['@(x, shift, M) ',fun,'(x, shift, M)']);
        fun_rot = @(x) func(x, shift, M);
        Problem.f = fun_rot;
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

function [t_max] = shiftLP(M,Xmin,xL,xU,xM,shift_dir)
    options = optimoptions('linprog','Display','none');
    Aeq = [M,-M*shift_dir]; beq = Xmin+M*xM - xM;
    temp_max = linprog([0*Xmin;-1],[],[],Aeq,beq,[xL;-inf], [xU;inf],options);
    t_max = temp_max(end);
end

function [s] = shiftQP(M,Xmin,xL,xU,xM)
    options = optimoptions('quadprog','Display','none');
    dim = length(Xmin);
    H = diag([zeros(dim,1);ones(dim,1)]);
    Aeq = [M,-M]; beq = Xmin+M*xM - xM;
    temp_opt = quadprog(H,zeros(2*dim,1),[],[],Aeq,beq,[xL;-inf*ones(dim,1)], [xU;inf*ones(dim,1)],[],options);
    s = temp_opt (dim+1:end);
end

function [shift_min, shift_max] = compute_shift_bounds(M,Xmin,xL,xU,xM,inst)
    dim = length(Xmin);
    if norm(xM-Xmin) < 1e-3
           rng(inst,'twister');
           shift_dir = randn(dim,1);
           shift_min = (0*shift_dir);
           rng(inst,'twister');
           [t_max] = shiftLP(M,Xmin,xL,xU,xM,shift_dir);
           shift_max = t_max*shift_dir;
           rng(inst,'twister');
    else
        rng(inst,'twister');
        shift_dir = shiftQP(M,Xmin,xL,xU,xM);
        if norm(shift_dir) < 1e-3
            rng(inst,'twister');
            shift_dir = randn(dim,1);
            shift_min = (0*shift_dir);
        else
            shift_min = (1*shift_dir);
        end
        rng(inst,'twister');
        [t_max] = shiftLP(M,Xmin,xL,xU,xM,shift_dir);
        shift_max = t_max*shift_dir;
        rng(inst,'twister');
    end
end