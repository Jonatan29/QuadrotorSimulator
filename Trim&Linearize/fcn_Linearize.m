function [ ModeloLinearizado] = fcn_Linearize( op_trim0, sistemastring )

    disp('-->Linearizing the System...')
    %Nome do arquivo do simulink
%     Sistema = 'SimUAV5_AdaptiveTrim_Aerod';
  Sistema = sistemastring;  
    %Arquivo com o ponto sobre o qual se quer linearizar
    %load('op_trim0')
    %opções da linearização
    load('linearoptions')
    %modelo linearizado
    ModeloLinearizado = linearize(Sistema,op_trim0,linearoptions);
end

