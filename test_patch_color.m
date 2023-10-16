% this is the file for testing with patches
clc;
clear
close all
imgDir=fullfile(pwd,'IMAGES');
imds=imageDatastore(imgDir);
P=5;
I=imread(imds.Files{P});
I=imresize(I,[512,512]);
figure,imshow(I);title('Input Image');
bsz=64;nb=size(I,1)/bsz;
load net_new6

for ii=0:nb-1
    for jj=0:nb-1
        BLK=I(ii*bsz+[1:bsz],jj*bsz+[1:bsz],:);
        C2=semanticseg(BLK,net_new6);
        D=(double(C2)==2);
        %subplot(8,8,t),imshow(D;
        %D=medfilt2(D,[2,2]);
        R(ii*bsz+[1:bsz],jj*bsz+[1:bsz])=D;
       
    end
end
figure,imshow(R)
%R=medfilt2(R,[2,2]);
%figure,imshow(M)
%======
MDir=fullfile(pwd,'MANUAL');
Mds=imageDatastore(MDir);
J=imread(Mds.Files{P});
J=imresize(J,[512,512]);
J=double(im2bw(J));

fun = @(x) (bwarea(x)>8);
BD = nlfilter(R,[3 3],fun);

%figure,imshow(R)
BD=BD.*J;
figure,imshow(BD);title('Segmented Image');
figure,imshow(J);title('Ground truth Image');
% figure,imshow(BD.*J)

[Se,Sp,ppv,Npv,Acc]=per_eval(BD,J)

        