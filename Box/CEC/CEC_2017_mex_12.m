function y = CEC_2017_mex_12(x,varargin)
% -------------------------------------------------------------------------
% MATLAB coding by: Jakub Kudela
% Name:
%   CEC_2017_mex_12.m
%
% References:
%  - G. Wu, R. Mallipeddi, and P. N. Suganthan, "Problem definitions and
%    evaluation criteria for the cec 2017 competition on constrained real-
%    parameter optimization," National University of Defense Technology,
%    Changsha, Hunan, PR China and Kyungpook National University,
%    Daegu, South Korea and Nanyang Technological University, Singapore,
%    Technical Report, 2017.
%
% Globally optimal solution:
%   f = 1200
%   x(i) = 0, i = 1,...,n
%
% Default variable bounds:
%   -100 <= x(i) <= 100, i = 1,...,n:
%
% Problem Properties:
%   n  = any dimension;
%   #g = 0;
%   #h = 0;
%
% Known characteristics of test function:
%   Differentiable, Non-separable, Scalable, Multi-modal,
%   Non-convex, Non-plateau, Zero-Solution, Symmetric
% -------------------------------------------------------------------------
if nargin == 0
	 y.nx = 0;
	 y.ng = 0;
	 y.nh = 0;
	 y.xl = @(nx) get_xl(nx);
	 y.xu = @(nx) get_xu(nx);
	 y.fmin = @(nx) get_fmin(nx);
	 y.xmin = @(nx) get_xmin(nx);
	 y.features = [1, 0, 1, 1, 0, 0, 0, 0];
	 y.libraries = [0, 0, 0, 0, 0, 0, 0, 0, 0, 1];
	 return;
end
shift_orig = [
	6.5258832790543721e+01,5.2027106681851194e+00,-7.8041799812597134e+01,3.1470549680046076e+01,-3.4471527465838719e+01,-2.9621183513487210e+00,-2.4323131118120223e+01,1.1352977534454709e+00,4.0949342158133788e+01,7.5593651754592372e+01,-5.7494960565816129e+01,-7.7802229671646941e+01,5.7925908629747994e+01,-3.9253659825424506e+01,-5.6260685909660850e+01,2.6651916330052501e+01,-6.1242240807619993e+01,-1.8341253669160068e+01,5.8549582426692155e+01,4.2831845415212143e+01,3.4825893470470746e+01,3.8791558201793364e+01,-3.0281302458737649e+01,2.2149575996282323e+01,-5.2076230483165119e+01,-4.5205730556140523e+01,6.7286542946140514e+01,4.9272957839664571e+00,-6.6939758875844888e+01,6.3472573674969624e+01,6.3545755214777671e+01,1.3507894768150464e+01,-1.2812631694978393e+01,1.8099102498078295e+01,3.1615685202002368e+01,4.8211900539794925e+00,6.9741237233272415e+01,-1.9025820390798998e+01,7.3036691841220801e+01,7.6797753980754777e+00,-4.6014884545474722e+01,6.7835444206295278e+01,-4.9689224795293633e+01,7.3198865499905708e+01,1.3332456915328493e+01,7.8603375925963462e+01,-3.3060812332230071e+01,2.6927132209263348e+01,-7.5688958911080363e+01,5.5667581472391078e+01,-7.4958193523324184e+01,1.7641453490425576e+01,1.9908813582690811e+01,4.7429884284469239e+01,3.4065169074602977e+01,5.3296636852108236e+01,7.6575573383167182e+01,-3.4338149109081435e+01,-1.2720763316713573e+00,6.0213093599403777e+01,1.4641251794361096e+00,-3.2448109217196752e+01,-7.5371613425841375e+01,-5.0706848115989402e+01,-6.9996285433879251e+01,5.2430712791360321e+01,-7.7010115607180680e+01,-6.9013009885797743e+01,-6.1657150602739840e+01,4.8269819751507498e+01,7.0860563586866732e+01,7.3492204469392163e+01,-1.6519482925776153e+01,-4.2949533519777255e+01,6.7190133103723696e+01,-1.5432925715778453e+01,-2.1182505088477626e+01,-1.4363022043538763e+01,4.0688514244131980e+01,1.1858901126244518e+01,-4.7448771208268013e+01,-3.1497697360579707e+01,5.8200460736733135e+01,-6.4856397726040512e+01,3.8523418437001951e+01,-5.6906329308127205e+01,5.5323318306041585e+01,5.9010769640566195e+01,-4.5994651003738241e+01,-7.2099419828550623e+01,6.5050941549730908e+01,3.1174626327666743e+01,-4.8055310905005463e+01,1.4389619573200875e+01,-7.3663833212882196e+01,1.1955191088819504e+01,-2.9103370210669645e+01,-2.0343130724664377e+01,1.3001910565887528e+01,-3.6889119128179324e+01,;
	];
