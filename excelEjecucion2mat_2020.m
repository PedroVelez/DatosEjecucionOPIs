clear all;close all

tOPI={'INTA  ';'CIEMAT';'INIA  ';'IEO   ';'IGME  ';'ISCIII';'CSIC'};
ifilOPI=[8 84 85 86 87 88 43];
imesf=3;

%% lee datos
for imes=1:1:imesf
    for iOPI=1:6
        iOPI;
        T=readtable(sprintf('./2020/ORGANISMOS%02d2020.xlsx',imes),'Sheet','OAG04');
        ic=1;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
        
        T=readtable(sprintf('./2020/ORGANISMOS%02d2020.xlsx',imes),'Sheet','OAG05');
        ic=2;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
        
        T=readtable(sprintf('./2020/ORGANISMOS%02d2020.xlsx',imes),'Sheet','OAG08');
        ic=3;
        OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    end
    iOPI=7;
    T=readtable(sprintf('./2020/ORGANISMOS%02d2020.xlsx',imes),'Sheet','OOG04');
    ic=1;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    
    T=readtable(sprintf('./2020/ORGANISMOS%02d2020.xlsx',imes),'Sheet','OOG05');
    ic=2;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    
    T=readtable(sprintf('./2020/ORGANISMOS%02d2020.xlsx',imes),'Sheet','OOG08');
    ic=3;
    OPI{iOPI,imes,ic}=table2struct(T(ifilOPI(iOPI),:));
    
end

for iOPI=1:7
    for imes=1:imesf
        for ic=1:3
            fprintf('mes %02d %02d %s\n',imes,ic,OPI{iOPI,imes,ic}.Var1)
        end
    end
    fprintf('\n \n \n')
end


%% Asigno valores
% "CRÉDITOS TOTALES
%"	"OBLIGACIONES RECONOCIDAS
%"	"PAGOS REALIZADOS
%"	"CRÉDITOS TOTALES
%"	"OBLIGACIONES RECONOCIDAS
%"	"PAGOS REALIZADOS

for ic=1:3
    %1 - personmal
    %2 - BS
    %3 - IR
    for iOPI=1:7
        for imes=1:imesf
            OPI_CT(iOPI,ic,imes)=str2num(OPI{iOPI,imes,ic}.Var2);
            
            if strcmp(OPI{iOPI,imes,ic}.Var4,'-') == 1
                OPI_PR(iOPI,ic,imes)=0;
            else
                OPI_PR(iOPI,ic,imes)=str2num(OPI{iOPI,imes,ic}.Var4);
            end
            
            OPI_CT_2019(iOPI,ic,imes)=str2num(OPI{iOPI,imes,ic}.Var5);
            if strcmp(OPI{iOPI,imes,ic}.Var7,'-') == 1
                OPI_PR_2019(iOPI,ic,imes)=0;
            else
                OPI_PR_2019(iOPI,ic,imes)=str2num(OPI{iOPI,imes,ic}.Var7);
            end
            
        end
    end
end

%% Sunmor BSA+IR
for iOPI=1:7
    for imes=1:imesf
        OPI_PR(iOPI,4,imes)=OPI_PR(iOPI,2,imes)+OPI_PR(iOPI,3,imes);
        OPI_PR_2019(iOPI,4,imes)=OPI_PR_2019(iOPI,2,imes)+OPI_PR_2019(iOPI,3,imes);
        
        OPI_CT(iOPI,4,imes)=OPI_CT(iOPI,2,imes)+OPI_CT(iOPI,3,imes);
        OPI_CT_2019(iOPI,4,imes)=OPI_CT_2019(iOPI,2,imes)+OPI_CT_2019(iOPI,3,imes);
    end
end

save('Ejecucion2020','OPI_PR','OPI_CT','OPI_PR_2019','OPI_CT_2019')



