function [d_out,x_out,y_out,p_out,t_out,s_out]=sever_date(Time,tlower,...
                        tupper,lon,lat,P,T,S)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                    
%find and extract rows from matrix based on date
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
indx = ( tlower<= Time & Time<tupper )';
d_out = Time(indx); x_out = lon(indx); y_out = lat(indx);
p_out = P(:,indx);  t_out = T(:,indx); s_out = S(:,indx);
end