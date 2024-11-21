% -------------------------------------------------------------------------
% Script: The MATLAB script will cycle through all the box-constrained test 
%         problems in the DIRECTGOLib v2.0 in all five instances 
%         recommended in [1]. Then, a defined number of instances will be 
%         selected utilizing method proposed in [2].
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
% [2] Stripinis, L., Kůdela, J., & R. Paulavičius, "New Algorithm 
%     Performance-based Strategies for Benchmark Function Selection in 
%     Continuous Global Optimization." IEEE Transactions on Cybernetics
%--------------------------------------------------------------------------

% Clear workspace, close all figures, and clear command window
clear;clc;close all;

%% Setup for ELA
% The desired number of instances
a_threshold = 0.5; % (0, 1)

% Allowable relative error if globalmin is set
rel_err_thresh = 1e-2;

%% Path for test functions and algorithm performance data
parts = strsplit(pwd, filesep); parts(end-1:end) = []; parts{end + 1} = 'Box';  
parent_path = strjoin(parts(1:end), filesep); addpath(genpath(parent_path));
parts = strsplit(pwd, filesep); parts(end) = []; parts{end + 1} = 'Compute_ELA';  
parent_path = strjoin(parts(1:end), filesep); addpath(parent_path);

%% Select instances
% Load normalized ELA landscape features 
load('data_norm.mat')
load('DIRECTGOLib_ELA.mat')

% Get algorithm performance data
if ~exist('P_values.mat', 'file')
    P_values = Performance_data(DIRECTGOLib_ELA, MaxFE, rel_err_thresh);
else
    % Load algorithm performance data
    load('P_values.mat');
end

% Performs Benjamini-Hochberg correction on a matrix of p-values
P_values = BH_correction(P_values);

% Settings for the SA algorithm
maxIter = 5e2;
Runs = 10;
Sz = size( data_norm, 1 );
all_ids = 1:Sz;

% Calculate the pairwise distances between samples in the ELA space
distances = pdist2( data_norm, data_norm );
distances( eye( size( distances ) ) == 1 ) = inf;

% Initialize the graph based on the "a_threshold"
G = true( Sz );
Idx = P_values <= a_threshold;
G( Idx ) = false;

% Initial solution for SA algorithm
x0 = deal( false(Sz, 1) );
x0(randperm(Sz, randi(Sz))) = true;

% Run SA algorithm
f_best = zeros(1, Runs);
x_best = false(Sz, Runs);
for k = 1:Runs
    [ x_best(:, k), f_best(k) ] = simAnnealBin( x0, maxIter, G, distances );
end
[ f_best, idx ] = min( f_best );
represent = all_ids(x_best(:, idx)) + 1;

DIRECTGOLib_Results = DIRECTGOLib_ELA([1, represent], :);
DIRECTGOLib_Results{1, 8} = "History"; 
DIRECTGOLib_Results{1, 9} = "Fbest"; 
DIRECTGOLib_Results{1, 10} = "Xbest";

%% Loop over all prepared test problems:
for i = 1:length(DIRECTGOLib_Results) - 1
    [M, shift] = ExtractingInfo(DIRECTGOLib_Results, i + 1);
    DIRECTGOLib_Results{i+1,5} = M;
    DIRECTGOLib_Results{i+1,6} = shift;
end

% Save the results to a MAT-file
save( 'DIRECTGOLib_settings_ped.mat', 'DIRECTGOLib_Results' );

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

function P_values = Performance_data(R2, MaxFE, Error)
% -------------------------------------------------------------------------
% Script: Script for getting the data about algorithm performance on the 
%         whole DIRECTGOLib, choosing different algorithms will result in 
%         different ranking of the problems (in terms of alg. performance)
%
% Created on: 07/31/2024
%--------------------------------------------------------------------------
if not(isfolder('Result_files'))
    fullURL = 'https://zenodo.org/records/10201845/files/Result_files.zip?download=1';
    filename = 'files.zip';
    websave(filename, fullURL);
    unzip('files.zip');
    delete('files.zip')
end
parts = strsplit(pwd, filesep); parts{end + 1} = 'Result_files';  
parent_path = strjoin(parts(1:end), filesep); addpath(genpath(parent_path));


% Convert cells to tables if they contain mixed data types
load("Result_DE.mat");
T1 = cell2table(DIRECTGOLib_Results(2:end, 2:4)); %#ok<*USENS>
T2 = cell2table(R2(2:end, 2:4));

% Find the indices
[~, ids_prob] = ismember(T2, T1, 'rows');
ids_prob = ids_prob + 1;
N = length(ids_prob);
Ovl = cell2mat(DIRECTGOLib_Results(ids_prob, 7));
Dim = cell2mat(DIRECTGOLib_Results(ids_prob, 3));
Ovl2 = arrayfun(@(x) (1 + sign( Ovl(x) ) * Error/100) * Ovl(x) + (Ovl(x) == 0) * Error/100, 1:length(Ovl) );
[M1, M2] = deal(zeros(23, N));

%load algs results, runs without LPSR/parameter control
sel_algs_det = {'DE','EBO','EA4eig','APGSK_IMODE','I_DTC_GL','OQNLP',...
    'MCS','LGO','DIRMIN','ELSHADE','BFGS','BOBYQA','PSO','LSHADE','HSES',...
    'AGSK','BIRMIN','glcCluster','CMAES','COBYLA','NM','SID_PSM','NMSO'};

