%% Add path to Necessary Files
addpath('Trim&Linearize')
addpath('fnc_general')
addpath('QuadParameters')
addpath('Trajectories')
addpath('SimulinkFiles')
%% Find Nonlinear Model Trim points
SimulinkTrimFile = 'SIMULINK_Trim';
States_q = [0;0;2;0;0;0];
Known_q = [true;true;false;true;true;true];
Min_q = [-Inf;-Inf;1.5;-Inf;-Inf;-Inf];
Max_q = [Inf;Inf;2;Inf;Inf;Inf];
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

%% Design The LQR Controller
Q = diag([10 10 10 1 1 1 5 5 5 1 1 1]);
R = diag([0.1 0.1 0.1 0.1]);
N = 0;
[K,S,E] = lqr(A,B,Q,R,N);
Poles = eig(A - B*K);
co = ctrb(A,B);
ctrbil = rank(co)

global ProportionalController
ProportionalController.K = K;
%% Simulate Using Simulink
trajectorystring = 'Simulink_Trajectory_Helicoidal';
simTime = 40;
InitCondqp = [0;0;0;0;0;0];
InitCondq = [0;0;0;0;0;0];
open_system('SIMULINK_LQR')
set_param('SIMULINK_LQR/Integratorqpp','InitialCondition',mat2str(InitCondqp))
set_param('SIMULINK_LQR/Integratorqp','InitialCondition',mat2str(InitCondq))
set_param('SIMULINK_LQR/Trajectory','MATLABFcn',trajectorystring)
save_system('SIMULINK_LQR')
close_system('SIMULINK_LQR')
out = sim('SIMULINK_LQR',simTime)
X = out.outX;
Xref = out.outXref;
U = out.outU;
time = linspace(0,simTime, length(X(:,1)));
%% Plot Results
fnc_PlotResults(X,Xref,U,time);