[D,~] = size(x);
if size(varargin) > 0
	 shift = varargin{1}';
	 M = varargin{2};
	 shuffle = 1:D;
else
if (D ~= 10) | (D ~= 30)
y = 'Original CEC2017 functions defined only for D=[10,30]'
 return
end
shift = shift_orig;
shuffle = 1:D;
switch D
	 case 10
	 shuffle = [5,1,7,3,4,2,8,9,10,6,];
	 M = [
		 -4.3767680555767935e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.0947880485141790e-01,		 0.0000000000000000e+00,		 7.0336634523224939e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 9.2340850528389318e-01,		 -3.0115101586398396e-01,		 2.3795965627277360e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 3.2597965145285435e-01,		 2.8805490490306518e-01,		 -9.0042303313496030e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 2.0261786497750323e-01,		 9.0902829296198284e-01,		 3.6416145236224789e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 4.1951192787319680e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -6.5201388268425020e-01,		 0.0000000000000000e+00,		 -6.3157552134255657e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.7293350653943123e-01,		 0.0000000000000000e+00,		 -3.8271968735465250e-01,		 7.9225528473329965e-01,		 -4.6809220412566202e-02,
		 9.0669406775983807e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.6742797582454358e-01,		 0.0000000000000000e+00,		 3.2617195654364017e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 8.0848487446560502e-01,		 0.0000000000000000e+00,		 -2.9975287442250498e-01,		 3.1435675395239382e-01,		 -3.9708972950744403e-01,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.8834506408708485e-01,		 0.0000000000000000e+00,		 6.2766872914472938e-01,		 1.4700446407922468e-01,		 -7.4091010981674088e-01,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.9531719046930643e-01,		 0.0000000000000000e+00,		 6.0803439182372265e-01,		 5.0189748215890551e-01,		 5.3961176115372056e-01,
	 ];
	 case 30
	 shuffle = [5,27,7,10,13,28,14,3,26,9,25,17,21,6,22,29,2,18,30,4,11,24,20,8,12,23,15,16,19,1,];
	 M = [
		 -6.4768764887685737e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.7297099571546754e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.0329397055962625e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 9.0275950863318109e-03,		 3.8778773659331767e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.7934085510269746e-01,		 3.0327060444352799e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.1745342402532169e-01,		 -6.0837622565698017e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.1638233377358892e-01,		 -2.6245623823028602e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.8736454113600642e-01,
		 0.0000000000000000e+00,		 1.4447175253390571e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.4770474629145053e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.4129929712514802e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.5665337153305273e-01,		 3.8974547137156840e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 5.4167623691017852e-01,		 5.0588011080863948e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.5550005308680632e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 6.5758456131697743e-02,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.0554709062332108e-01,		 0.0000000000000000e+00,		 -2.0805543062299189e-01,		 0.0000000000000000e+00,		 5.0269482813210836e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.7341269670851807e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.7546577458404842e-01,		 -3.9441128155361016e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.9553187738052972e-01,		 3.6060301260623612e-01,		 5.6893232736981092e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 6.6443027650389097e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.0519795741154730e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.1754564783697729e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.1873584243115629e-03,		 -9.7919937858497230e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.7053955450455029e-02,		 3.6632221688205860e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.7492260419893373e-01,		 -1.5244917307624850e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.8095999584772841e-01,		 -3.5378758869048239e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.7590638549104204e-01,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.5507146586330962e-01,		 0.0000000000000000e+00,		 1.5778051743466776e-01,		 0.0000000000000000e+00,		 -7.3424747647533684e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.1371209713745434e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.4291143199352242e-02,		 1.6096095991277576e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.5025225889077953e-01,		 4.6272897235821042e-01,		 3.7826376022373195e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 1.7180432867224753e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.1757440821711114e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.7692940293939933e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.3939738005375496e-01,		 3.2588610837749754e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.1724474695932389e-01,		 -3.8973614954634239e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 6.3452547670481363e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.4120391128728187e-01,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.9999669754888201e-01,		 0.0000000000000000e+00,		 -5.1497980517596714e-02,		 0.0000000000000000e+00,		 -5.1846517582951640e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.3093762511583751e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.8529492584568490e-01,		 3.7335750832442038e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -5.9982068720461801e-01,		 -2.1578598279864933e-01,		 8.6550926157865152e-03,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 -2.3226001275765801e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.4186326480826290e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.0182381387736833e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.7825337369733816e-01,		 -3.5219998485878767e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 9.1161293399444426e-02,		 -1.6078740629105989e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.8570639639618997e-01,		 -2.4997240316037489e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.0953287070079262e-01,		 -7.2311966594923016e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 9.8407564456737512e-02,
		 0.0000000000000000e+00,		 -1.5534555317873242e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.8453673497791854e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.1542553213516494e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.9595016430785495e-02,		 4.5712664173712003e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.3364976025437853e-01,		 1.4249602325793798e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.6737005926367541e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -8.0037756666747906e-01,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.4903925247484318e-02,		 0.0000000000000000e+00,		 1.5537373116217934e-01,		 0.0000000000000000e+00,		 -3.2988553612872618e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.9764719399916204e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 6.4354768067069884e-02,		 -4.9601920853395354e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -5.9554779239398292e-01,		 1.3397312259740982e-01,		 -4.3957331651917975e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 -1.0986639170850609e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.1063876775227883e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.1024664484673888e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.2370494904895613e-02,		 2.4594218185433123e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.0809823671595316e-01,		 -8.0553836729834549e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.8047153311562811e-01,		 8.6690255271547306e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.6491468531732665e-01,		 -3.4765034923215664e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.2200313394738047e-02,
		 -1.2171854120991833e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.9015343854182354e-03,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.2082720530030754e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.9634312767863948e-01,		 -3.0397242903730426e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.6886625171568930e-01,		 -1.6258385950881898e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.2826698694790768e-01,		 2.6671481998158103e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.9823097370174587e-01,		 2.3474556405992587e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.0468268127365988e-01,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 7.1008408264244394e-01,		 0.0000000000000000e+00,		 -2.6233547897723386e-01,		 0.0000000000000000e+00,		 -2.3729480827120325e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.9279829910748303e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.9836511174875736e-01,		 -1.4380856526526840e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.2743354867588583e-01,		 2.9059190399718404e-01,		 1.4330736176459480e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -8.3407227004274428e-02,		 0.0000000000000000e+00,		 -7.9172481954127447e-02,		 0.0000000000000000e+00,		 -4.3090675191578598e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.7281224664702404e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.7884562266631737e-01,		 -5.3602976175447947e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.2281659440561130e-01,		 -3.7216516517060577e-01,		 -2.6471701119538088e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 -1.2944722706998796e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.1011566744576017e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 4.9076090271688369e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -5.8126320995096044e-03,		 1.9020045194134250e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.2141910444118707e-01,		 2.4687954481876043e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.5689629651503387e-01,		 -1.8056850078612677e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.8652669522965812e-01,		 -1.6646826758644703e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.3459744221811718e-01,
		 3.2521259276465742e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.1075960558008583e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.4729784318554202e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.3644034587521512e-01,		 2.3354525152924885e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.0214185059158401e-02,		 -1.6361493787412845e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 5.1500502257817571e-01,		 -4.5039638635921264e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.1568480629475026e-01,		 -2.7822791847005313e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.4356015143819998e-01,
		 0.0000000000000000e+00,		 -1.8321311137735405e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.0084429987242922e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 7.2764841778448353e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.2440786783547687e-01,		 -1.9733337389833328e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 7.3511744322738964e-02,		 -4.6736741862715064e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.7139526363233418e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 6.2781164418130392e-02,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 -3.9257884304827645e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 6.8745308145592521e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.1835652508780637e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.5089643454855504e-01,		 1.9095537965350584e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.1897431117725047e-01,		 -1.8295484589141070e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.6919302829227715e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.3652526052707847e-01,		 0.0000000000000000e+00,
		 -5.7745873175652118e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 8.1271676463142345e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -5.3198439643846152e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.4778392757129656e-01,		 1.9540140009570364e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.3619662475283961e-01,		 8.3490499805329466e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.0377238126338105e-01,		 -2.4584885406801740e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.1775610163560535e-01,		 8.6960836473453013e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.5706634365783815e-01,
		 -5.5050537720491594e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.6851633918013120e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.5317508903046005e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 6.8731589526587555e-01,		 1.3734173897439395e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.7533262584561740e-01,		 2.5386390302505091e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.4646924040743081e-02,		 3.1717492942499217e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 4.4999505169491094e-01,		 2.6023543001076344e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 5.7584336004953829e-03,
		 0.0000000000000000e+00,		 -3.5809268375049114e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -5.0722892177424872e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.0205215829695766e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -6.1253256617825602e-04,		 8.9235236952790731e-03,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 6.1568523337283443e-01,		 -3.4522508106282657e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 7.4176155009187589e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.6425859769592885e-01,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 -5.7526409230660114e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.4953796618577672e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.0888660571865041e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.7776586591657824e-01,		 4.9492121836296477e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.9031599487679064e-01,		 1.6347280626268790e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.9136072887036720e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.7751169885760995e-01,		 0.0000000000000000e+00,
		 7.8783098085965203e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.7894976893940774e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.0947246403200411e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.5303472242051311e-01,		 4.1963705205836688e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.2208307759376086e-01,		 -6.0140568390813630e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.8205425094823919e-01,		 8.0937835330795058e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.8035385867911756e-01,		 -2.0881907653251017e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.4392564318104579e-01,
		 9.0012761777982203e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 5.5778696588208887e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.3454204876259019e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -6.6055793236126592e-02,		 4.2035909122935677e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.6492367991358253e-01,		 -1.1937531119601191e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.9542971178925289e-01,		 5.7385983924787409e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.3393608218839212e-01,		 -2.1315235694534787e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.8996772414148980e-01,
		 0.0000000000000000e+00,		 5.3353903451995410e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.8113069803106387e-03,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -3.8499276250891522e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 4.0212229921173864e-01,		 3.5505184390262490e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.2567784039026059e-01,		 -3.9597665279615712e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -5.0342289604774726e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.3004164844447096e-03,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.0977802639719178e-01,		 0.0000000000000000e+00,		 1.7849096603857909e-01,		 0.0000000000000000e+00,		 3.6470262928427222e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.2502296032122799e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.2346659092285315e-01,		 2.4200308379900448e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.6398382722605062e-01,		 5.9850877206692854e-01,		 -4.5476457353089828e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.7566760987008518e-01,		 0.0000000000000000e+00,		 3.1871425428006195e-01,		 0.0000000000000000e+00,		 -2.7436610035090386e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -4.4514980566388396e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 5.1728003295106850e-01,		 3.2517097785134824e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.8653993307663600e-01,		 -4.0892355693293539e-02,		 -1.6360882977539892e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 8.1875185492037636e-02,		 0.0000000000000000e+00,		 8.3456528894150062e-01,		 0.0000000000000000e+00,		 6.5597992535132404e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.4934007587076276e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.9392546322245705e-01,		 -1.9810071132341467e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.7217006012439954e-02,		 -9.2192611734121008e-02,		 3.9673013303171972e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,
		 0.0000000000000000e+00,		 1.5229006847041002e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.1777028132888456e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.4476758733578772e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -7.0046011341647707e-01,		 5.4158489016374300e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -6.5083302731003989e-02,		 -1.3145313388986735e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 4.5973007401471588e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 1.9101142046792974e-01,		 0.0000000000000000e+00,
		 -1.3734497860444315e-02,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 3.9870604086261030e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 2.1458926645451060e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 4.0749685755723369e-01,		 2.5007929834183984e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -9.9618734791830241e-02,		 -2.0642326238201747e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.1565253597139570e-01,		 -4.4625580152415079e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -2.9469877966059732e-01,		 4.5033559497950865e-01,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 0.0000000000000000e+00,		 -1.0723448609939530e-01,
	 ];
end
end
M = M(:);
shift = shift(:,1:D); shift = shift'; shift = shift(:);
fhd=str2func('cec17_func_mod');
y = fhd(x,12,M,shift,shuffle);
end

function xl = get_xl(nx)
	 xl = -100*ones(nx, 1);
end

function xu = get_xu(nx)
	 xu = 100*ones(nx, 1);
end

function fmin = get_fmin(~)
	 fmin = 1200;
end

function xmin = get_xmin(nx)
	 xmin = zeros(nx, 1);
end