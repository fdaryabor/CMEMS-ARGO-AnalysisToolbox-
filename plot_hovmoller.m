%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ftp://nrt.cmems-du.eu/Core/INSITU_BS_NRT_OBSERVATIONS_013_034/bs_multiparameter_nrt/history/PF/

%The final objective is 
%To have a map of spatial coverage of INS data from above link
%To have a table, like the one you Farshid prepared for today discussion with total number of observations coming from INS data from the above link VS the REP dataset

%We need also to understand the issue of the Hovmoller.

%©Farshid Dartabor Apr 2020
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear all
close all
clc
%
ncvars = {'PRES_QC', 'PRES', 'TEMP_QC', 'TEMP', 'PSAL_QC', 'PSAL'};

%ncvars = {'PRES_ADJUSTED_QC', 'PRES_ADJUSTED', ...
%    'TEMP_ADJUSTED_QC', 'TEMP_ADJUSTED', 'PSAL_ADJUSTED_QC', 'PSAL_ADJUSTED'};

Var_type = 'NRT';

gridfile = 'D:\Farshid-Daryabor\d_driver\CMEMS_BS_QUID\Argo_Matlab\mesh_mask_bs.nc';
%
YEAR = 2018;

tlower='01-Jan-2018';
tupper='30-Dec-2018';

hlimit = -200;

T_min = 8;  T_max = 28;
S_min = 18; S_max = 22;
%

mypath = 'D:\Farshid-Daryabor\d_driver\CMEMS_BS_QUID\bs_nrt_history_PF\Data\';

ncfiles='*.nc';

