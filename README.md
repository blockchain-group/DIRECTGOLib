# DIRECTGOLib - DIRECT Global Optimization test problems Library

![languages](https://img.shields.io/badge/language-MATLAB,R-blue)  ![release](https://img.shields.io/badge/release-v2.0-blue)  ![OS](https://img.shields.io/badge/OS-windows,linux,macOS-blue)  ![License](https://img.shields.io/badge/License-MIT-blue)  ![contributions](https://img.shields.io/badge/contributions-welcome-greene)

## Table of Contents

- [About](#about)
- [Documentation](#documentation)
  - [Classification of Problems](#classification-of-problems)
  - [Composition of Library](#composition-of-library)
  - [Structure and Syntax](#structure-and-syntax)
  - [Example of the Initialization of Experimental Settings](#example-of-the-initialization-of-experimental-settings)
  - [Selection of Representative Instances](#selection-of-representative-instances)
- [Cite Library](#cite-library)
- [Feedback and Contributions](#feedback-and-contributions)
- [Changelogs](#changelogs)
  - [v2.0 - (2024-09-01)](#v2.0-(2024-09-01))
  - [v1.3 - (2023-06-15)](#v1.3-(2023-06-15))
  - [v1.2 - (2022-06-06)](#v1.2-(2022-06-06))
  - [v1.1 - (2022-04-26)](#v1.1-(2022-04-26))
- [References](#references)

---

## About

An online collection called **DIRECTGOLib** stands as **DIRECT** **G**lobal **O**ptimization test problems **Lib**rary. The library presents a valuable collection of practical and test problems involving continuous variables. Initially the library created for benchmarking various DIRECT-type methods, but its current scope is suitable for any global optimization methods. Its main objective is to assist in creating and testing various numerical solvers for a wide range of global optimization problems. 

The **DIRECTGOLib** is an actively maintained open-source *GitHub* repository regularly updated with new problems from various optimization domains. All functions included have been thoroughly reviewed and corrected for errors such as specified wrong global minimum values or their locations, incorrect specifications of features and improper problem formulations. In addition, some measures have been taken into account to find exact duplicates or very similar functions. The library is entirely coded in the *MATLAB* programming language, ensuring accessibility and user-friendliness for the optimization community.

The last version of **DIRECTGOLib v2.0**, is an updated version that builds upon the success of its predecessor, **DIRECTGOLib v1.3**. This latest iteration incorporates extensive expansion and restructuring efforts to ensure improved representation and better alignment with the current demands of testing global optimization algorithms.

---

## Documentation

### Classification of Problems

Continuous global optimization problems from **DIRECTGOLib** are classified as follows:

- [Box-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Box) (324 problems in total)
- [Linearly-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Linear) (67 problems in total)
- [Generally-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/General) (39 problems in total)

- [Engineering problems](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Engineering) (53 problems in total)


We also separate problems coming from practical applications, which may involve various types of constraint functions.

### Composition of Library

The problem library is a comprehensive collection of test problems gathered from various sources, ensuring a diverse range of scenarios and challenges. While there are numerous sources contributing to the library, there are a few that play a pivotal role in shaping its content. Users can refer to the respective problem's *MATLAB* file for any references not explicitly provided for further information and details.

To provide an overview of the library's composition, the following table presents the number of essential parts that constitute its core:

| \#   | Identifier                                                   | References             | Year | Problems | Problem Type                   |
| ---- | ------------------------------------------------------------ | ---------------------- | ---- | -------- | ------------------------------ |
| 1    | Global Optimization Test Problems - Hedar list               | Hedar[^1]              | 2005 | 31       | Box-constrained                |
| 2    | Virtual Library of Simulation Experiments - Test Functions and Datasets | Surjanovic et al.,[^2] | 2013 | 50       | Box-constrained                |
| 3    | Hard benchmark functions for global optimization             | Layeb,[^8]             | 2022 | 18       | Box-constrained                |
| 4    | Global Optimization Benchmarks                               | Gavana,[^13]           | 2013 | 193      | Box-constrained                |
| 5    | A literature survey of benchmark functions for global optimization problems | Jamil et al.,[^12]     | 2013 | 167      | Box-constrained                |
| 6    | Real-parameter black-box optimization benchmarking 2009: Noiseless functions definitions - BBOB | Hansen et al.,[^5]     | 2009 | 24       | Box-constrained                |
| 7    | Test functions for global optimization algorithms            | Oldenhuis,[^14]        | 2020 | 41       | Box-constrained                |
| 8    | Benchmark Functions for Single-Objective Optimization Based on a Zigzag Pattern - ABS | Kudela et al.,[^9]     | 2022 | 8        | Box-constrained                |
| 9    | Special session and competition on single objective real-parameter numerical optimization - CEC 2014 | Liang et al.,[^10]     | 2013 | 27       | Box-constrained                |
| 10   | Special session and competition on single objective real-parameter numerical optimization - CEC 2017 | Wu et al.,[^11]        | 2017 | 20       | Box-constrained                |
| 11   | A Test-suite of Non-Convex Constrained Optimization Problems from the Real-World - CEC 2006 | Liang et al.,[^3]      | 2006 | 13       | Generally/Linearly-constrained |
| 12   | Introduction to global optimization                          | Floudas et al.,[^16]   | 1999 | 20       | Generally/Linearly-constrained |
| 13   | Derivative-Free Optimization and Applications Project        | VAZ,[^4]               | 2007 | 57       | Linearly-constrained           |
| 14   | Introduction to Global Optimization                          | Horst et al.,[^15]     | 2000 | 7        | Linearly-constrained           |
| 15   | Parameter estimation in the general non-linear regression model | Gillard et al.,[^6]    | 2017 | 6        | Engineering problems           |
| 16   | Engineering design examples                                  | Ray et al.,[^7]        | 2003 | 5        | Engineering problems           |
| 17   | CEC 2011 competition on real-world optimization problems     | Das et al.,[^17]       | 2010 | 19       | Engineering problems           |
| 18   | CEC 2020 competition on real-world optimization problems     | Kumar et al.,[^18]     | 2020 | 23       | Engineering problems           |

Please note that the table above is a summary and does not contain the complete list of all the references in the library. If you need more detailed information about a specific problem or its source, you can find detailed documentation and information directly in the corresponding *MATLAB* file.

### Structure and Syntax

Understanding the syntax of coded problem m-files is provided with the following example of the `Tproblem.m`, for which the mathematical formulation is defined as follows:

<img src="img/tproblem.png" width="400">

The global minimum is located at x = -1, f(x) = -n.

Description in *MATLAB*:


```matlab
function y = Tproblem(x)                 
    if nargin == 0			                  % Extract info from the problem:
        y.nx = 0;                             % Dimension of the problem
        y.ng = 1;                             % Number of g(x) constraints
        y.nh = 0;                             % Number of h(x) constraints
        y.xl = @(nx) get_xl(nx);              % Lower bounds for each variable
        y.xu = @(nx) get_xu(nx);			  % Upper bounds for each variable
        y.fmin = @(nx) get_fmin(nx);          % Known solution value
        y.xmin = @(nx) get_xmin(nx);          % Known solution point
        y.confun = @(i) Tproblemc(i);         % Constraint functions
        return
    end
    if size(x, 2) > size(x, 1)                % If x is a row transpose to column          
        x = x';
    end
    y = sum(x);	        		              % Return function value at x
end

function [c, ceq] = Tproblemc(x)	          % Return constraint functions
	c = sum(x.^2) - length(x);
	ceq = [];
end

function xl = get_xl(nx)                      % Return function which return lower bounds
    xl = -4*ones(nx, 1);
end

function xu = get_xu(nx)                      % Return function which return upper bounds
    xu = 4*ones(nx, 1);
end

function fmin = get_fmin(nx)		          % Return function which calculates minima value
    fmin = -nx;
end

function xmin = get_xmin(nx)		          % Return function which calculates minima point
    xmin = -ones(nx, 1);
end
```

All the information needed for the algorithms about test functions is available programmatically. 

- Whenever the *MATLAB* code for the objective function is called with no arguments, the routine return a *MATLAB* structure `y` with all the necessary fields.
- The value `y.nx = 0` means that the test problem is various dimensionality that the user can settle.
- The `x` vector passed to a test problem can be either the column or a row vector.

### **Example of the Initialization of Experimental Settings**

The script [`Create_experiment_file.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Experimental_setup_data/Create_experiment_file.m) in the [`Experimental_setup_data`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Experimental_setup_data) folder, provides a configuration *mat*-file that replicates the experimental settings for the study of derivative-free global optimization algorithms[^19]. Then, the script [`Main.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Experimental_setup_data/Main.m) in the same folder, will utilize the created settings to loop the algorithms. The given script is compatible with **DIRECTGO**'s global optimization toolbox[^20] available in [GitHub](https://github.com/blockchain-group/DIRECTGO).

Settings in the [`Create_experiment_file.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Experimental_setup_data/Create_experiment_file.m) script:

- **Dimensions**: Out of 324 box-constrained test problems, 151 have fixed dimensions, 136 of which are non-scalable. There are 15 scalable problems with fixed dimensions, and 173 scalable problems were generated for dimensions n = 2, 5, 10, and 20 (with some exceptions on some CEC problems). In total, 807 test problems were obtained.
- **Adding shifts and rotations**: Five instances were created, each containing the entire set of 807 test problems. Random domain shifts were applied to all test problems in each instance, and the last three cases also included additional rotation operations. The instance number was used as the seed for the random number generator to ensure repeatability.
- **Stopping conditions**: The stopping criterion was when the algorithm finds a solution with an objective function value within one percent, or when the number of function evaluations exceeded the prescribed limit of 10<sup>5</sup>×n, or when the execution time limit of 600 CPU seconds was reached.

The result files from the experiments are in the same format as given in the study[^19] which can be accessed directly from the [Zenodo](https://doi.org/10.5281/zenodo.10201845).

### **Selection of Representative Instances**

While specific corrections have been made to **DIRECTGOLib** to remove the duplicates and highly similar problems, there remains uncertainty regarding the representation of certain types of problems. To mitigate the risk of obtaining biased results and to conserve resources required for experimentation, the utilization of the following instance selection methods is advisable. The following scripts are adapted to select representative instances from the pool of instances used in the study[^19], and these scripts creates configuration *mat*-file comprising the desired number of selected instances:

* **Random selection of instances**: The script [`ISM_ud_rand.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_Random/ISM_ud_rand.m) in the [`Instance_selection/ISM_Random`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_Random) folder, randomly selects the desired number of instances from a entire set[^21].
* **Utilizing ELA landscape features for instances selection**: The script [`script_run_flacco.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/Compute_ELA/script_run_flacco.m) in the [`Instance_selection/Compute_ELA`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/Compute_ELA) folder, computes the ELA landscape features utilizing *Flacco* **R** package[^23]. Then, using the next three instance selection methods, the desired number of instances will be selected:
  * The script [`ISM_cs_hc.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA/ISM_cs_hc.m) in the [`Instance_selection/ISM_ELA`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA) folder, use cosine similarity between ELA feature vectors to measure instance similarity and then select the instance closest to the centroid of each cluster using Hierarchical Clustering[^22].
  * The script [`ISM_md_greedy.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA/ISM_md_greedy.m) in the [`Instance_selection/ISM_ELA`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA) folder, use Manhattan distance between ELA feature vectors to measure instance similarity and then select instances using Greedy approach[^24].
  * The script [`ISM_ed_maxdiv.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA/ISM_ed_maxdiv.m) in the [`Instance_selection/ISM_ELA`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA) folder, use Euclidean distances between ELA feature vectors to measure instance similarity and then select instances using optimization perspective[^25].
* **Utilizing algorithm performance for instances selection**: The script [`ISM_rb_greedy.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_AP/ISM_rb_greedy.m) in the [`Instance_selection/ISM_AP`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_AP) folder, utilize the runtime behavior of eight algorithm performance data to measure instance similarity and then select instances using Greedy approach[^26].
* **Utilizing both ELA landscape features and algorithm performance for instances selection**: The script [`ISM_ped_wids.m`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA_AP/ISM_ped_wids.m) in the [`Instance_selection/ISM_ELA_AP`](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Instance_selection/ISM_ELA_AP) folder, selects instances by addressing the Weight Independent Dominating Set problem, where the similarity of the instances is defined with algorithm performance data and statistical tests, while the Euclidean distances between ELA feature vectors correspond to the weights[^26].

---

## Feedback and Contributions

We welcome contributions and corrections to this resource either way:

- **By email** - send us new problems, corrections, or suggestions by email: linas.stripinis@mif.vu.lt, jakub.kudela@vutbr.cz or remigijus.paulavicius@mif.vu.lt.
- **GitHub way** - fork the GitHub repository, add new problems or correct existing ones, then create a pull request, and we gratefully incorporate your contribution!

---

## Cite Library
Please use the following BibTeX entry, if you consider citing **DIRECTGOLib**:

```latex
@software{Directgolib_2023,
  author    = {Linas Stripinis and Jakub K\r{u}dela and Remigijus Paulavi\v{c}ius},
  title     = {DIRECTGOLib - DIRECT Global Optimization test problems Library},
  year      = {2023},
  publisher = {GitHub},
  journal   = {GitHub repository},
  version   = {2.0},
  url       = {https://github.com/blockchain-group/DIRECTGOLib},
  note      = {Pre-release v2.0}
}
```

---

## Changelogs

### [v2.0](https://github.com/blockchain-group/DIRECTGOLib/releases/tag/v2.0) - (2024-09-01)

**Upgraded**

The functionality of each function has been modified

- The lower bound, `y.xl`, and upper bound, `y.xu`, now extract functions that accept the input `n` and return the vectors for each variable. 

The functionality of box-constrained function has been improved:

- For each box-constrained global optimization test function, eight fundamental features are available, which can be accessed using `y.features`. This function returns a vector of ones and zeros, where one value indicates that the corresponding feature is present and zero indicates its absence. The list of features includes Differentiable, Separable, Scalable, Multi-modal, Non-convex, Non-plateau, Non-Zero-Solution, and Symmetric.
- A new feature, `y.libraries`, has been introduced for all box-constrained global optimization test functions. It provides a vector of zeros and ones, indicating the membership of each test problem in specific global optimization libraries. A value of one denotes that the corresponding library includes the function, while zero indicates its absence. The order of the libraries is as follows: [^1],[^2],[^8],[^13],[^12],[^5],[^14],[^9],[^10],[^11].

**Added**

182 new [box-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Box) global optimization test problems:

- `AbstractEllipsoidalBBOB.m`, `AttractiveSectorBBOB.m`, `BentCigarBBOB.m`, `BucheRastriginBBOB.m`, `DifferentPowersBBOB.m`, `DiscusBBOB.m`, `DisortedRastriginBBOB.m`, `EllipsoidalBBOB.m`, `GallagherGaussian101BBOB.m`, `GallagherGaussian21BBOB.m`, `GriewankRosenbrockBBOB.m`, `KatsuuraBBOB.m`, `LinearSlopeBBOB.m`, `LunacekBiRastriginBBOB.m`, `RastriginBBOB.m`, `RosenbrockBBOB.m`, `RosenbrockRotatedBBOB.m`, `Schaffer7BBOB.m`, `SchwefelBBOB.m`, `SharpRidgeBBOB.m`, `SphereBBOB.m`, `StepEllipsoidalBBOB.m`,  `TransformedSchaffer7BBOB.m`, `WeierstrassBBOB.m`, `ABS_1.m`, `ABS_2.m`, `ABS_3.m`, `ABS_4.m`, `ABS_5.m`, `ABS_6.m`, `ABS_7.m`, `ABS_8.m`, `CEC_2014_mex_1.m`, `CEC_2014_mex_10.m`, `CEC_2014_mex_12.m`, `CEC_2014_mex_13.m`, `CEC_2014_mex_14.m`, `CEC_2014_mex_15.m`, `CEC_2014_mex_16.m`, `CEC_2014_mex_17.m`, `CEC_2014_mex_18.m`, `CEC_2014_mex_19.m`, `CEC_2014_mex_2.m`, `CEC_2014_mex_20.m`, `CEC_2014_mex_22.m`, `CEC_2014_mex_23.m`, `CEC_2014_mex_24.m`, `CEC_2014_mex_25.m`, `CEC_2014_mex_26.m`, `CEC_2014_mex_27.m`, `CEC_2014_mex_28.m`, `CEC_2014_mex_29.m`, `CEC_2014_mex_3.m`, `CEC_2014_mex_30.m`, `CEC_2014_mex_4.m`, `CEC_2014_mex_5.m`, `CEC_2014_mex_6.m`, `CEC_2014_mex_7.m`, `CEC_2014_mex_8.m`, `CEC_2017_mex_11.m`, `CEC_2017_mex_12.m`, `CEC_2017_mex_14.m`, `CEC_2017_mex_16.m`, `CEC_2017_mex_18.m`, `CEC_2017_mex_20.m`, `CEC_2017_mex_21.m`, `CEC_2017_mex_22.m`, `CEC_2017_mex_23.m`, `CEC_2017_mex_24.m`, `CEC_2017_mex_25.m`, `CEC_2017_mex_26.m`, `CEC_2017_mex_27.m`, `CEC_2017_mex_28.m`, `CEC_2017_mex_29.m`, `CEC_2017_mex_3.m`, `CEC_2017_mex_30.m`, `CEC_2017_mex_6.m`, `CEC_2017_mex_7.m`, `CEC_2017_mex_9.m`,`AMGM.m`, `BoxBetts.m`,`Branin02.m`, `Brent.m`, `Bukin2.m`, `Camel3.m`, `Camel6.m`, `Cigar.m`, `Corana.m`, `CosineMixture.m`,`DeVilliersGlasser01.m`, `DeVilliersGlasser02.m`, `Deceptive.m`, `DeckkersAarts.m`, `DeflectedCorrugated.m`, `EggCrate.m`, `ElAttarVidyasagar.m`, `Forretal08.m`, `FreudensteinRoth.m`, `Gear.m`, `Grlee12.m`, `Gulf.m`, `Hansen.m`,  `HolderTable2.m`, `Hosaki.m`, `JennrichSampson.m`, `Judge.m`, `Katsuura.m`, `Keane.m`, `Kowalik.m`, `Langermann5.m`, `LennardJones.m`, `Levy03.m`, `Levy05.m`, `MieleCantrell.m`, `Mishra01.m`, `Mishra02.m`, `Mishra03.m`, `Mishra04.m`, `Mishra05.m`, `Mishra06.m`, `Mishra07.m`, `Mishra08.m`, `Mishra09.m`, `Mishra10.m`, `Mishra11.m`, `MultiModal.m`, `NeedleEye.m`, `OddSquare.m`, `Parsopoulos.m`, `Pathological.m`, `Paviani.m`, `PenHolder.m`, `Penalty01.m`, `Penalty02.m`, `Periodic.m`, `PowellSingular01.m`, `Quintic.m`, `Rana.m`,  `Ripple01.m`, `Ripple25.m`, `RosenbrockModified.m`, `RotatedEllipse01.m`, `RotatedEllipse02.m`, `Rump.m`, `Salomon.m`, `Sargan.m`, `SchmidtVetters.m`, `SchumerSteiglitz.m`, `Schwefel000.m`, `Schwefel120.m`, `Schwefel220.m`, `Schwefel221.m`, `Schwefel222.m`, `Schwefel223.m`, `Schwefel225.m`, `Schwefel240.m`, `Schwefel260.m`, `Schwefel360.m`, `Shubert03.m`, `Shubert04.m`, `Sodp.m`, `Step1.m`, `Step2.m`, `Step3.m`, `Stepint.m`, `StretchedV.m`, `Treccani.m`, `Trigonometric02.m`, `Tripod.m`, `Ursem01.m`, `Ursem03.m`, `Ursem04.m`, `UrsemWaves.m`, `Venter.m`, `Watson.m`, `WayburnSeader01.m`, `WayburnSeader02.m`, `WayburnSeader03.m`, `Weierstrass.m`, `Whitley.m`, `Wolfe.m`,`XinSheYang04.m`, `Xor.m`, `ZeroSum.m`, `Zimmerman.m`, `Zirilli.m`, `Bifunctional_Catalyst_Blend.m`, `Circular_Antenna_Array.m`, `Dynamic_Economic_Dispatch120.m`, `Dynamic_Economic_Dispatch216.m`, `Four_Stage_Gear_Box.m`, `Frequency_Modulated_Sound_Waves.m`, `Gas_Transmission_Compressor.m`, `Himmelblaus.m`, `Hydro_Static_Thrust_Bearing.m`, `Hydrothermal_SchedulingC1.m`, `Hydrothermal_SchedulingC2.m`, `Hydrothermal_SchedulingC3.m`, `Industrial_Refrigeration_System.m`, `Lennard_Jones_Potential.m`, `Multi_Product_Batch_Plant.m`, `Multiple_Disk_Clutch_Brake.m`, `NASA_Speed_ReducerC1.m`, `Spread_Spectrum_Radar.m`, `NonLinear_Stirred_Tank_Reactor.m`, `Operation_Of_Alkylation_Unit.m`, `Pressure_VesselC1.m`, `Process_Design.m`, `Process_Flow_Sheeting.m`, `Process_Synthesis2.m`, `Process_Synthesis7.m`, `Robot_Gripper.m`, `Rolling_Element_Bearing.m`, `Spacecraft_Trajectory_OptimizationC1.m`, `Spacecraft_Trajectory_OptimizationC2.m`, `Static_Economic_Load_Dispatch13.m`, `Static_Economic_Load_Dispatch140.m`, `Static_Economic_Load_Dispatch15.m`, `Static_Economic_Load_Dispatch40.m`, `Static_Economic_Load_Dispatch6.m`,  `Tension_Compression_SpringC1.m`, `Tension_Compression_SpringC2.m`, `Tersoff_PotentialC1.m`, `Tersoff_PotentialC2.m`, `Ten_bar_truss.m`, `Topology_Optimization.m`, `Welded_BeamC1.m`, `Wind_Farm_Layout.m`

**Removed**

Nine duplicated [box-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Box) global optimization test problems:

- `Cubic.m`, `Dejong.m`, `Exponential2.m`, `Exponential3.m`, `Power_Sum.m`, `RotatedHyperEllipsoid.m`, `Sum_Square.m`, `Trid6.m`, `Wood.m`

**Modified**

18 [box-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Box) global optimization test problems:

- `PermFunction01.m`, `Trid.m`, `AlpineN2.m`, `Branin01.m`, `CrossFunction.m`, `CrossInTray.m`, `Schaffer1.m`, `Schaffer2.m`, `Schaffer3.m`, `Schaffer4.m`, `PermFunction02.m`, `HolderTable1.m`, `Shubert01.m`, `SumOfPowers.m`, `Trigonometric01.m`, `XinSheYang02.m`, `XinSheYang03.m`, `Csendes.m`

### [v1.3](https://github.com/blockchain-group/DIRECTGOLib/releases/tag/v1.3) - (2023-06-15)

**Added**

34 new [linearly-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Linear) global optimization test problems:

- `avgasa.m`, `avgasb.m`, `biggsc4.m`, `Bunnag8.m`, `Bunnag10.m`, `Bunnag11.m`, `Bunnag12.m`, `Bunnag13.m`, `Bunnag14.m`, `Bunnag15.m`, `ex2_1_1.m`, `ex2_1_2.m`, `expfita.m`, `expfitb.m`, `expfitc.m`, `Genocop7.m`, `hs086.m`, `hs118.m`, `hs268.m`, `Ji1.m`, `Ji2.m`, `Ji3.m`, `ksip.m`, `Michalewicz1.m`, `s253.m`, `s268.m`, `s277.m`, `s278.m`, `s279.m`, `s280.m`, `s331.m`, `s340.m`, `s354.m`, `s359.m`

**Removed**

Two duplicated [linearly-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Linear) global optimization test problems:

- `Genocop11.m`, `hs035.m`

### [v1.2](https://github.com/blockchain-group/DIRECTGOLib/releases/tag/v1.2) - (2022-06-06)

**Added**

69 new [box-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Box) global optimization test problems:

- `AckleyN2.m`, `AckleyN3.m`, `AckleyN4.m`, `Adjiman.m`, `AlpineN1.m`,`BartelsConn.m`, `BiggsEXP2.m`, `BiggsEXP3.m`, `BiggsEXP4.m`, `BiggsEXP5.m`, `BiggsEXP6.m`, `Bird.m`, `Brad.m`, `Brown.m`, `Bukin4.m`, `CarromTable.m`, `ChenBird.m`, `ChenV.m`, `Chichinadze.m`, `ChungR.m`, `Cola.m`, `Cross_function.m`, `CrownedCross.m`, `Cube.m`,  `Cubic.m`, `Dejong.m`, `Dejong5.m`, `Dolan.m`, `Exponential.m`, `Exponential2.m`, `Exponential3.m`, `Giunta.m`, `Hartman4.m`, `HelicalValley.m`, `HimmelBlau.m`, `Layeb01.m`, `Layeb02.m`, `Layeb03.m`, `Layeb04.m`, `Layeb05.m`, `Layeb06.m`, `Layeb07.m`, `Layeb08.m`, `Layeb09.m`, `Layeb10.m`, `Layeb11.m`, `Layeb12.m`, `Layeb13.m`, `Layeb14.m`, `Layeb15.m`, `Layeb16.m`, `Layeb17.m`, `Layeb18.m`, `Leon.m`, `Levi13.m`, `ModSchaffer1.m`, `ModSchaffer2.m`, `ModSchaffer3.m`, `ModSchaffer4.m`, `Quadratic.m`, `SineEnvelope.m`, `Sinenvsin.m`, `TestTubeHolder.m`, `Trigonometric.m`, `Wood.m`, `WWavy.m`, `XinSheYajngN1.m`, `XinSheYajngN2.m`, `Zettl.m`

### [v1.1](https://github.com/blockchain-group/DIRECTGOLib/releases/tag/v1.1) - (2022-04-26)

**Added**

Eight new [box-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Box) global optimization test problems:

- `Crosslegtable.m`, `Damavandi.m`, `Deb01.m`, `Deb02.m`, `Permdb4.m`, `Pinter.m`, `Trefethen.m`, `Vincent.m`

**Modified**

One [box-constrained](https://github.com/blockchain-group/DIRECTGOLib/tree/main/Box) global optimization test problem:

- `Trid10.m`

---

## References

[^1]: Hedar, A. (2005). *Test functions for unconstrained global optimization*. [[Link to webpage]](http://www-optima.amp.i.kyoto-u.ac.jp/member/student/hedar/Hedar_files/TestGO.htm)
[^2]:Surjanovic, S., & Bingham, D. (2013). *Virtual Library of Simulation Experiments: Test Functions and Datasets.* [[Link to webpage]](https://www.sfu.ca/~ssurjano/optimization.html)
[^3]: Liang, J. J., Runarsson, T. P., Mezura-Montes, E., Clerc, M., Suganthan, P. N., Coello, C. A. C., & Deb, K. (2006). *Problem definitions and evaluation criteria for the CEC 2006 special session on constrained real-parameter optimization.* Journal of Applied Mechanics, *41*(8), 8–31. [[Link to paper]](https://cw.fel.cvut.cz/b181/_media/courses/a0m33eoa/cviceni/2006_problem_definitions_and_evaluation_criteria_for_the_cec_2006_special_session_on_constraint_real-parameter_optimization.pdf)
[^4]: Vaz, A.I.F. (2007). *Derivative-Free Optimization and Applications Project.* [[Link to webpage]](http://www.norg.uminho.pt/aivaz/pswarm/)
[^5]: Hansen, N., Finck, S., Ros, R., & Auger, A. (2009). *Real-parameter black-box optimization benchmarking 2009: Noiseless functions definitions*. [[Link to paper]](https://inria.hal.science/inria-00362633/file/RR-6829v2.pdf)
[^6]: Gillard, J. W., & Kvasov, D. E. (2017). *Lipschitz optimization methods for fitting a sum of damped sinusoids to a series of observations.* Statistics and Its Interface, *10*(1), 59–70. DOI: 10.4310/SII.2017.v10.n1.a6. [[Link to paper]](https://doi.org/10.4310/SII.2017.v10.n1.a6)
[^7]: Ray, T., & Liew, K.-M. (2003). *Society and civilization: an optimization algorithm based on the simulation of social behavior.* IEEE Transactions on Evolutionary Computation, *7*(4), 386–396. DOI: 10.1109/TEVC.2003.814902. [[Link to paper]](https://doi.org/10.1109/TEVC.2003.814902)
[^8]: Layeb, A. (2022). *New hard benchmark functions for global optimization.* DOI: 10.48550/arXiv.2202.04606. [[Link to paper]](https://doi.org/10.48550/arXiv.2202.04606)
[^9]: Kudela, J., & Matousek, R. (2022). *New benchmark functions for single-objective optimization based on a zigzag pattern.* IEEE Access, *10*, 8262–8278. DOI: 10.1109/ACCESS.2022.3144067. [[Link to paper]](https://doi.org/10.1109/ACCESS.2022.3144067)
[^10]: Liang, J. J., Qu, B. Y., & Suganthan, P. N. (2013). *Problem definitions and evaluation criteria for the CEC 2014 special session and competition on single objective real-parameter numerical optimization.* Computational Intelligence Laboratory, Singapore, *635*(2). [[Link to paper]](http://bee22.com/manual/tf_images/Liang CEC2014.pdf)
[^11]: Wu, G., Mallipeddi, R., & Suganthan, P. N. (2017). *Problem definitions and evaluation criteria for the CEC 2017 competition on constrained real-parameter optimization.* National University of Defense Technology, Singapore, Technical Report. [[Link to paper]](https://www.researchgate.net/profile/Guohua-Wu-5/publication/317228117_Problem_Definitions_and_Evaluation_Criteria_for_the_CEC_2017_Competition_and_Special_Session_on_Constrained_Single_Objective_Real-Parameter_Optimization/links/5982cdbaa6fdcc8b56f59104/Problem-Definitions-and-Evaluation-Criteria-for-the-CEC-2017-Competition-and-Special-Session-on-Constrained-Single-Objective-Real-Parameter-Optimization.pdf)
[^12]: Jamil, M., & Yang, X.-S. (2013). *A literature survey of benchmark functions for global optimization problems.* International Journal of Mathematical Modelling and Numerical Optimization, *4*(2), 150–194. DOI: 10.1504/IJMMNO.2013.055204. [[Link to paper]](https://doi.org/10.1504/IJMMNO.2013.055204)
[^13]: Gavana, A. (2013). *Global Optimization Benchmarks and AMPGO — AMPGO 0.1.0 documentation.* [[Link to webpage]](http://infinity77.net/global_optimization/index.html)
[^14]: Oldenhuis, R. (2020): *Test functions for global optimization algorithms. Release v1.5.* [[Link to webpage]](https://github.com/rodyo/FEX-testfunctions/releases/tag/v1.5)
[^15]: Horst, R., Pardalos, P. M., & van Thoai, N. (2000). *Introduction to global optimization.* Springer Science & Business Media. [[Link to book]](https://books.google.lt/books?hl=lt&lr=&id=dbu02-1JbLIC&oi=fnd&pg=PR11&dq=Horst,+R.,+Pardalos,+P.M.,+Thoai,+N.V.+(1995).+Introduction+to+Global+Optimization.+Nonconvex+Optimization+and+Its+Application.+Kluwer,+Dordrecht++&ots=x7g-q7HpJ-&sig=-pFGblwR3QlWuvEUIuCyvgLK_tI&redir_esc=y#v=onepage&q&f=false)
[^16]: Floudas, C. A., Pardalos, P. M., Adjiman, C., Esposito, W. R., Gümüs, Z. H., Harding, S. T., Klepeis, J. L., Meyer, C. A., & Schweiger, C. A. (1999). *Handbook of test problems in local and global optimization.* Nonconvex Optimization and Its Applications. Springer Science & Business Media. DOI: 10.1007/978-1-4757-3040-1. [[Link to book]](https://doi.org/10.1007/978-1-4757-3040-1)
[^17]: Das, S., & Suganthan, P. N. (2010). *Problem definitions and evaluation criteria for CEC 2011 competition on testing evolutionary algorithms on real-world optimization problems.* Jadavpur University, Nanyang Technological University, Kolkata, 341–359. [[Link to paper]](https://al-roomi.org/multimedia/CEC_Database/CEC2011/CEC2011_TechnicalReport.pdf)
[^18]: Kumar, A., Wu, G., Ali, M. Z., Mallipeddi, R., Suganthan, P. N., & Das, S. (2020). *A test-suite of non-convex constrained optimization problems from the real-world and some baseline results.* Swarm and Evolutionary Computation, *56*, 100693. DOI: 10.1016/j.swevo.2020.100693. [[Link to paper]](https://doi.org/10.1016/j.swevo.2020.100693)
[^19]: Stripinis, L., Kůdela, J., & Paulavičius, R. (2024). *Benchmarking Derivative-Free Global Optimization Algorithms Under Limited Dimensions and Large Evaluation Budgets.* IEEE Transactions on Evolutionary Computation. DOI: 10.1109/TEVC.2024.3379756. [[Link to paper]](https://doi.org/10.1109/TEVC.2024.3379756)
[^20]: Stripinis, L. & Paulavičius, R. (2022). *DIRECTGO: "A new DIRECT-type MATLAB toolbox for derivative-free global optimization.* ACM Transactions on Mathematical Software, vol. 48, no. 4, dec 2022. DOI 10.1145/3559755. [[Link to paper]](https://doi.org/10.1145/3559755)
[^21]:Pascal Kerschke, Holger H. Hoos, Frank Neumann, and Heike Trautmann. 2019. Automated Algorithm Selection: Survey and Perspectives. Evol. Comput. 27, 1 (Spring 2019), 3–45, DOI: 10.1162/evco_a_00242. [[Link to paper]](https://doi.org/10.1162/evco_a_00242)
[^22]:Gjorgjina Cenikj, Ryan Dieter Lang, Andries Petrus Engelbrecht, Carola Doerr, Peter Korošec, and Tome Eftimov. 2022. SELECTOR: selecting a representative benchmark suite for reproducible statistical comparison. In Proceedings of the GECCO '22. Association for Computing Machinery, New York, NY, USA, 620–629. DOI: 10.1145/3512290.3528809. [[Link to paper]](https://doi.org/10.1145/3512290.3528809)
[^23]: P. Kerschke and H. Trautmann, Comprehensive Feature-Based Land scape Analysis of Continuous and Constrained Optimization Problems Using the R-Package Flacco. Cham: Springer International Publishing, 2019, pp. 93–123, DOI: 10.1007/978-3-030-25147-5_7. [[Link to paper]](https://doi.org/10.1007/978-3-030-25147-5_7)
[^24]:Konstantin Dietrich, Diederick Vermetten, Carola Doerr, and Pascal Kerschke. 2024. Impact of Training Instance Selection on Automated Algorithm Selection Models for Numerical Black-box Optimization. In Proceedings of the GECCO '24. Association for Computing Machinery, New York, NY, USA, 1007–1016, DOI: 10.1145/3638529.3654100. [][Link to paper]](https://doi.org/10.1145/3638529.3654100)
[^25]:Gleixner, A., Hendel, G., Gamrath, G. et al. MIPLIB 2017: data-driven compilation of the 6th mixed-integer programming library. Math. Prog. Comp. 13, 443–490 (2021), DOI: 10.1007/s12532-020-00194-3. [[Link to paper]](https://doi.org/10.1007/s12532-020-00194-3)
[^26]:Stripinis, L., Kůdela, J., & R. Paulavičius, (2024) "New Algorithm Performance-based Strategies for Benchmark Function Selection in Continuous Global Optimization." IEEE Transactions on Cybernetics
