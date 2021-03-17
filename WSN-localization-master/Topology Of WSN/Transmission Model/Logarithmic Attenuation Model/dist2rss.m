function [RSS,RSS_NOFADING]=dist2rss(dist)
%~~~~~~~~Logarithmic Attenuation Model~~~~~~~~~
%   In this model, the radio range is a circle
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% ReceivedSignalStrength=SendingPower-PathLoss+Fading
% e.g, RSS=Pt-Pl(d0)-10*��*log10(dist/d0)+X��
% Pt:transmit power
% pl(d0):the pass loss for a reference distance of d0
% ��is the path loss exponent
% X��:Gaussian random variable of zero mean and ��^2variance N(0,��^2)
% above parameters are saved in '../Parameters_Of_Models.mat'
% dist:distance between sender and receiver(m)

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% typical value:Pt=0-4dBm(max),Pl(d0)=55dB(d0=1m),��(2~4)=4(indoor,outdoor)
% X��~N(0,��); ��=4~10
    load '../Parameters_Of_Models.mat';
    RSS_NOFADING=Pt-Pl_d0-10*eta*log10(dist/d0);
    RSS=RSS_NOFADING+normrnd(0,delta,size(RSS_NOFADING));
end