fgpath  = ['F:\AWI-2021\groupmeeting_May\' Var_type '\'];

%fgpath  = ['D:\Farshid-Daryabor\d_driver\CMEMS_BS_QUID\bs_nrt_history_PF\Figure\' Var_type '\'];

[lon,lat,time,Pres,Temp,Psal,pn]=extract_unique_argo_profile_new(mypath,...
    ncfiles,ncvars,tlower,tupper);

for i_pn = 1 : length(pn)
    fprintf('plat_form_code=   %d %d %d  %07.0f ',    pn(i_pn));
end

% total_number_observation = sum ( cell2mat( cellfun(@(a) number_observation(a), ...
%          Pres, 'uni',0) ) );

Time = datetime(time*60*60*24,'ConvertFrom','epochtime','Epoch','1950-01-01');
%
%sort time and data  January - December   
[date,Indx] = sort(Time);

lon_new = lon(Indx);
lat_new = lat(Indx);

T_new = Temp(:,Indx);
P_new = Pres(:,Indx);
S_new = Psal(:,Indx);


%filter depth <5m
[P_new1,T_new1,S_new1] = filter_desired_depth(P_new,T_new,S_new,5);


[P_new2,T_new2,S_new2,Time_new,X,Y]=delet_all_nan_profile(P_new1,T_new1,S_new1,date,lon_new,lat_new);


NaN_rows = find(all(isnan(P_new2),2));
P_new2(NaN_rows,:)=[];
T_new2(NaN_rows,:)=[];
S_new2(NaN_rows,:)=[];

% newDepth = linspace (5, max (max(P_new2)), 300);
% 
% for i = 1 : size(P_new2,2)
%     Tq(:,i) = profile_interpolation(P_new2(:,i),T_new2(:,i),newDepth);
%     Sq(:,i) = profile_interpolation(P_new2(:,i),S_new2(:,i),newDepth);
%     Pq(:,i) = profile_interpolation(P_new2(:,i),P_new2(:,i),newDepth);
% end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%HOVMOLLER PLOT
%
fig1 = figure ;
%set(gcf, 'Position',[100 100 800 560]);
set(gcf, 'Position', [500, 500, 1500, 500]);
pcolor(datenum(Time_new),-P_new2,T_new2);shading flat;colorbar
set(gca,'Color',[0.5 0.5 0.5]);
colormap(jet)

set(gca, 'XScale', 'log');
set(gca, 'XTickLabel', get(gca,'XTick'))

grid on
grid minor

caxis([T_min T_max]);
ylim([hlimit 0])

%datetick('x', 'yyyy-mmm',  'keeplimits')
datetick('x', 'yyyy-mmm-dd',  'keepticks')
set(gca,'XTickLabelRotation',45)         
ylabel('Depth (m)')
xlabel('Time')
set(gca,'FontSize',12);
colorbar
hcb=colorbar;
hcb.FontSize=14;
xlabel(hcb,'Temperature (\circC)','fontsize',12),
%title({['Hovmoller diagram of ARGO T-profiles at basin scale'], ...
%                  ['Platform Number'   ':'  num2str(pn(platform_number),'%07.0f')]})

title({['Hovmoller diagram of ARGO T-profiles at basin scale for Year  ', num2str(YEAR,'%04.0f')], ...
                  ['Number of platform'   '='  num2str(length(pn))]})
%

%
disp('save figure in the host directory and folder')
FT1 = [fgpath,'Hovmoller_T' '_' num2str(hlimit,'%04.0f') '(depth)' ...
    '_' num2str(YEAR,'%04.0f')];
set(fig1, 'InvertHardcopy', 'off')
saveas(fig1,sprintf('%s.jpeg',FT1))
%saveas(fig1,FT,'epsc2')  
%

fig2 = figure ;
%set(gcf, 'Position',[100 100 800 560]);
set(gcf, 'Position', [500, 500, 1500, 500]);
pcolor(datenum(Time_new),-P_new2,S_new2);shading flat;colorbar
set(gca,'Color',[0.5 0.5 0.5]);
colormap(jet)

set(gca, 'XScale', 'log');
set(gca, 'XTickLabel', get(gca,'XTick'))

grid on
grid minor

caxis([S_min S_max]);
ylim([hlimit 0])

%datetick('x', 'yyyy-mmm',  'keeplimits')
datetick('x', 'yyyy-mmm-dd',  'keepticks')
set(gca,'XTickLabelRotation',45)         
ylabel('Depth (m)')
xlabel('Time')
set(gca,'FontSize',12);
colorbar
hcb=colorbar;
hcb.FontSize=14;
xlabel(hcb,'Salinity (psu)','fontsize',12),
%title({['Hovmoller diagram of ARGO S-profiles at basin scale'], ...
%                  ['Platform Number'   ':'  num2str(pn(platform_number),'%07.0f')]})

title({['Hovmoller diagram of ARGO S-profiles at basin scale for Year  ', num2str(YEAR,'%04.0f')], ...
                  ['Number of platform'   '='  num2str(length(pn))]})

%
disp('save figure in the host directory and folder')
FT2 = [fgpath,'Hovmoller_S' '_' num2str(hlimit,'%04.0f') '(depth)' ...
    '_' num2str(YEAR,'%04.0f')];
set(fig2, 'InvertHardcopy', 'off')
saveas(fig2,sprintf('%s.jpeg',FT2))
%saveas(fig1,FT,'epsc2')  
% % %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MAP OF DISTRIBUTION OF ARGO
%
% JJ    = cellfun(@numel, lon); LL = max(JJ);
% x     = cellfun(@(aa) [aa; nan(LL - numel (aa), 1)], lon, 'uni' , 0);
% y     = cellfun(@(aa) [aa; nan(LL - numel (aa), 1)], lat, 'uni' , 0);
% X     = cell2mat(x);
% Y     = cell2mat(y);
% X_out = reshape(X,length(X)/length(x),length(x));
% Y_out = reshape(Y,length(Y)/length(y),length(y));
% %
%Number of observations
%
for ii = 1 : size(P_new2,2)
    num_no_nans(ii) = sum (~ isnan (P_new2 (:, ii)));
end
sum_obs = sum(num_no_nans);
%
disp('')
disp(['Number of platform = '  num2str(length(pn))])
disp('')
disp('')
fig_map1 = argo_map(gridfile,X, Y);
str = {['Number of Platform = '  num2str(length(pn))], ...
          ['Number of profiles = '  num2str(length(X(~isnan(X))))], ...
             ['Number of observations = ' num2str(sum_obs)]         };
text(36,46,str,'FontSize',14)
title(['Spatial distribution of ARGO at basin scale for Year', ...
                 num2str(YEAR,'%04.0f')])
disp('save figure in the host directory and folder')
filename_map1 = [fgpath,'Argo_Map_' num2str(YEAR,'%04.0f')];
set(fig_map1, 'InvertHardcopy', 'off')
saveas(fig_map1,sprintf('%s.jpeg',filename_map1))  
%saveas(fig_map,filename_map,'epsc2')
%
