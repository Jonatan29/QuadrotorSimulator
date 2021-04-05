function [ Rx ] = Rotx( ang )
%ROTX Summary of this function goes here
%   Detailed explanation goes here
%ang = deg2rad(ang);
Rx = [1,0,0;0,cos(ang),-sin(ang);0,sin(ang),cos(ang)];
end

