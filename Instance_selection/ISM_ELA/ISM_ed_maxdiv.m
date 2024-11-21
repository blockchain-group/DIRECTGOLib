% -------------------------------------------------------------------------
% Script: The MATLAB script will cycle through all the box-constrained test 
%         problems in the DIRECTGOLib v2.0 in all five instances 
%         recommended in [1]. Then, a defined number of instances will be 
%         selected utilizing method proposed in[2].
%
% Created on: 07/31/2024
%
% Purpose: Selection of the representative instances
%
% References
% [1] Stripinis, L., Kůdela, J., & R. Paulavičius, "Benchmarking 
%     Derivative-Free Global Optimization Algorithms Under Limited 
%     Dimensions and Large Evaluation Budgets." IEEE Transactions on 
%     Evolutionary Computation. DOI: 10.1109/TEVC.2024.3379756.
% [2] Gleixner, A., Hendel, G., Gamrath, G. et al. MIPLIB 2017: data-driven 
%     compilation of the 6th mixed-integer programming library. Math. Prog. 
%     Comp. 13, 443–490 (2021). https://doi.org/10.1007/s12532-020-00194-3
%--------------------------------------------------------------------------

% Clear workspace, close all figures, and clear command window
clear;clc;close all;

%% Setup for ELA
% The desired number of instances
Instances_to_select = 10;

%% Path for test functions
parts = strsplit(pwd, filesep); parts(end-1:end) = []; parts{end + 1} = 'Box';  
parent_path = strjoin(parts(1:end), filesep); addpath(genpath(parent_path));
parts = strsplit(pwd, filesep); parts(end-1:end) = []; parts{end + 1} = 'Experimental_setup_data';  
parent_path = strjoin(parts(1:end), filesep); addpath(parent_path);
parts = strsplit(pwd, filesep); parts(end) = []; parts{end + 1} = 'Compute_ELA';  
parent_path = strjoin(parts(1:end), filesep); addpath(parent_path);

%% Select instances
% Load normalized ELA landscape features 
load('data_norm.mat')
load('DIRECTGOLib_ELA.mat')

% Runs the maximum number of iterations for SA
maxIter = 5e2;
Runs = 10;
Sz = size( data_norm, 1 );
all_ids = 1:Sz;

% Calculate the pairwise distances between samples in the ELA space
distances = pdist2( data_norm, data_norm );
distances( eye( size( distances ) ) == 1 ) = NaN;

% Define function
fobj = @(x) ObjFun(x, distances);
% Initial solution
x0 = false(Sz, 1);
x0(randperm(Sz, Instances_to_select)) = true;

% Run simAnnealBin algorithm
f_best = zeros(1, Runs);
x_best = false(Sz, Runs);
for k = 1:Runs
    [ x_best(:, k), f_best(k) ] = simAnnealBin( fobj, x0, maxIter );
end
[ f_best, idx ] = min( f_best );
represent = all_ids(x_best(:, idx)) + 1;

DIRECTGOLib_Results = DIRECTGOLib_ELA([1, represent], :);

%% Loop over all prepared test problems:
for i = 1:length(DIRECTGOLib_Results) - 1
    [M, shift] = ExtractingInfo(DIRECTGOLib_Results, i + 1);
    DIRECTGOLib_Results{i+1,5} = M;
    DIRECTGOLib_Results{i+1,6} = shift;
end

% Save the results to a MAT-file
save( 'DIRECTGOLib_settings_ed.mat', 'DIRECTGOLib_Results' );

%% Function block
function [M, shift] = ExtractingInfo(DIRECTGOLib_Features, h)
    % Select dimension of the test problem
    dim = DIRECTGOLib_Features{h, 3}; 

    % Select the test problem
    fun = DIRECTGOLib_Features{h, 2}; 
    
    % Select instance
    inst = DIRECTGOLib_Features{h, 4}; 

    % Extract information from the test problem
    getInfo = feval(fun);

    % Bound constraints
    xL = getInfo.xl(dim);
    xU = getInfo.xu(dim);

    % Solution
    Xmin = getInfo.xmin(dim);
    
    [~, M, shift] = compute_function(inst, dim, Xmin, xL, xU, fun);
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
        Problem = fun_rot;
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
        Problem = fun_rot;
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

%--------------------------------------------------------------------------
% Objective function
%--------------------------------------------------------------------------
function Value = ObjFun( x, Dist_Array )
    Value = -mean( min( Dist_Array(x, x), [], 2 ) );
end

%--------------------------------------------------------------------------
% Simulated annealing for binary optimization
%--------------------------------------------------------------------------
function [ x_best, f_best ] = simAnnealBin( f, x0, maxIter )
% Initial temperature
T = flip( logspace( -3, -1, 1000 ) ); T(end) = -1;  m = 1;  t = T(1);

% Time
tic;

% Initial solution
[f_new, f_improve, f_best] = deal( f(x0) );
[x_best, x_new] = deal( x0 );

% Loop until temperature is above zero
while t > 0
    % Do maxIter iterations at temperature T
    for k = 1:maxIter
        % Preserve previous solution
        x_old = x_new;
        f_old = f_new;

        % Select two indices randomly with equality constraints:
        V = find( x_new );
        U = find( ~x_new );
        I = [V(randi( [1, length( V )], 1, 1 )), U(randi( [1, length( U )], 1, 1 ))];

        % Swap the bits at the two indices
        x_new(I) = 1 - x_new(I);

        % New solution objective function evaluation
        f_new = f(x_new); 

        % Better solution => new one is preserved
        if ( f_new <= f_old )

            % Better than the best => save
            if ( f_new < f_best )
                f_best = f_new; x_best = x_new;
            end

        elseif ( exp( (f_old - f_new) / t ) < rand )

            % Metropolis criterion not fulfilled => back to previous solution
            f_new = f_old; x_new = x_old;

        end
    end

    % Display
    disp(['Temperature: ', num2str(t, '%2.4f'), ' Diversity: ', num2str(f_best, '%4.4f'), ' Time: ', num2str(toc, '%4.4f')]);
    
    % Reduce temperature if solution not improved
    if f_improve == f_best
        m = m + 1; t = T(m);
    else
        f_improve = f_best;
    end
end
end
%--------------------------------------------------------------------------