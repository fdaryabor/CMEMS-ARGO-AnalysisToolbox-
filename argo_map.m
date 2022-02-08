function fig = argo_map(gridfile,lon_cmems_out, lat_cmems_out)
nc = netcdf(gridfile);
lon_nemo=nc{'nav_lon'}(:);
lat_nemo=nc{'nav_lat'}(:);
mask_rho=nc{'tmaskutil'}(:);
close(nc)
%nc=netcdf(bathyfile);
%h=nc{'Bathymetry'}(:);
%close(nc)
h = 0.*lon_nemo;
mask_rho(~mask_rho)=NaN;
h=h .* -mask_rho;
fig = figure;
set(gcf, 'Position', [500, 500, 1000, 500]);
pcolorjw(lon_nemo,lat_nemo,-h);
set(gca,'Color',[0.5 0.5 0.5]);
colormap(white)
hold on
aa = scatter(lon_cmems_out, lat_cmems_out);
aa.LineWidth = 1;
aa.MarkerEdgeColor = 'b';
aa.MarkerFaceColor = [0 0.5 0.5];
xlabel('Longitude');
ylabel('Latitude');
set(gca,'FontSize',18);
grid on    
    



