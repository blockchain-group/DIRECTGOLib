% -------------------------------------------------------------------------
% Script: The MATLAB script will cycle through the selected instances using
%         the DIRECT algorithm [1] taken from [2].
%
% Created on: 07/31/2024
%
% Purpose: Loops  through the selected instances from DIRECTGOLib v2.0
%
% References
% [2] D. R. Jones, C. D. Perttunen, and B. E. Stuckman, "Lipschitzian
%     optimization without the Lipschitz constant." Journal of Optimization
%     Theory and Application, vol. 79, no. 1, pp. 157–181, 1993. 
%     DOI: 10.1007/BF00941892
% [3] L. Stripinis and R. Paulavičius, "DIRECTGO: "A new DIRECT-type MATLAB
%     toolbox for derivative-free global optimization." ACM Transactions on 
%     Mathematical Software, vol. 48, no. 4, dec 2022. DOI 10.1145/3559755
%--------------------------------------------------------------------------

clear;clc;
%% Experimental Setup
% Maximum number of function evaluations
MaxEvals = 1e5;  % should also get multiplied by dimension later on

% Maximum number of iterations
MaxIts = 10^6; 

% Maximum CPU time
MaxCPUTime = 600; 

% Allowable relative error if globalmin is set
Perror = 1e-2;

%% Path for test functions
if not(isfolder('DIRECTGO-main'))
    fullURL = 'https://github.com/blockchain-group/DIRECTGO/archive/refs/heads/main.zip';
    filename = 'files.zip';
    websave(filename, fullURL);
    unzip('files.zip'); 
    delete('files.zip')
end

% Load path to algorithms:
parts = strsplit(pwd, filesep); parts{end + 1} = 'DIRECTGO-main'; 
parts{end + 1} = 'Algorithms'; 
parent_path = strjoin(parts(1:end), filesep); addpath(parent_path); 

% Load paths to test problems:
parts = strsplit(pwd, filesep); parts(end) = []; parts{end + 1} = 'Box';  
parent_path = strjoin(parts(1:end), filesep); addpath(genpath(parent_path));

if not(isfolder('Results'))
    mkdir('Results');
end

%% Load instances:  
load('DIRECTGOLib_settings_all.mat');

%% Loop over all prepared test problems:
for h = 2:size(DIRECTGOLib_Results, 1)
    % Extract info from the problem:
    [dim, fun, inst, xL, xU, Fmin, Xmin, M, shift] = ExtractingInfo(DIRECTGOLib_Results, h);
    Problem = compute_function(xL, xU, fun, M, shift);
    opts.dimension  = dim;
    opts.globalmin  = Fmin;
    opts.maxevals   = MaxEvals*dim;    % max number of function calls
    opts.maxits     = MaxEvals*dim;    % max number of iterations
    opts.tol        = Perror;          % relative tolerance threshold
    opts.showits    = 1;               % show iterations
    opts.testflag   = 1;
    Bounds = [xL, xU];

    [fbest, xatmin, history] = dDirect(Problem, opts, Bounds);

    % Record algorithm performance results
    DIRECTGOLib_Results{h, 7} = Fmin;
    DIRECTGOLib_Results{h, 8} = history;
    DIRECTGOLib_Results{h, 9} = fbest;
    DIRECTGOLib_Results{h, 10} = xatmin;
end
%% Store results:
p=strsplit(pwd,filesep); p{end+1}='Results'; p{end+1}='Result_File';
pp=strjoin(p(1:end),filesep);
save(pp,'DIRECTGOLib_Results')

%% Extract info from the problem:
function [dim, fun, inst, xL, xU, Fmin, Xmin, M, shift] = ExtractingInfo(DIRECTGOLib_Results, h)
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
    
    % Shift and rotation
    M = DIRECTGOLib_Results{h, 5};
    shift  = DIRECTGOLib_Results{h, 6};
end

function Problem = compute_function(xL, xU, fun, M, shift)
    getInfo = feval(fun);
    xM = (xL + xU)/2;
    if getInfo.libraries(9) ~= 1 && getInfo.libraries(10) ~= 1
        func = str2func(['@(x) ',fun,'(x)']);
        temp_vec = -M*shift - M*xM + xM;
        fun_rot = @(x) func(min(max(M*x + temp_vec,xL),xU));
        Problem.f = fun_rot;
    else
        func = str2func(['@(x, shift, M) ',fun,'(x, shift, M)']);
        fun_rot = @(x) func(x, shift, M);
        Problem.f = fun_rot;
    end
end