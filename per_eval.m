function [Se,Sp,ppv,Npv,Acc]=per_eval(img,M);
id1=find(img==1);
id2=find(M==1);
sp=intersect(id1,id2);
tp=numel(sp);
fn=abs(numel(id2)-tp);
fp=abs(numel(id1)-tp);
im1=find(img==0);
im2=find(M==0);
ssp=intersect(im1,im2);
tn=numel(ssp);
%------------------------------------------------
Se=tp/(tp+fn);
Sp=tn/(tn+fp);
ppv=tp/(tp+fp);
Npv=tn/(tn+fn);
Acc=(tp+tn)/(tp+tn+fp+fn);

%=====
% M=JJ;
% img=B16;
% %----------------------------------------------
% id1=find(img==1);
% id2=find(M==1);
% sp=intersect(id1,id2);
% tp=numel(sp);
% fn=abs(numel(id2)-tp);
% fp=abs(numel(id1)-tp);
% im1=find(img==0);
% im2=find(M==0);
% ssp=intersect(im1,im2);
% tn=numel(ssp);
% %------------------------------------------------
% Se=tp/(tp+fn)
% Sp=tn/(tn+fp)
% ppv=tp/(tp+fp)
% Npv=tn/(tn+fn)
% Acc=(tp+tn)/(tp+tn+fp+fn)
