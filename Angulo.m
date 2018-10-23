function [ out] = Angulo( rvelho, teta)
global tamanho
rnovo=rvelho+tamanho*[cos(teta) sin(teta)];
m=(rnovo(2)-rvelho(2))/(rnovo(1)-rvelho(1));
b=rvelho(2)-rvelho(1)*m;
x=(tamanho/2-b)/m;
y=tamanho/2;
INTERSECOES(1,:)=[x y];
x=(-tamanho/2-b)/m;
y=-tamanho/2;
INTERSECOES(2,:)=[x y];
x=0;
y=b;
INTERSECOES(3,:)=[x y];
x=tamanho;
y=m*tamanho+b;
INTERSECOES(4,:)=[x y];
VALIDAS=[];
for i=1:length(INTERSECOES)
    if DentroDoTecido(INTERSECOES(i,:))==0
        VALIDAS=[VALIDAS;INTERSECOES(i,:)];     
    end
end
DIFERENCA=[];
for i=1:length(VALIDAS)
    DIFERENCA(i)=norm(VALIDAS(i,:)-rnovo);
end
[Minimo,Indice] = min(DIFERENCA);
out=VALIDAS(Indice,:);
end

