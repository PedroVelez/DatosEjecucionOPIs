clear all;close all

anho(2)=2014;
ifilOPI(2)=[83];
CodigoPestCSIC(2,:)='AE';

anho(end+1)=2015;
ifilOPI(end+1)=[79];
CodigoPestCSIC(end+1,:)='AE';

anho(end+1)=2016;
ifilOPI(end+1)=[80];
CodigoPestCSIC(end+1,:)='AE';

anho(end+1)=2017;
ifilOPI(end+1)=[79];

anho(end+1)=2018;
ifilOPI(end+1)=[78];

anho(end+1)=2019;
ifilOPI(end+1)=[84];


%% lee datos

for ianho=2:7
    fileIn=sprintf('./%04d/ORGANISMOS DICIEMBRE %02d.xlsx',anho(ianho),anho(ianho));
    fprintf('\n>>>> %04d %s\n',anho(ianho),fileIn)
    
    %fprintf('%s Reading %s\n',tOPI{iOPI},fileIn)
    %1 GASTOS DE PERSONAL
    T=readtable(fileIn,'Sheet','OAG04');
    iCap=1;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    %2 GASTOS CORRIENTES EN BIENES Y SERVICIOS
    T=readtable(fileIn,'Sheet','OAG05');
    iCap=2;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    %3 GASTOS FINANCIEROS
    T=readtable(fileIn,'Sheet','OAG06');
    iCap=3;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    %4 TRANSFERENCIAS CORRIENTES
    T=readtable(fileIn,'Sheet','OAG07');
    iCap=4;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    %6 INVERSIONES REALES
    T=readtable(fileIn,'Sheet','OAG08');
    iCap=6;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    %7 TRANSFERENCIAS DE CAPITAL
    T=readtable(fileIn,'Sheet','OAG09');
    iCap=7;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    
    %8 ACTIVOS FINANCIEROS
    T=readtable(fileIn,'Sheet','OAG10');
    iCap=8;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    %9 PASIVOS FINANCIEROS
    T=readtable(fileIn,'Sheet','OAG11');
    iCap=9;
    OPI{iCap}=table2struct(T(ifilOPI(ianho),:));
    
    
    %Revisa nombre OPIS
    for iCap=[1:4 6:9]
        fprintf('%04d %s Cap %02d\n',anho(ianho),OPI{iCap}.Var1,iCap)
    end
    
    % Asigno valores
    for iCap=[1:1:4 6:1:9]
        CreditoTotal(ianho,iCap)=OPI{iCap}.Var2;
        
        if strcmp(OPI{iCap}.Var4,'-') == 1
            PagosRealizados(ianho,iCap)=0;
        else
            PagosRealizados(ianho,iCap)=OPI{iCap}.Var4;
        end
        
        CreditoTotal_PREVIO(ianho,iCap)=OPI{iCap}.Var5;
        
        if strcmp(OPI{iCap}.Var7,'-') == 1
            PagosRealizados_PREVIO(ianho,iCap)=0;
        else
            PagosRealizados_PREVIO(ianho,iCap)=OPI{iCap}.Var7;
        end
    end
    
    CreditoTotal(ianho,5)=0;
    CreditoTotal_PREVIO(ianho,5)=0;
    PagosRealizados(ianho,5)=0;
    PagosRealizados_PREVIO(ianho,5)=0;
end


%% Suma BS+IR en el 5.
PagosRealizados(ianho,10)=PagosRealizados(ianho,2)+PagosRealizados(ianho,3);
PagosRealizados_PREVIO(ianho,10)=PagosRealizados_PREVIO(ianho,2)+PagosRealizados_PREVIO(ianho,3);

CreditoTotal(ianho,10)=CreditoTotal(ianho,2)+CreditoTotal(ianho,3);
CreditoTotal_PREVIO(ianho,10)=CreditoTotal_PREVIO(ianho,2)+CreditoTotal_PREVIO(ianho,3);

anho(1)=2013;
for iCap=1:10
    PagosRealizados(1,iCap)=PagosRealizados_PREVIO(2,iCap);
    CreditoTotal(1,iCap)=CreditoTotal(2,iCap);
end


plot(sum(PagosRealizados(:,1:9),2))
hold on
plot(sum(CreditoTotal(:,1:9),2))

ic=0;
for ianho=1:7
    ic=ic+1;
    Total(ic,1:9)=CreditoTotal(ianho,1:9);
    anhoTotal(ic)=anho(ianho);
    ic=ic+1;
    Total(ic,1:9)=PagosRealizados(ianho,1:9);
    anhoTotal(ic)=anho(ianho)+0.5;
end

save('EjecucionIEO','anho','PagosRealizados','CreditoTotal','PagosRealizados_PREVIO','CreditoTotal_PREVIO')
