function [param] = QuadrotorParameters()
%Define the quadrotor configuration
%% Quad Inertia Parameters
param.m = 2.24;
param.Ixx = 0.0384;
param.Ixy = 0;
param.Ixz = 0;
param.Iyy = 0.0384;
param.Iyz = 0;
param.Izz = 0.0615;
%% Quad Geometric Parameters
% displacement of center of mass to body frame (geometric center)
param.xcm = 0;
param.ycm = 0;
param.zcm = 0;
% quad arm length
param.l =  0.332;
% rotor inclination for control purpouses
param.beta = deg2rad(5);
%% Quad Thruster Parameters
%torsion constant
param.k_coef = 1.7e-7;
% motors coeficient
param.b = 9.5e-6;
%% Gravity 
param.g = -9.78;
end

