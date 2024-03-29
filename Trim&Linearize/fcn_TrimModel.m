function [op,opreport] = fcn_TrimModel(modelstring,States_q,Known_q,Min_q,Max_q,States_qp,Known_qp,Min_qp,Max_qp,ControlBounds)
%% Search for a specified operating point for the model - SIMULINK_Trim.
%
% This MATLAB script is the command line equivalent of the trim model
% tab in linear analysis tool with current specifications and options.
% It produces the exact same operating points as hitting the Trim button.

% MATLAB(R) file generated by MATLAB(R) 9.8 and Simulink Control Design (TM) 5.5.
%
% Generated on: 04-Apr-2021 15:34:38

%% Specify the model name
% model = 'SIMULINK_Trim';
model = modelstring;
%% Create the operating point specification object.
opspec = operspec(model);

%% Set the constraints on the states in the model.
% - The defaults for all states are Known = false, SteadyState = true,
%   Min = -Inf, Max = Inf, dxMin = -Inf, and dxMax = Inf.

% State (1) - SIMULINK_Trim/Integratorqp
% opspec.States(1).x = [0;0;2;0;0;0];
% opspec.States(1).Known = [true;true;false;true;true;true];
% opspec.States(1).Min = [-Inf;-Inf;1.5;-Inf;-Inf;-Inf];
% opspec.States(1).Max = [Inf;Inf;2;Inf;Inf;Inf];
opspec.States(1).x = States_q;
opspec.States(1).Known = Known_q;
opspec.States(1).Min = Min_q;
opspec.States(1).Max = Max_q;
% State (2) - SIMULINK_Trim/Integratorqpp
% - Default model initial conditions are used to initialize optimization.
% opspec.States(2).Known = [true;true;true;true;true;true];
opspec.States(2).x = States_qp;
opspec.States(2).Known = Known_qp;
opspec.States(2).Min = Min_qp;
opspec.States(2).Max = Max_qp;
%% Set the constraints on the inputs in the model.
% - The defaults for all inputs are Known = false, Min = -Inf, and
% Max = Inf.

% Input (1) - SIMULINK_Trim/f3
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(1).Min = ControlBounds{1}(1);
opspec.Inputs(1).Max = ControlBounds{1}(2);

% Input (2) - SIMULINK_Trim/f4
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(2).Min = ControlBounds{2}(1);
opspec.Inputs(2).Max = ControlBounds{2}(2);

% Input (3) - SIMULINK_Trim/f1
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(3).Min = ControlBounds{3}(1);
opspec.Inputs(3).Max = ControlBounds{3}(2);

% Input (4) - SIMULINK_Trim/f2
% - Default model initial conditions are used to initialize optimization.
opspec.Inputs(4).Min = ControlBounds{4}(1);
opspec.Inputs(4).Max = ControlBounds{4}(2);

%% Set the constraints on the outputs in the model.
% - The defaults for all outputs are Known = false, Min = -Inf, and
% Max = Inf.

% Output (1) - SIMULINK_Trim/Outq
% - Default model initial conditions are used to initialize optimization.

% Output (2) - SIMULINK_Trim/Outqp
% - Default model initial conditions are used to initialize optimization.


%% Create the options
opt = findopOptions('DisplayReport','iter');

%% Perform the operating point search.
[op,opreport] = findop(model,opspec,opt);

end

