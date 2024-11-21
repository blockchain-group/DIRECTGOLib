% -------------------------------------------------------------------------
% Script: The MATLAB script will cycle through all the box-constrained test 
%         problems in the DIRECTGOLib v2.0 in all five instances 
%         recommended in [1] and computes the 58 ELA landscape features 
%         using Flacco R [2], utilizing Rcall [3] to interface MATLAB and 
%         R. To mitigate bias in non-invariant ELA features,we employed the 
%         objective normalization technique proposed in [4].
%
% Created on: 07/31/2024
%
% Purpose: Compute the ELA landscape features 
%
% References
% [1] Stripinis, L., Kůdela, J., & R. Paulavičius, "Benchmarking 
%     Derivative-Free Global Optimization Algorithms Under Limited 
%     Dimensions and Large Evaluation Budgets." IEEE Transactions on 
%     Evolutionary Computation. DOI: 10.1109/TEVC.2024.3379756.
% [2] P. Kerschke and H. Trautmann, Comprehensive Feature-Based Land scape 
%     Analysis of Continuous and Constrained Optimization Problems Using 
%     the R-Package Flacco. Cham: Springer International Publishing, 2019, 
%     pp. 93–123.
% [3] Janine Egert and Clemens Kreutz (2022). Rcall 
%     (https://github.com/kreutz-lab/Rcall), GitHub. Retrieved 
%     January 11, 2022.
% [4] R. P. Prager and H. Trautmann, "Nullifying the inherent bias of 
%     non-invariant exploratory landscape analysis features," in 
%     International Conference on the Applications of Evolutionary 
%     Computation (Part of EvoStar). Springer, 2023, pp. 411–425.
%--------------------------------------------------------------------------

clear;clc;
%% Setup for ELA
% Maximum number of function evaluations
MaxEvals = 250;  % should also get multiplied by dimension later on

% Considered dimensions for scalable test functions
Dimensions = [2, 5, 10, 20];

% Considered number of instances - first two with shift only, other ones with shift and rotation
Instances = 5;

%% Path for test functions
parts = strsplit(pwd, filesep); parts(end-1:end) = []; parts{end + 1} = 'Box';  
parent_path = strjoin(parts(1:end), filesep); addpath(genpath(parent_path));
parts = strsplit(pwd, filesep); parts(end-1:end) = []; parts{end + 1} = 'Experimental_setup_data';  
parent_path = strjoin(parts(1:end), filesep); addpath(parent_path);

if not(isfolder('Rcall-master'))
    fullURL = 'https://github.com/kreutz-lab/Rcall/archive/refs/heads/master.zip';
    filename = 'files.zip';
    websave(filename, fullURL);
    unzip('files.zip');
    delete('files.zip')
end

Rinit({'flacco'},'C:\Program Files\R\R-4.2.2\bin\R.exe',[])

%% Load test functions:  
load('ListOfProblems.mat');
DIRECTGOLib_Features = DIRECTGOLib_problems(1, 1:2); 
DIRECTGOLib_Features{1, 3} = "Dimension"; 
DIRECTGOLib_Features{1, 4} = "Instance";
DIRECTGOLib_Features{1, 5} = "M"; 
DIRECTGOLib_Features{1, 6} = "Shift";

%% Prepare test functions:
for h = 2:size(DIRECTGOLib_problems, 1)
    for j = 1:length(Dimensions)
        ii = size(DIRECTGOLib_Features, 1);
        if length(DIRECTGOLib_problems{h, 3}) ~= 1
            if ismember(Dimensions(j),DIRECTGOLib_problems{h, 3})
                for jj=1:Instances
                    DIRECTGOLib_Features{ii + jj, 1} = ii;
                    DIRECTGOLib_Features{ii + jj, 2} = DIRECTGOLib_problems{h, 2};
                    DIRECTGOLib_Features{ii + jj, 3} = Dimensions(j);
                    DIRECTGOLib_Features{ii + jj, 4} = jj;
                end
            end
        elseif DIRECTGOLib_problems{h, 3} == 0
            for jj=1:Instances
                DIRECTGOLib_Features{ii + jj, 1} = ii;
                DIRECTGOLib_Features{ii + jj, 2} = DIRECTGOLib_problems{h, 2};
                DIRECTGOLib_Features{ii + jj, 3} = Dimensions(j);
                DIRECTGOLib_Features{ii + jj, 4} = jj;
            end
        else
            for jj=1:Instances
                DIRECTGOLib_Features{ii + jj, 1} = ii;
                DIRECTGOLib_Features{ii + jj, 2} = DIRECTGOLib_problems{h, 2};
                DIRECTGOLib_Features{ii + jj, 3} = DIRECTGOLib_problems{h, 3};
                DIRECTGOLib_Features{ii + jj, 4} = jj;
            end
            break;
        end
    end
end

%% Loop over all prepared test problems:
Drand = cell(20, 1);
for i = 1:20
    Drand{i} = rand(i, i*MaxEvals);
end

for i = 1:length(DIRECTGOLib_Features) - 1
    [X, y_true, M, shift] = ExtractingInfo(DIRECTGOLib_Features, i + 1, MaxEvals, Drand);

    % if one of the "y" vales is +Inf, the computation will crash, so I avoid them and put "NaN" in the features
    if max(y_true) == Inf
        for ii = 1:length(ela_names)
            DIRECTGOLib_Features{i + 1, 6 + ii} = NaN;
        end
        continue;
    end
    % Transformation from the paper [4]
    y = (y_true-min(y_true))/(max(y_true)-min(y_true)); 

    Rpush('X',X);
    Rpush('y',y);

    Rrun('feat.obj = createFeatureObject(X = X, y = y)')
    Rrun('feats.ela_distr = calculateFeatureSet(feat.object = feat.obj, set = "ela_distr")')
    Rrun('feats.ela_meta = calculateFeatureSet(feat.object = feat.obj, set = "ela_meta")')
    Rrun('feats.disp = calculateFeatureSet(feat.object = feat.obj, set = "disp")')
    Rrun('feats.nbc = calculateFeatureSet(feat.object = feat.obj, set = "nbc")')
    Rrun('feats.pca = calculateFeatureSet(feat.object = feat.obj, set = "pca")')
    Rrun('feats.ic = calculateFeatureSet(feat.object = feat.obj, set = "ic")')

    Rrun('val = 0')
    Rrun('iter = 0')

    Rrun('nr_elements = length(feats.ela_distr)')
    Rrun('ela_names = names(feats.ela_distr)')
    Rrun('for (i in 1:length(feats.ela_distr)) {iter = iter + 1; b = feats.ela_distr[i]; val[iter] = b[[1]]}; ela_names[iter] = names(feats.ela_distr[i])')

    Rrun('ela_names = append(ela_names,names(feats.ela_meta))')
    Rrun('nr_elements = append(nr_elements,length(feats.ela_meta))')
    Rrun('for (i in 1:length(feats.ela_meta)) {iter = iter + 1; b = feats.ela_meta[i]; val[iter] = b[[1]]}')

    Rrun('ela_names = append(ela_names,names(feats.disp))')
    Rrun('nr_elements = append(nr_elements,length(feats.disp))')
    Rrun('for (i in 1:length(feats.disp)) {iter = iter + 1; b = feats.disp[i]; val[iter] = b[[1]]}')

    Rrun('ela_names = append(ela_names,names(feats.nbc))')
    Rrun('nr_elements = append(nr_elements,length(feats.nbc))')
    Rrun('for (i in 1:length(feats.nbc)) {iter = iter + 1; b = feats.nbc[i]; val[iter] = b[[1]]}')

    Rrun('ela_names = append(ela_names,names(feats.pca))')
    Rrun('nr_elements = append(nr_elements,length(feats.pca))')
    Rrun('for (i in 1:length(feats.pca)) {iter = iter + 1; b = feats.pca[i]; val[iter] = b[[1]]}')

    Rrun('ela_names = append(ela_names,names(feats.ic))')
    Rrun('nr_elements = append(nr_elements,length(feats.ic))')
    Rrun('for (i in 1:length(feats.ic)) {iter = iter + 1; b = feats.ic[i]; val[iter] = b[[1]]}')

    try
        ela_vals = Rpull('val');
    catch ME
        ela_vals = ela_vals*NaN;
        Rclear
        Rinit({'flacco'},'C:\Program Files\R\R-4.2.2\bin\R.exe',[])
    end

    if i == 1
        ela_names = Rpull('ela_names');
        nr_ela_elements = Rpull('nr_elements');
        for ii=1:length(ela_names)
            DIRECTGOLib_Features{1, 6+ii} = ela_names{ii};
            DIRECTGOLib_Features{i+1,6+ii} = ela_vals(ii);
        end
    else
        for ii=1:length(ela_names)
            DIRECTGOLib_Features{i+1,6+ii} = ela_vals(ii);
        end
    end
    DIRECTGOLib_Features{i+1,5} = M;
    DIRECTGOLib_Features{i+1,6} = shift;
    save ela_features.mat DIRECTGOLib_Features nr_ela_elements;
end
Rclear

%% Find suitible features and instances

% remove problems with NaN or -Inf values
temp = cell2mat(DIRECTGOLib_Features(2:end,7:end));
ids_prob = ~isnan(temp(:,1));
sel_problems = temp(ids_prob,:);

% remove features with 0 variance
ids_feat = (std(sel_problems) ~= 0) & ~(contains(DIRECTGOLib_Features(1,7:end),'time')) ...
    & ~(contains(DIRECTGOLib_Features(1,7:end),'cov_x')) & ~(contains(DIRECTGOLib_Features(1,7:end),'cor_x')) & ...
    ~any(sel_problems(:, 1:end) == -Inf); %#ok<*FNCOLND>
sel_vals = sel_problems(:,ids_feat);

% remove correlated features
C = corr(sel_vals);
to_remove = [];
for i=1:sum(ids_feat)
    temp = find(C(:,i) >= 0.95 & (1:sum(ids_feat))' > i);
    to_remove = [to_remove;temp]; %#ok<*AGROW>
end
to_remove = unique(to_remove);

ids_final = 1:sum(ids_feat); ids_final(to_remove) = [];
sel_final = sel_vals(:,ids_final);
sel_problem_info = DIRECTGOLib_Features(2:end,1:6);
DIRECTGOLib_ELA = DIRECTGOLib_Features(1, 1:6); 
DIRECTGOLib_ELA{1, 7} = "Fmin"; 
DIRECTGOLib_ELA{1, 8} = "History"; 
DIRECTGOLib_ELA{1, 9} = "Fbest"; 
DIRECTGOLib_ELA{1, 10} = "Xbest";
DIRECTGOLib_ELA(2:sum(ids_prob)+1, 1:6) = sel_problem_info(ids_prob,:);

% normalize data
data_norm = normalize(sel_final);
logidx = find(max(data_norm) - min(data_norm) > 10);
data_norm(:, logidx) = cell2mat(arrayfun(@(x) sign(data_norm(:, x)).*log( abs(data_norm(:, x)) + 1 ), logidx, 'UniformOutput', false));

save data_norm.mat data_norm;
save DIRECTGOLib_ELA.mat DIRECTGOLib_ELA;

%% Function block

function [X, y_true, M, shift] = ExtractingInfo(DIRECTGOLib_Features, h, MaxEvals, Drand)
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
    
    [Problem, M, shift] = compute_function(inst, dim, Xmin, xL, xU, fun);

    X = (abs(xU - xL).*cell2mat(Drand(dim)) + xL)';
    y_true = arrayfun(@(j) feval(Problem, X(j, :)'), 1:MaxEvals*dim)';
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