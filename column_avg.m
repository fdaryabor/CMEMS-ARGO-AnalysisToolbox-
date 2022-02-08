function var2d = column_avg(depth_3d,var,zmin,zmax)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Function used to get water column average, var is diagnostic variable for analysis
%zmin and zmax ara upper and lower values of the depth to calculate
%Farshid Daryabor, CMCC, Email: farshid.daryabor@cmcc.it
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[N,M,L]=size(depth_3d);
hz = reshape(depth_3d,N,M*L);
[iz,jy] = find(floor(hz)>=zmin & floor(hz)<=zmax);
var0 = reshape(var,N,M*L);
var1= var0(min(iz):max(iz),:);
var2 = squeeze(mean(var1,1));
var2d=reshape(var2,M,L);
return
%