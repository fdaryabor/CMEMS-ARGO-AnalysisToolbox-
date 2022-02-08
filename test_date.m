function [indx,time_out]=test_date(Time,tlower,tupper)

indx = ( tlower<= Time & Time<tupper )';
time_out = Time(indx); 
end