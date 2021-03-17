function dist=rss2dist(RSS,K_i)
%~~~~~~~~~~~~~~~~~~~~~~RIM Model~~~~~~~~~~~~~~~
% ReceivedSignalStrength=SendingPower-DOIAdjustedPathLoss
% e.g, RSS=Pt-Pl(d0)-10*��*log10(dist/d0)*Ki+X��
% Pt:transmit power
% pl(d0):the pass loss for a reference distance of d0
% ��is the path loss exponent
% above parameters are saved in '../Parameters_Of_Models.mat'
% K_i=K_(i-1)+doi; doi~[-DOI,DOI]; 
% dist:distance between sender and receiver(m)
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% mean(X��)=0, needn't take it into consideration when translating RSS to distance 
% ==>dist=d0*10.^((Pt-Pl_d0-RSS)./(10*eta))   
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% typical value:Pt=0-4dBm(max),Pl(d0)=55dB(d0=1m),��(2~4)=4(indoor,outdoor)
% X��~N(0,��); ��=4~10(indoor 7, outdoor 4)
    load '../Parameters_Of_Models.mat';
    dist=d0*10.^((Pt-Pl_d0-RSS)./(10*eta*K_i));
end