for i=1:length(sel_algs_det)
    str = strcat('Result_',sel_algs_det{i},'.mat');
    load(str); %#ok<*LOAD>
    s = arrayfun(@(x) find(DIRECTGOLib_Results{ids_prob(x), 8}(:, 3) <= Ovl2(x), 1, "first"), 1:N, 'UniformOutput', false);
    M1(i, :) = arrayfun(@(x) val1(s{x},Dim(x),MaxFE,DIRECTGOLib_Results{ids_prob(x), 8}(:, 2)), 1:N);
    M2(i, :) = arrayfun(@(x) val2(s{x},Error/100,Ovl(x),DIRECTGOLib_Results{ids_prob(x), 8}(:, 3),DIRECTGOLib_Results{ids_prob(x), 8}(:, 2),M1(i,x)), 1:N);
end

P_values = eye( N );
for y1 = 1:N
    for y2 = (y1 + 1):N
        % observations are paired
        p1 = signrank(M1(:, y1), M1(:, y2));
        p2 = signrank(M2(:, y1), M2(:, y2));
        [P_values(y1, y2), P_values(y2, y1)] = deal(min(p1, p2));
    end
end

save P_values.mat P_values;
end

function y = val1(s, n, m, R)
    if ~isempty(s)
        y = R(s);
    else
        y = n*m;
    end
end

function y = val2(s, e, o, R, M, t)
    if ~isempty(s)
        y = e;
    else
        x = find(M <= t);
        if o == 0
            y = R(x(end));
        else
            y = (R(x(end)) - o)/abs(o);
        end
    end
end

function Cor_pvals = BH_correction(pvals)
    % Benjamini-Hochberg correction on a vector of p-values.
    m = size( pvals, 1 );
    Cor_pvals = eye( m );
    Temp = [];
    for i = 1:m
        for j = i + 1:m
            Temp(end + 1) = pvals(i, j); %#ok<*AGROW>
        end
    end
    mm = length( Temp );

    % Benjamini-Hochberg correction on a vector of p-values
    [sorted_pvals, idx] = sort( Temp );
    rank = (1:mm)';
    corrected_pvals = sorted_pvals' .* (mm ./ rank);

    % Ensure the corrected p-values are non-decreasing
    corrected_pvals = min( 1, corrected_pvals );
    for i = mm-1:-1:1
        corrected_pvals(i) = min( corrected_pvals(i), corrected_pvals(i + 1) );
    end

    % Return to original order
    corrected_pvals(idx) = corrected_pvals;
    h = 0;
    for i = 1:m
        for j = i + 1:m
            h = h + 1;
            Cor_pvals(i, j) = corrected_pvals(h);
            Cor_pvals(j, i) = corrected_pvals(h);
        end
    end
end

function [ x_best, f_best ] = simAnnealBin( x_new, maxIter, Pvals_Array, Dist_Array )       
    T = flip( logspace( -3, -2, 100 ) ); % Initial temperature
    T(end) = -1;
    m = 1;
    t = T(1);

    tic; % Time
    N = length(x_new);
    [f_new, x_new] = ObjFun( x_new, Pvals_Array, Dist_Array, N );

    % Best solution found so far
    x_best = x_new; 
    f_best = f_new; 
    f_b2 = f_new;
    
    while t > 0 % Until temperature is above zero
        for k = 1:maxIter % Do maxIter iterations at temperature T
            x_old = x_new; 
            f_old = f_new; % Preserve previous solution
            
            % Noise operator inside the objective function
            [f_new, x_new] = ObjFun( x_new, Pvals_Array, Dist_Array, N );
            if f_new <= f_old % Better solution => new one is preserved
                if f_new < f_best % Better than the best => save
                    f_best = f_new;
                    x_best = x_new;
                end   
            elseif exp((f_old - f_new) / t) < rand
                % Metropolis criterion not fulfilled => back to previous solution
                f_new = f_old; 
                x_new = x_old;
            end
        end
        disp(['Temperature: ', num2str(t, '%2.4f'), ' Diversity: ', num2str(f_best, '%4.4f'), ' Time: ', num2str(toc, '%4.4f'), ' Nodes: ', num2str(sum(x_best))]);
        if f_b2 == f_best
            m = m + 1; t = T(m);
        else
            f_b2 = f_best;
        end
    end
end

function [Value, x] = ObjFun( x, Pvals_Array, Dist_Array, N )
    Covered = false( 1, N );
    II = find( x )';
    U = find( ~x )';
    xx = randi([1 length(II)],1,1);
    x(II(xx)) = false;
    II(xx) = [];
    yy = U(randi([1 length(U)],1,1));
    x(yy) = true;
    II = [yy, II];

    % Check solution
    for i = II
        if ( ~Covered( i ) )
            Covered( Pvals_Array(:, i) ) = true;
        else
            x(i) = false;
        end
    end
    
    % Fix solution
    if ~all( Covered )
        while ~all( Covered )
            [~, I] = max( min( Dist_Array(x, ~Covered), [], 1 ) );
            II = find( ~Covered );
            x(II(I)) = true;
            Covered( Pvals_Array(:, II(I)) ) = true;
        end
    end
    Value = -mean( min( Dist_Array(x, x) ) );
end