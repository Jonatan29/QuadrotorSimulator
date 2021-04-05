function [P,K,diagnostic,primal,gamma] = LMI_Hinf(A,B,Bw,C,D,mu)
%% Define Matrix Dimensions
nx = size(A,1);
nu = size(B,2);
nz = size(C,1);
nw = size(D,2);
%% Define Decision Variables
P = sdpvar(nx,nx,'symmetric');
Y = sdpvar(nu,nx);
X = sdpvar(nx,nx);
gamma = 0.000000001;
%% Define LMIs
LMIs = [];

LMIs = LMIs + (P >=0);
% Bounded Real Lemma
Q = blkvar;
% Q(1,1) = A*P + P*A' + B*Y + Y'*B';
% Q(1,2) = Bw;
% Q(1,3) = P*C' + Y'*D';
% Q(2,2) = -gamma*eye(nw);
% Q(2,3) = D';
% Q(3,3) = -gamma*eye(nz);
Q(1,1) = A*X + X'*A' + B*Y + Y'*B';
Q(1,2) = P - X + mu*(X'*A' + Y'*B');
Q(1,3) = Bw;
Q(1,4) = X'*C' + Y'*D';
Q(2,2) = -mu*(X + X');
Q(2,3) = mu*Bw;
Q(2,4) = zeros(nx,nz)
Q(3,3) = -gamma*eye(nw)
Q(3,4) = D';
Q(4,4) = -gamma*eye(nz);
LMIs = LMIs + (Q <= 0);
%% Solve Optimization Problem
diagnostic = optimize(LMIs,gamma);
checkset(LMIs);
primal = checkset(LMIs);
gamma = double(gamma);
P = double(P);
X = double(X);
Y = double(Y);
K = Y*inv(X);

end

