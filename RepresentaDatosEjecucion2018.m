clear all;close all

tOPI={'INTA  ';'CIEMAT';'INIA  ';'IEO   ';'IGME  ';'ISCIII';'CSIC'};

load('Ejecucion2018','OPI_PR','OPI_CT')

%% Ejecucion presupuestaria en el ultimo mes
imesf=12;

for iOPI=1:7
    EP_BSIR_FINAL(iOPI)=(OPI_PR(iOPI,2,imesf)+OPI_PR(iOPI,3,imesf))/(OPI_CT(iOPI,2,imesf)+OPI_CT(iOPI,3,imesf));
    EP_P_FINAL(iOPI)=OPI_PR(iOPI,1,imesf)/OPI_CT(iOPI,1,imesf);
end

imesf=12;
for iOPI=1:7
    figure
    
    hPRirbs=plot(squeeze(OPI_PR(iOPI,4,:))/1000,'r','linewidth',2); hold on; grid on
    hCTirbs=plot([0 12],...
        [OPI_CT( iOPI,4,imesf) OPI_CT(iOPI,4,imesf)]/1000, ...
        'r:','linewidth',2);
    
    hPRper=plot(squeeze(OPI_PR(iOPI,1,:))/1000,'b','linewidth',2); hold on
    hCTper=plot([0 12],[OPI_CT(iOPI,1,imesf) OPI_CT(iOPI,1,imesf)]/1000,'b:','linewidth',2);
    
    Titulo=sprintf('%s Ejecucion IR+BS [2018 %2.0f %%].\nPresupuesto IR+BS [2018 %03.1f M€] \nPresupuesto Personal [2018 %03.1f M€]', ...
        tOPI{iOPI}, ...
        EP_BSIR_FINAL(iOPI)*100 , ...
        OPI_CT(iOPI,4,imesf)/1000, ...
        OPI_CT(iOPI,1,imesf)/1000);
    disp(Titulo)
    title(Titulo)
    ylabel('Millones €')
    xlabel('mes')
    
    legend([hPRirbs,hCTirbs , hPRper,hCTper], ...
        'IR+BS pagos realizados 2018', ...
        'IR+BS creditos totales 2018', ...
        'Personal pagos realizados 2018', ...
        'Personal creditos totales 2018', ...
        'Location','southeast')
    legend('boxoff')
    CreaFigura(gcf,strcat(tOPI{iOPI},'_2018'),4)
end

save('Ejecucion2018','OPI_PR','OPI_CT')
