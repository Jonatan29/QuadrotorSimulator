function [u] = Simulink_Controller_Hinf(inputs)

q = inputs(1:6);
qp = inputs(7:12);
Xref = inputs(13:24);


X = [q;qp];
Erro = X - Xref;


global ProportionalController
K = ProportionalController.K;

u = K*Erro;

end

