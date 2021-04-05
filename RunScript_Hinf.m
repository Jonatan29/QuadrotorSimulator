%% Add path to Necessary Files
addpath('Trim&Linearize')
addpath('GeneralFunctions')
addpath('QuadParameters')
addpath('Trajectories')
addpath('SimulinkFiles')
addpath('Controllers')
addpath('LMIs')
%% Find Nonlinear Model Trim points
SimulinkTrimFile = 'SIMULINK_Trim';
States_q = [0;0;2;0;0;0];
Known_q = [true;true;true;true;true;true];
Min_q = [-Inf;-Inf;-Inf;-Inf;-Inf;-Inf];
Max_q = [Inf;Inf;Inf;Inf;Inf;Inf];
States_qp = [0;0;0;0;0;0];
Known_qp = [true;true;true;true;true;true];
Min_qp = [-Inf;-Inf;-Inf;-Inf;-Inf;-Inf];
Max_qp = [Inf;Inf;Inf;Inf;Inf;Inf];

ControlBounds = {[0 100],[0 100],[0 100],[0 100]};

 [op,opreport] = fcn_TrimModel(SimulinkTrimFile,States_q,Known_q,Min_q,Max_q,States_qp,Known_qp,Min_qp,Max_qp,ControlBounds)

 %% Linearize Model Around Trim Points
 linsys = fcn_Linearize( op, SimulinkTrimFile );
A = linsys.a
B = linsys.b
C = linsys.c
D = linsys.d
Bw = zeros(size(A,1),size(D,2))
%% Design The Hinf Controller
mu = 10000
[P,K,diagnostic,primal,gamma] = LMI_Hinf(A,B,Bw,C,D,mu);
K = double(K)
Poles = eig(A + B*K);
co = ctrb(A,B);
ctrbil = rank(co)

global ProportionalController
ProportionalController.K = K;
 %% Simulate Using Simulink
 Trajectory = 'Simulink_Trajectory_InfinityShape'
 ControlStrategy = 'Simulink_Controller_Hinf'
 simTime = 40;
 InitCondqp = [0;0;0;0;0;0]
 InitCondq = [8;0;0;0;0;0]
 open_system('SIMULINK_LQR')
 set_param('SIMULINK_LQR/Integratorqpp','InitialCondition',mat2str(InitCondqp))
 set_param('SIMULINK_LQR/Integratorqp','InitialCondition',mat2str(InitCondq))
 set_param('SIMULINK_LQR/Trajectory','MATLABFcn',Trajectory)
 set_param('SIMULINK_LQR/Controller','MATLABFcn',ControlStrategy)
 save_system('SIMULINK_LQR')
 close_system('SIMULINK_LQR')
 out = sim('SIMULINK_LQR',simTime)
 X = out.outX;
 Xref = out.outXref;
 U = out.outU;
 time = linspace(0,simTime, length(X(:,1)));
 %% Plot Results
 fnc_PlotResults(X,Xref,U,time);



