clc;
clear all;

global massaVolumica tamanho raio

massaVolumica=1.0; %g/cm³
tamanho=3; %tamanho do tecido cm
raio=1; %raio do mamilo cm


%CONDICOES DE SIMULACAO
%radiacao com 1 KeV
EnergiaInicialFotao=1.0e+3; %energia do fotao em eV
ratio=3.3e+3;
secaoCompton=50;
secaoPPares=300;
ProbPPares=1/(1+secaoCompton/secaoPPares);
xFotoes=[];
yFotoes=[];
xEletroes=[];
yEletroes=[];
EnergiaEletroes=[];
EnergiaFotoes=[];
Nfotoes=1000;



%SIMULACAO
for i=1:Nfotoes
    %posicao inicial do Fotao
    PosicaoFotao=[0 0];
    EnergiaFotao=EnergiaInicialFotao;
    teta=0;
    %se na primeira interacao sair logo do tecido não chega a haver interacao
    %e nao sera contado
    L=Distancia(ratio,PosicaoFotao,teta);
    PosicaoFotao=PosicaoFotao+L*[cos(teta) sin(teta)];
    while(DentroDoTecido(PosicaoFotao)==0)
        %EFEITO DE COMPTON
        [teta,EnergiaFotao,fi,EnergiaEletrao]=Compton(EnergiaFotao,teta);
        EnergiaEletroes=[EnergiaEletroes EnergiaEletrao];
        PosicaoEletrao=Angulo(PosicaoFotao,fi);
        xEletroes=[xEletroes PosicaoEletrao(1)];
        yEletroes=[yEletroes PosicaoEletrao(2)];
        L=Distancia(ratio,PosicaoFotao,teta);
        PosicaoFotao=PosicaoFotao+L*[cos(teta) sin(teta)];
    end
    PosicaoFinalFotao=Angulo(PosicaoFotao,teta);
    EnergiaFotoes=[EnergiaFotoes EnergiaFotao];
    xFotoes=[xFotoes PosicaoFinalFotao(1)];
    yFotoes=[yFotoes PosicaoFinalFotao(2)];
end
SemInteracao=100*abs(Nfotoes-length(EnergiaFotoes))/Nfotoes;
str1 = sprintf('%f por cento dos fotões não interagiu com o tecido',SemInteracao);
disp(str1);



%PLOTS
figure(1);
subplot(2,1,1);
histogram2(xFotoes,yFotoes,36);
xlabel('x (cm)');
ylabel('y (cm)');
title('Posição de saída dos fotões');
subplot(2,1,2);
histogram2(xEletroes,yEletroes);
xlabel('x (cm)');
ylabel('y (cm)');
title('Posição de saída dos eletrões');
figure(2);
subplot(2,1,1);
histogram(EnergiaFotoes);
xlabel('Energia (eV)');
title('Energia dos Fotões recolhidos');
subplot(2,1,2);
histogram(EnergiaEletroes);
xlabel('Energia (eV)');
title('Energia dos Eletrões recolhidos');