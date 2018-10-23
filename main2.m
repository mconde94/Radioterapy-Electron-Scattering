clc;
clear all;

global massaVolumica tamanho raio

massaVolumica=1.0; %g/cm³
tamanho=3; %tamanho do tecido cm
raio=1; %raio do mamilo cm


%CONDICOES DE SIMULACAO
%radiacao com 3 MeV
EnergiaInicialFotao=3.0e+6; %energia do fotao em eV
EnergiaPPares=1.022e+6;
ratio=4.0e-2;
secaoCompton=20;
secaoPPares=1;
ProbPPares=1/(1+secaoCompton/secaoPPares);
xFotoes=[];
yFotoes=[];
xPositroes=[];
yPositroes=[];
xEletroes=[];
yEletroes=[];
EnergiaEletroes=[];
EnergiaPositroes=[];
EnergiaFotoes=[];
Nfotoes=10000;


%SIMULACAO
for i=1:Nfotoes
    %posicao inicial do Fotao
    PosicaoFotao=[0 0];
    EnergiaFotao=EnergiaInicialFotao;
    teta=0;
    InteracaoFotao=0;
    L=Distancia(ratio,PosicaoFotao,teta);
    %na primeira interacao se sair logo do tecido não chega a haver interacao
    %e nao sera contado
    PosicaoFotao=PosicaoFotao+L*[cos(teta) sin(teta)];
    while(DentroDoTecido(PosicaoFotao)==0)
        if rand()<ProbPPares && EnergiaFotao>=EnergiaPPares
            %PRODUCAO DE PARES
            [AngUp,AngDown,EPpares]=ProducaoDePares(EnergiaFotao,teta);
            PosicaoUp=Angulo(PosicaoFotao,AngUp);
            PosicaoDown=Angulo(PosicaoFotao,AngDown);
            if rand()<0.5
                xPositroes=[xPositroes PosicaoUp(1)];
                yPositroes=[yPositroes PosicaoUp(2)];
                xEletroes=[xEletroes PosicaoDown(1)];
                yEletroes=[yEletroes PosicaoDown(2)];
            else
                xPositroes=[xPositroes PosicaoDown(1)];
                yPositroes=[yPositroes PosicaoDown(2)];
                xEletroes=[xEletroes PosicaoUp(1)];
                yEletroes=[yEletroes PosicaoUp(2)];
            end
            EnergiaEletroes=[EnergiaEletroes EPpares];
            EnergiaPositroes=[EnergiaPositroes EPpares];
            break
        else
            %EFEITO DE COMPTON
            [teta,EnergiaFotao,fi,EnergiaEletrao]=Compton(EnergiaFotao,teta);
            EnergiaEletroes=[EnergiaEletroes EnergiaEletrao];
            PosicaoEletrao=Angulo(PosicaoFotao,fi);
            xEletroes=[xEletroes PosicaoEletrao(1)];
            yEletroes=[yEletroes PosicaoEletrao(2)];
            InteracaoFotao=1;
        end
        L=Distancia(ratio,PosicaoFotao,teta);
        PosicaoFotao=PosicaoFotao+L*[cos(teta) sin(teta)];
    end
    if InteracaoFotao==1
        PosicaoFinalFotao=Angulo(PosicaoFotao,teta);
        EnergiaFotoes=[EnergiaFotoes EnergiaFotao];
        xFotoes=[xFotoes PosicaoFinalFotao(1)];
        yFotoes=[yFotoes PosicaoFinalFotao(2)];
    end
end
SemInteracao=100*abs(Nfotoes-length(EnergiaFotoes))/Nfotoes;
str1 = sprintf('%f por cento dos fotões não interagiu com o tecido',SemInteracao);
disp(str1);


%PLOTS
figure(1);
subplot(3,1,1);
histogram2(xFotoes,yFotoes);
xlabel('x (cm)');
ylabel('y (cm)');
title('Posição de saída dos fotões');
subplot(3,1,2);
histogram2(xEletroes,yEletroes);
xlabel('x (cm)');
ylabel('y (cm)');
title('Posição de saída dos eletrões');
subplot(3,1,3);
histogram2(xPositroes,yPositroes,36);
xlabel('x (cm)');
ylabel('y (cm)');
title('Posição de saída dos positrões');
figure(2);
subplot(3,1,1);
histogram(EnergiaFotoes);
xlabel('Energia (eV)');
title('Energia dos Fotões recolhidos');
subplot(3,1,2);
histogram(EnergiaEletroes);
xlabel('Energia (eV)');
title('Energia dos Eletrões recolhidos');
subplot(3,1,3);
histogram(EnergiaPositroes);
xlabel('Energia (eV)');
title('Energia dos Positrões recolhidos');