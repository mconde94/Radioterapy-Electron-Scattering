function [ out ] = DentroDoTecido(r)
global tamanho
if (r(1)>tamanho)||(abs(r(2))>tamanho/2)||(r(1)<0)
    out=1; %saiu do tecido    
else
    out=0; %esta dentro do tecido    
end
end

