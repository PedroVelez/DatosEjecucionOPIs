clear all;close all

tOPI={'INTA  ';'CIEMAT';'INIA  ';'IEO   ';'IGME  ';'ISCIII';'CSIC'};

anho(2)=2014;
ifilOPI(2,:)=[12 82  84 85 83 86 25];
CodigoPestCSIC(2,:)='AE';

anho(end+1)=2015;
ifilOPI(end+1,:)=[8 79 80 81 82 83 25];
CodigoPestCSIC(end+1,:)='AE';

anho(end+1)=2016;
ifilOPI(end+1,:)=[8 80 81 82 83 84 26];
CodigoPestCSIC(end+1,:)='AE';

anho(end+1)=2017;
ifilOPI(end+1,:)=[8 79 80 81 82 83 26];
CodigoPestCSIC(end+1,:)='AE';

anho(end+1)=2018;
ifilOPI(end+1,:)=[8 78 79 80 81 82 40];
CodigoPestCSIC(end+1,:)='OO';

anho(end+1)=2019;
ifilOPI(end+1,:)=[8 84 85 86 87 88 43];
CodigoPestCSIC(end+1,:)='OO';


%% lee datos

for ianho=2:7
    fileIn=sprintf('./%04d/ORGANISMOS DICIEMBRE %02d.xlsx',anho(ianho),anho(ianho));
    fprintf('\n>>>> %04d %s\n',anho(ianho),fileIn)
    for iOPI=1:6
        %fprintf('%s Reading %s\n',tOPI{iOPI},fileIn)
        T=readtable(fileIn,'Sheet','OAG04');
        iCap=1;
        OPI{iOPI,iCap}=table2struct(T(ifilOPI(ianho,iOPI),:));
        
        T=readtable(fileIn,'Sheet','OAG05');
        iCap=2;
        OPI{iOPI,iCap}=table2struct(T(ifilOPI(ianho,iOPI),:));
        
        T=readtable(fileIn,'Sheet','OAG08');
        iCap=3;
        OPI{iOPI,iCap}=table2struct(T(ifilOPI(ianho,iOPI),:));
    end
    %Para el CSIC
    iOPI=7;
    %fprintf('%s Reading %s\n',tOPI{iOPI},fileIn)
    T=readtable(fileIn,'Sheet',strcat(CodigoPestCSIC(ianho,:),'G04'));
    iCap=1;
    OPI{iOPI,iCap}=table2struct(T(ifilOPI(ianho,iOPI),:));
    
    T=readtable(fileIn,'Sheet',strcat(CodigoPestCSIC(ianho,:),'G05'));
    iCap=2;
    OPI{iOPI,iCap}=table2struct(T(ifilOPI(ianho,iOPI),:));
    
    T=readtable(fileIn,'Sheet',strcat(CodigoPestCSIC(ianho,:),'G08'));
    iCap=3;
    OPI{iOPI,iCap}=table2struct(T(ifilOPI(ianho,iOPI),:));
    
    %Revisa nombre OPIS
    for iOPI=1:7
        for iCap=1:3
            fprintf('%04d %s %s Cap %02d\n',anho(ianho),tOPI{iOPI},OPI{iOPI,iCap}.Var1,iCap)
        end
    end
    
    %% Asigno valores
    %"CRÉDITOS TOTALES "OBLIGACIONES RECONOCIDAS "PAGOS REALIZADOS "CRÉDITOS TOTALES "OBLIGACIONES RECONOCIDAS "PAGOS REALIZADOS
    for iCap=1:3
        %1 - Personmal
        %2 - BS
        %3 - IR
        %3 - B+IR
        for iOPI=1:7
            CreditoTotal(ianho,iOPI,iCap)=str2double(OPI{iOPI,iCap}.Var2);
            if strcmp(OPI{iOPI,iCap}.Var4,'-') == 1
                PagosRealizados(ianho,iOPI,iCap)=0;
            else
                PagosRealizados(ianho,iOPI,iCap)=str2double(OPI{iOPI,iCap}.Var4);
            end
            CreditoTotal_PREVIO(ianho,iOPI,iCap)=str2double(OPI{iOPI,iCap}.Var5);
            if strcmp(OPI{iOPI,iCap}.Var7,'-') == 1
                PagosRealizados_PREVIO(ianho,iOPI,iCap)=0;
            else
                PagosRealizados_PREVIO(ianho,iOPI,iCap)=str2double(OPI{iOPI,iCap}.Var7);
            end
        end
    end
    
    %% Suma BS+IR
    for iOPI=1:7
        PagosRealizados(ianho,iOPI,4)=PagosRealizados(ianho,iOPI,2)+PagosRealizados(ianho,iOPI,3);
        PagosRealizados_PREVIO(ianho,iOPI,4)=PagosRealizados_PREVIO(ianho,iOPI,2)+PagosRealizados_PREVIO(ianho,iOPI,3);
        
        CreditoTotal(ianho,iOPI,4)=CreditoTotal(ianho,iOPI,2)+CreditoTotal(ianho,iOPI,3);
        CreditoTotal_PREVIO(ianho,iOPI,4)=CreditoTotal_PREVIO(ianho,iOPI,2)+CreditoTotal_PREVIO(ianho,iOPI,3);
    end
end

anho(1)=2013;
for iOPI=1:size(tOPI,1)
    for iCap=1:4
        PagosRealizados(1,iOPI,iCap)=PagosRealizados_PREVIO(2,iOPI,iCap);
        CreditoTotal(1,iOPI,iCap)=CreditoTotal(2,iOPI,iCap);
    end
end

save('Ejecucion','anho','tOPI','PagosRealizados','CreditoTotal','PagosRealizados_PREVIO','CreditoTotal_PREVIO')
