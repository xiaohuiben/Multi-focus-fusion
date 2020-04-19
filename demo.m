%%%  %By hui li @BeihangU  2014.9.30 
%  Hui Li*, Li Li, Jixiang Zhang. Multi-focus image fusion based on sparse feature matrix decomposition and morphological filtering [J]. 
%Optics Communications, 512 (2015), 1-11 

tic
close all;
clear all;
clc;

path(path,genpath(pwd));

%  lambda=1.2;
%  mu=.002;
%  muup=inf;
%  alph=2;
%  
% maxIter=100; 
% tol1=1e-4; 
% tol2=1e-4;
%% ≤Œ ˝…Ë÷√
 lambda=2;
 mu=.02;
 muup=inf;
 alph=4;
 
maxIter=100; 
tol1=1e-4; 
tol2=1e-4;
% 

D11=imread('clockA.tif');
D22=imread('clockB.tif');

%  D11=imresize(D11,[512,512]);
% D22=imresize(D22,[512,512]);

 D1= double(D11(:,:,1));
 D2= double(D22(:,:,1));
% [A, E] = inexact_alm_rpca(Im,lambda );

%RPCAÀ„∑®µ√≥ˆœ° Ëæÿ’ÛE


% [m,n]=size(D1);
% [mf,nf]=size(D2);
% [A1,E1]=inexact_alm_rpca(D1,1/max(sqrt(max(m,n))));
% [A2,E2]=inexact_alm_rpca(D2,1/max(sqrt(max(mf,nf))));

 [A1, E1, err]=fenjie(D1,lambda,mu,alph,muup,maxIter,tol1,tol2);
 [A2, E2, err]=fenjie(D2,lambda,mu,alph,muup,maxIter,tol1,tol2);
%  [A1, E1, err]=fenjie2(D1,lambda,mu,alph,muup,maxIter,tol1,tol2);
%  [A2, E2, err]=fenjie2(D2,lambda,mu,alph,muup,maxIter,tol1,tol2);
%  [A1, E1, err]=fenjie3(D1,lambda,mu,alph,muup,maxIter,tol1,tol2);
%  [A2, E2, err]=fenjie3(D2,lambda,mu,alph,muup,maxIter,tol1,tol2);
%  [A1, E1, err]=fenjie4(D1,lambda,mu,alph,muup,maxIter,tol1,tol2);
%  [A2, E2, err]=fenjie4(D2,lambda,mu,alph,muup,maxIter,tol1,tol2);

%  D=rgb2gray(D);
% A1= A1 - min(A1(:));
% midA=max(max(A1));
% A1=A1/midA.*255;
% A1=uint8(A1);
% %***********************************************
% E1= E1 - min(E1(:));
% midE=max(max(E1));
% E1=E1/midE.*255;
% E1=uint8(E1);
% 
% %***********************************************
% A2= A2 - min(A2(:));
% midAa=max(max(A2));
% A2=A2/midAa.*255;
% A2=uint8(A2);
% %***********************************************
% E2= E2 - min(E2(:));
% midEe=max(max(E2));
% E2=E2/midEe.*255;
% E2=uint8(E2);

 figure(1),subplot(1,3,1),imshow(uint8(D1),[]);title('‘≠ÕºœÒ');
           subplot(1,3,2),imshow(E1,[]);title('œ° Ëæÿ’Ûª÷∏¥µƒÕºœÒ');
           subplot(1,3,3),imshow(A1,[]);title('µÕ÷»æÿ’Ûª÷∏¥µƒÕºœÒ');
  figure(2),subplot(1,3,1),imshow(uint8(D2));title('‘≠ÕºœÒ');
           subplot(1,3,2),imshow(E2,[]);title('œ° Ëæÿ’Ûª÷∏¥µƒÕºœÒ');
           subplot(1,3,3),imshow(A2,[]);title('µÕ÷»æÿ’Ûª÷∏¥µƒÕºœÒ');
           
 figure(3),subplot(1,3,1),imhist(uint8(D1));title('‘≠Õº÷±∑ΩÕº');
           subplot(1,3,2),imhist(E1);title('œ° Ëª÷∏¥÷±∑ΩÕº');
           subplot(1,3,3),imhist(A1);title('µÕ÷»æÿ’Û÷±∑ΩÕº');
  

E1=double(E1);
E2=double(E2);
E0=(E1+E2)/2;
 


se = strel('disk',5);
J = imtophat(E0,se);



se = strel('disk',5);
J1 = imbothat(E0,se);
% J1=im2bw(J1,0.9);



df=(D1+D2)/2;
df=double(df);
J=double(J);
J1=double(J1);

df1=df-1*J1+1*J;
df1=uint8(df1);
% figure,imshow(df1,[]);title('fusion image');

 figure(4),subplot(1,3,1),imshow(D11,[]);
       subplot(1,3,2),imshow(D22,[]);
        subplot(1,3,3),imshow(df1,[]);imwrite(df1,'Ourfusionleaf.tif')
        toc
