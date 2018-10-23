function [ L ] = Distancia( ratio,posicaoInicial,teta )
random=rand();
ro1=Densidade(posicaoInicial);
mu1=ratio*ro1;
L=-log(1-random)/mu1;
posicaoFinal=posicaoInicial+L*[cos(teta) sin(teta)];
declive=(posicaoFinal(2)-posicaoInicial(2))/(posicaoFinal(1)-posicaoInicial(1));
b=posicaoInicial(2)-posicaoInicial(1)*declive;
flag=0;
delta=0;
if cos(teta)>0 
   delta=0.01;
else    
    delta=-0.01;    
end
ro2=0; mu2=0; mudanca2=0;
ro3=0; mu3=0; mudanca3=0;
for x=posicaoInicial(1):delta:posicaoFinal(1)
    
    y=declive*x+b;
    
    tentativa=[x y];
    
    if Densidade(tentativa)~=ro1
        
        flag=1;
        
        mudanca2=tentativa;
        
        ro2=Densidade(tentativa);
        
        mu2=ratio*ro2;
        
        L=norm(mudanca2-posicaoInicial)+norm(posicaoFinal-mudanca2)*mu1/mu2;
        
        posicaoFinal=posicaoInicial+L*[cos(teta) sin(teta)];
        
        break
        
    end
    
end
if flag==1    
    for x=mudanca2(1):delta:posicaoFinal(1) 
        y=declive*x+b;        
        tentativa=[x y];        
        if Densidade(tentativa)~=ro2            
            mudanca3=tentativa;            
            ro3=Densidade(tentativa);            
            mu3=ratio*ro3;            
            L=norm(mudanca3-posicaoInicial)+norm(posicaoFinal-mudanca3)*mu2/mu3;            
            posicaoFinal=posicaoInicial+L*[cos(teta) sin(teta)];
            break           
        end
    end
end
end