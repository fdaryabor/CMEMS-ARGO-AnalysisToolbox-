function [lon_out,lat_out,TIME_OUT,P_out,T_out,S_out,pn_out]= ...
        select_date_new(mypath,ncfiles,ncvars,tlower,tupper)
%
%tlower='01-Jan-2015';
%tupper='30-Dec-2019';
%
[lon,lat,T,S,P,time,pn]=argo_cmems(mypath,ncfiles,ncvars);

Time = cellfun(@(d) datetime(d*60*60*24,'ConvertFrom',...
                 'epochtime','Epoch','1950-01-01'),time,'uni',0 );
             
             
[indx,time_out]=cellfun(@(a) test_date(a,tlower,tupper), Time,'uni',0 );             
            
num_files = length (Time);
lat_out = cell(num_files, 1);
lon_out = cell(num_files, 1);
pn_out = cell(num_files, 1);

P_out = cell(num_files, 1);
T_out = cell(num_files, 1);
S_out = cell(num_files, 1);
for ii=1:length(Time)
    P_out{ii}=P{ii}(:,indx{ii});
    T_out{ii}=T{ii}(:,indx{ii});
    S_out{ii}=S{ii}(:,indx{ii});
end

P_out (all (cellfun ( 'isempty' , P_out), 2), :) = [];
T_out (all (cellfun ( 'isempty' , T_out), 2), :) = [];
S_out (all (cellfun ( 'isempty' , S_out), 2), :) = [];
%
for ii=1:length(Time)
    lon_out{ii}=lon{ii}(indx{ii});
    lat_out{ii}=lat{ii}(indx{ii});
end
lon_out (all (cellfun ( 'isempty' , lon_out), 2), :) = [];
lat_out (all (cellfun ( 'isempty' , lat_out), 2), :) = [];
%
indx_empty = cellfun(@(a) find(~isempty(a)),time_out,'uni',0 );
for i = 1 : length(Time)
    pn_out{i} = pn{i}(indx_empty{i}); 
end
%
idx = cellfun(@(d) isempty(d), time_out);
time_out(idx) = [];
TIME_OUT = cellfun(@(t) datetime2number(t), time_out, 'uni', 0);
return