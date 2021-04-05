function [RIB, Wn] = GetOrientationAndEulerMatrices(phi,theta,psi)

%% Orientation wrt Inertial Frame
Rx = Rotx(phi);
Ry = Roty(theta);
Rz = Rotz(psi);
RIB = Rz*Ry*Rx;

%% Euler Matrix
Wn = [1 0 -sin(theta); 0 cos(phi) sin(phi)*cos(theta); 0 -sin(phi) cos(phi)*cos(theta)];
end

