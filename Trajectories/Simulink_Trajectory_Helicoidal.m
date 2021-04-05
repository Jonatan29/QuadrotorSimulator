function [traj] = Simulink_Trajectory_Helicoidal(inputs)

tempo = inputs(1);
traj = [sin(tempo / 2); cos(tempo / 2); tempo / 10; 0; 0; 0; 0; 0; 0; 0; 0; 0];

end

