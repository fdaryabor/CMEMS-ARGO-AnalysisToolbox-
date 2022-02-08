function [dep_out,tem_out,sal_out]=filter_desired_depth(Mydepth,Mytempe,Mysalin,filter_depth_value)

newdepth = reshape(Mydepth,[],1);
newtempe = reshape(Mytempe,[],1);
newsalin = reshape(Mysalin,[],1);
%
[idx] = find(newdepth<filter_depth_value); 
newdepth(idx)=NaN;
newtempe(idx)=NaN;
newsalin(idx)=NaN;
%
dep_out = reshape(newdepth,size(Mydepth));
tem_out = reshape(newtempe,size(Mytempe));
sal_out = reshape(newsalin,size(Mysalin));
end
