function [ tetaOut,EFout,fiOut,EEout ] = Compton(E,teta)
Erest=0.5109989461e+6; %energia de repouso do eletrao
random=rand()*2*pi;
if sin(random)>=0
    tetaOut=random+teta;
    fiOut=atan((1/(1+E/Erest))*cot(random/2))-teta;
else
    tetaOut=random-teta;
    fiOut=atan((1/(1+E/Erest))*cot(random/2))+teta;
end
EFout=E/(1+(E/Erest)*(1-cos(random)));
EEout=E-EFout;
end

