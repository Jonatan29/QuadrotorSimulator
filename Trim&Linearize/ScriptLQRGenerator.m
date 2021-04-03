load linsys

co = ctrb(linsys.A,linsys.B);
posto = rank(co)

Q = diag([10 10 10 1 1 1 5 5 5 1 1 1]);
R = diag([0.1 0.1 0.1 0.1]);
N = 0;
[K,S,E] = lqr(linsys.A,linsys.B,Q,R,N)
dlmwrite('K.txt',K,'delimiter',',');