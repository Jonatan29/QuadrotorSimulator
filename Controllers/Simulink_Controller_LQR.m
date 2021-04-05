function [u] = Simulink_Controller_LQR(inputs)

q = inputs(1:6);
qp = inputs(7:12);
Xref = inputs(13:24);


X = [q;qp];
Ueq = [5.5;5.5;5.5;5.5];
Erro = X - Xref;


global ProportionalController
K = ProportionalController.K;

u = -K*Erro + Ueq;

end

