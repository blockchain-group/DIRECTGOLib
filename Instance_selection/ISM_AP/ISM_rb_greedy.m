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
Instances_to_select = 250;

%% Path for test functions and algorithm performance data
parts = strsplit(pwd, filesep); parts(end-1:end) = []; parts{end + 1} = 'Box';  
parent_path = strjoin(parts(1:end), filesep); addpath(genpath(parent_path));

%% Select instances
% Get algorithm performance data
if ~exist('DIRECTGOLib_Results_perf.mat', 'file')
    Performance_data;
end

% Load algorithm performance data
load('DIRECTGOLib_Results_perf.mat');

% Easy/hard problems
nr_solved = zeros(4035,6); 
% Highly conditioning problems
max_rel_err = zeros(4035,6);
for i=1:4035
    temp_matrix = DIRECTGOLib_Results_perf{i+1,9};
    nr_solved(i,:) = sum(temp_matrix <= 1e-4);
    max_rel_err(i,:) = max(temp_matrix);
end

% not impossible to solve & not too easy & not highly conditioned 
ids = find(nr_solved(:,end) > 0 & nr_solved(:,3) < size(DIRECTGOLib_Results_perf{2, 8}, 1) & max_rel_err(:,1) < 1e10);
subselection_DIR = DIRECTGOLib_Results_perf([1;ids+1],:);
subselection_nrs = nr_solved(ids,:);

% computation of the similarity between the problems
simil = zeros(length(ids));
rel_thresh = 1e-4;
for i=1:length(ids)
    M1 = subselection_DIR{i+1,9}; 
    for ii=i+1:length(ids)
        M2 = subselection_DIR{ii+1,9}; 
        simil(i,ii) = compute_mat_similarity(rel_thresh, M1, M2);
    end
end
% adding large value on the diagonal (it has zeros otherwise), makes the code simpler
simil = simil+simil' + 1e5*eye(length(ids)); 

% used - minimum similarity between the instances
m_s = min(simil,[],1); 

% find problem with largest minimum similarity
[maxval,maxpos] = max(m_s); 

% set the found problem as the first one in the ranking
ranking = maxpos; 
all_ids = 1:length(ids);
% remove the problem from the unused indexes
rest_ids = setdiff(all_ids,ranking);

while length(ranking) <= Instances_to_select
    m_s = min(simil(ranking,rest_ids),[],1); 
    [temp1,temp2] = max(m_s);
    ranking(end+1,1) = rest_ids(temp2); %#ok<*SAGROW>
    rest_ids = setdiff(rest_ids,rest_ids(temp2));
end
DIRECTGOLib_Results = subselection_DIR([1;ranking+1],1:7); 
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
save( 'DIRECTGOLib_settings_rb.mat', 'DIRECTGOLib_Results' );

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

function Performance_data
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

%load algs results, runs without LPSR/parameter control
sel_algs_det = {'OQNLP','I_DTC_GL','DIRMIN','DE'};

for i=1:length(sel_algs_det)
    str = strcat('Result_',sel_algs_det{i},'.mat');
    load(str); %#ok<*LOAD>
    eval(strcat('Res_',sel_algs_det{i},'=[];'));
    base_budgets = [1e2,1e3,5e3,1e4,5e4];
    for ii=1:length(base_budgets)
        y = get_sol_budget(DIRECTGOLib_Results,base_budgets(ii)); %#ok<*NASGU,*USENS>
        eval(strcat('Res_',sel_algs_det{i},'(:,ii)=y;'));
    end
    y = real(arrayfun(@(j) DIRECTGOLib_Results{j, 8}(end, 3), 2:size(DIRECTGOLib_Results, 1)));
    eval(strcat('Res_',sel_algs_det{i},'(:,ii+1)=y;'));
end

%load algs results, runs with LPSR/parameter control
sel_algs_sto = {'APGSK_IMODE','EA4eig','EBO','ELSHADE'};
for i=1:length(sel_algs_sto)
    eval(strcat('Res_',sel_algs_sto{i},'=[];'));
    base_budgets_str = {'_1e2','_1e3','_5e3','_1e4','_5e4'};
    for ii=1:length(base_budgets_str)
        str = strcat('Result_',sel_algs_sto{i},base_budgets_str{ii},'.mat');
        load(str);
        y = real(vertcat(DIRECTGOLib_Results{2:end,9}));
        eval(strcat('Res_',sel_algs_sto{i},'(:,ii)=y;'));
    end
    str = strcat('Result_',sel_algs_sto{i},'.mat');
    load(str);
    y = real(arrayfun(@(j) DIRECTGOLib_Results{j, 8}(end, 3), 2:size(DIRECTGOLib_Results, 1)));
    eval(strcat('Res_',sel_algs_sto{i},'(:,ii+1)=y;'));
end

nr_det_alg = length(sel_algs_det);
nr_sto_alg = length(sel_algs_sto);
DIRECTGOLib_Results_perf = DIRECTGOLib_Results(:,1:7);
DIRECTGOLib_Results_perf{1,8} = 'perf_matrix_abs';
DIRECTGOLib_Results_perf{1,9} = 'perf_matrix_relative';
DIRECTGOLib_Results_perf{1,10} = 'best_relative_sol';
for i=1:4035
    fval = DIRECTGOLib_Results_perf{i+1,7};
    temp_matrix = zeros(nr_det_alg+nr_sto_alg,6);
    for ii=1:nr_det_alg
        eval(strcat('tempval=','Res_',sel_algs_det{ii},'(',num2str(i),',:);'));
        temp_matrix(ii,:) = tempval;
    end
    for ii=1:nr_sto_alg
        eval(strcat('tempval=','Res_',sel_algs_sto{ii},'(',num2str(i),',:);'));
        temp_matrix(nr_det_alg+ii,:) = tempval;
    end
    DIRECTGOLib_Results_perf{i+1,8} = temp_matrix-fval;
    temp_matrix = compute_relative_sol(temp_matrix,fval);
    DIRECTGOLib_Results_perf{i+1,9} = temp_matrix;
    DIRECTGOLib_Results_perf{i+1,10} = min(min(temp_matrix));
end

save DIRECTGOLib_Results_perf.mat DIRECTGOLib_Results_perf;
end

function y = compute_relative_sol(matrix,fval)
    if fval == 0
        y = matrix;
    else
        y = (matrix-fval)/abs(fval);
    end
end

function y = get_sol_budget(res_file,base_budget)
    [m,~] = size(res_file);
    y = zeros(m-1,1);
    for i=1:m-1
        dim = res_file{i+1,3};
        budget = base_budget*dim;
        hist = res_file{i+1,8};
        ids = find(hist(:,2) <= budget);
        if isempty(ids)
            y(i) = hist(1,3);
        else
            y(i) = hist(ids(end),3);
        end
    end
end

function val = compute_mat_similarity(rel_thresh, M1, M2)
    M1_mod = max(M1,rel_thresh);
    M2_mod = max(M2,rel_thresh);
    val = norm(log(M1_mod) - log(M2_mod));
end