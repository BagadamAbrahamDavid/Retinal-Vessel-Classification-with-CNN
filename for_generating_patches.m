clc
close all
clear;
I=imread('02_test.tif');
I=imresize(I,[512,512]);

K=imread('im02.tif');
K=imresize(K,[512,512]);
figure,imshow(K)
K(K>20)=255;
figure,imshow(K)


bsz=64;nb=size(I,1)/bsz;
t=65;
for ii=0:nb-1
    for jj=0:nb-1
        B=I(ii*bsz+[1:bsz],jj*bsz+[1:bsz],:);
        M=K(ii*bsz+[1:bsz],jj*bsz+[1:bsz]);
        cd TRAIN_P_2
        imwrite(B,strcat('tr',num2str(t),'.bmp'));
        cd ..
        cd LABEL_P_2
        imwrite(M,strcat('lb',num2str(t),'.bmp'));
        cd ..
        t=t+1;
    end
end

