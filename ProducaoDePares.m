function [gama1,gama2,Eout] = ProducaoDePares(E,teta )
Erest=0.5109989461e+6; %energia de repouso do eletrao
gama=Erest/(E/2);
gama1=teta+gama;
gama2=teta-gama;
Eout=E/2;
end

