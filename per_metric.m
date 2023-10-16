function [SI,CDR,USE,OSE,TSE]=per_metric(img,M);

M=double(im2bw(M));
img=double(im2bw(img));
%----------------------------------------------
id1=find(img==1);
id2=find(M==1);
sp=intersect(id1,id2);
tp=numel(sp);
fn=abs(numel(id2)-tp);
fp=abs(numel(id1)-tp);
%------------------------------------------------
%------------------------------------------------
 SI=2*tp/(2*tp+fp+fn);
 CDR=tp/(tp+fn);
 USE=fp/(tp+fn);
 OSE=fn/(tp+fn);
 TSE=USE+OSE;

