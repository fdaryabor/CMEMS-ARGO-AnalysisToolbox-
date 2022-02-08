function [P,T,S,Time,X,Y]=delet_all_nan_profile(P,T,S,Time,X,Y)

index = find(all(isnan(P),1));

Time(index) = []; X(index) = []; Y(index) = []; 
%
P(:,index) = []; T(:,index) = []; S(:,index) = [];
end