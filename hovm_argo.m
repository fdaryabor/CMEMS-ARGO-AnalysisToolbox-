clear all
close all
clc
%
Var_type = 'NRT';
%
YEAR = 20162018;

T_min = 8;  T_max = 28;
S_min = 18; S_max = 22;
hlimit = -200;

%gridfile = 'D:\CMEMS_BS_QUID\Argo_Matlab\mesh_mask_bs.nc';
%mypath = 'D:\CMEMS_BS_QUID\bs_profiler_glider\';

gridfile = 'D:\Farshid-Daryabor\d_driver\CMEMS_BS_QUID\Argo_Matlab\mesh_mask_bs.nc';

matpath = 'D:\Farshid-Daryabor\d_driver\CMEMS_BS_QUID\bs_profiler_glider\';
matfiles = '*.mat';

mypath = ['F:\AWI-2021\groupmeeting_May\' Var_type '\'];
%
[T,S,P,lon,lat,time,pn]=merge_profiles(matpath,matfiles);
%
Time = datetime(time*60*60*24,'ConvertFrom',...
                 'epochtime','Epoch','1950-01-01');
%
fig1 = figure ;
%set(gcf, 'Position',[100 100 800 560]);
set(gcf, 'Position', [500, 500, 1500, 500]);
pcolor(datenum(Time),-P,T);shading flat;colorbar
colormap(jet)

%set(gca, 'XScale', 'log');
%set(gca, 'XTickLabel', get(gca,'XTick'))

grid on
grid minor

caxis([T_min T_max]);
ylim([hlimit 0])

%datetick('x', 'yyyy-mmm',  'keeplimits')
datetick('x', 'yyyy-mmm',  'keepticks')
         
ylabel('Depth (m)')
xlabel('Time')
set(gca,'FontSize',15);
colorbar
hcb=colorbar;
hcb.FontSize=14;
xlabel(hcb,'Temperature (\circC)','fontsize',12),
title(['Hovmoller diagram of ARGO T-profiles at basin scale in ', ...
                 num2str(YEAR,'%08.0f')])
%
disp('save figure in the host directory and folder')
FT = [mypath,'Hovmoller_T' '_' num2str(hlimit,'%04.0f') '(depth)'];
set(fig1, 'InvertHardcopy', 'off')
saveas(fig1,sprintf('%s.jpeg',FT))
%saveas(fig1,FT,'epsc2')  
%

fig2 = figure ;
%set(gcf, 'Position',[100 100 800 560]);
set(gcf, 'Position', [500, 500, 1500, 500]);
pcolor(datenum(Time),-P,S);shading flat;colorbar
colormap(jet(256))

%set(gca, 'XScale', 'log');
%set(gca, 'XTickLabel', get(gca,'XTick'))

grid on
grid minor

caxis([S_min S_max])
ylim([hlimit 0])

%datetick('x', 'yyyy-mmm',  'keeplimits')
datetick('x', 'yyyy-mmm',  'keepticks')

ylabel('Depth (m)')
xlabel('Time')
set(gca,'FontSize',15);
colorbar
hcb=colorbar;
hcb.FontSize=14;
xlabel(hcb,'Salinity (psu)','fontsize',12),
title(['Hovmoller diagram of ARGO S-profiles at basin scale in ', ...
                 num2str(YEAR,'%08.0f')])
             
disp('save figure in the host directory and folder')
FS = [mypath,'Hovmoller_S' '_' num2str(hlimit,'%04.0f') '(depth)'];
set(fig2, 'InvertHardcopy', 'off')
saveas(fig2,sprintf('%s.jpeg',FS))            
%saveas(fig2,FS,'epsc2')           
%             

fig3 = figure ;
set(gcf, 'Position',[100 100 800 560]);
%set(gcf, 'Position', [500, 500, 1500, 500]);

subplot(2,1,1)
Ta = nanmean(T,1);
tm = reshape(time,[],length(pn));
ta = reshape(Ta,[],length(pn));

Time_1 = datetime(tm(:,1)*60*60*24,'ConvertFrom',...
                  'epochtime','Epoch','1950-01-01');
A1=plot(Time_1,ta(:,1),'k');

hold on

%Time_2 = datetime(tm(:,2),'ConvertFrom','excel');
Time_2 = datetime(tm(:,2)*60*60*24,'ConvertFrom',...
                  'epochtime','Epoch','1950-01-01');
A2=plot(Time_2,ta(:,2),'r');

hold on

%Time_3 = datetime(tm(:,3),'ConvertFrom','excel');
Time_3 = datetime(tm(:,3)*60*60*24,'ConvertFrom',...
                  'epochtime','Epoch','1950-01-01');
A3=plot(Time_3,ta(:,3),'b');


lgd_A=legend([A1;A2;A3],['platform : ' num2str(pn(1),'%07.0f')], ...
    ['platform : ' num2str(pn(2),'%07.0f')], ...
            ['platform : ' num2str(pn(3),'%07.0f')], ...
                     'Orientation','horizontal',...
                                   'Location','southoutside'); 
lgd_A.FontSize = 12;
set(lgd_A,'Color','w')


xlabel('Time','fontsize',14)
ylabel('Temperature (\circC)','fontsize',14)

title(['Time Series: ', num2str(YEAR,'%08.0f')])
                  
%set(gca,'FontSize',18);

grid on
grid minor

                  
subplot(2,1,2)
Sa = nanmean(S,1);

sa = reshape(Sa,[],length(pn));

B1=plot(Time_1,sa(:,1),'k');

hold on

B2=plot(Time_2,sa(:,2),'r');

hold on

B3=plot(Time_3,sa(:,3),'b');


lgd_B=legend([B1;B2;B3],['platform : ' num2str(pn(1),'%07.0f')], ...
    ['platform : ' num2str(pn(2),'%07.0f')], ...
            ['platform : ' num2str(pn(3),'%07.0f')], ...
                     'Orientation','horizontal',...
                                   'Location','southoutside'); 
lgd_B.FontSize = 12;
set(lgd_B,'Color','w')


xlabel('Time','fontsize',14)
ylabel('Salinity (psu)','fontsize',14)

title(['Time Series: ', num2str(YEAR,'%08.0f')])
                  
%set(gca,'FontSize',18);

grid on
grid minor

disp('save figure in the host directory and folder')
FTS = [mypath,'Time Series'];
set(fig3, 'InvertHardcopy', 'off')
saveas(fig3,sprintf('%s.jpeg',FTS))    
%saveas(fig3,FTS,'epsc2')


% plot map of ARGO

disp('')
disp(['Number of platform = '  num2str(size((pn),2))])
disp('')
disp('')
%
disp('')
disp('')
disp(['Number of profiles = '  num2str(size(lon,1))])

disp('')
disp('')
%
fig_map = argo_map(gridfile,lon, lat,0);
str = {['Number of platform = '  num2str(size((pn),2))],['Number of profiles = '  num2str(size(lon,1))]};
text(37,46,str,'FontSize',14)
title(['Spatial distribution of ARGO at basin scale in ', ...
                 num2str(YEAR,'%08.0f')])        
             
disp('save figure in the host directory and folder')
filename_map = [mypath,'Argo_Map_' num2str(YEAR,'%08.0f')];
set(fig_map, 'InvertHardcopy', 'off')
saveas(fig_map,sprintf('%s.jpeg',filename_map))  
%saveas(fig_map,filename_map,'epsc2')
