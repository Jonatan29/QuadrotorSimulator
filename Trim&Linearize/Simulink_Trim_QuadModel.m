function [qpp] = Simulink_Trim_QuadModel(inputs)

x = inputs(1);
y= inputs(2);
z= inputs(3);
phi= inputs(4);
theta= inputs(5);
psi= inputs(6);
xp= inputs(7);
yp= inputs(8);
zp= inputs(9);
phip= inputs(10);
thetap= inputs(11);
psip = inputs(12);
f3 = inputs(13);
f4 = inputs(14);
f1 = inputs(15);
f2= inputs(16);


q = [x;y;z;phi;theta;psi];
qp = [xp;yp;zp;phip;thetap;psip];

%% Use the Parameters values from param file
%addpath('..\QuadParameters')
parameters = QuadrotorParameters();

%% Get The Euler Lagrange Matrices
%addpath('..\fnc_general')
[M, C, G] = GetEulerLagrange(q,qp,parameters);

%% Get Orientation Matrix and Euler Matrix
Rx = Rotx(phi);
Ry = Roty(theta);
Rz = Rotz(psi);
RIB = Rz*Ry*Rx;
Wn = [1 0 -sin(theta); 0 cos(phi) sin(phi)*cos(theta); 0 -sin(phi) cos(phi)*cos(theta)];
%% Generalized Forces Coupling Matrix
beta = parameters.beta;
b = parameters.b;
l = parameters.l;
k_coef = parameters.k_coef;
sinbeta = sin(beta);
cosbeta = cos(beta);

 B1 = [RIB,zeros(3,3);zeros(3,3),inv(Wn)];%conferir depois
 B2 = ([-b*sinbeta,0,b*sinbeta,0;
      0,-b*sinbeta,0,b*sinbeta;
      b*cosbeta,b*cosbeta,b*cosbeta,b*cosbeta;
      0,l*b*cosbeta,0,-l*b*cosbeta;
      -l*b*cosbeta,0,l*b*cosbeta,0;
      k_coef*cosbeta,-k_coef*cosbeta,k_coef*cosbeta,-k_coef*cosbeta])*(1/b);   


% B1 = [inv(Wn),zeros(3,3);zeros(3,3),RIB];%conferir depois
% B2 = ([0,l*b*cosbeta,0,-l*b*cosbeta;
%      -l*b*cosbeta,0,l*b*cosbeta,0;
%      k_coef*cosbeta,-k_coef*cosbeta,k_coef*cosbeta,-k_coef*cosbeta;
%     -b*sinbeta,0,b*sinbeta,0;
%      0,-b*sinbeta,0,b*sinbeta;
%      b*cosbeta,b*cosbeta,b*cosbeta,b*cosbeta])*(1/b);  



CouplingMatrix = B1*B2;   

%% Euler Lagrange Nonlinear Model
u = [f3;f4;f1;f2];
qpp = M\(CouplingMatrix*u - G - C*qp);

end

