%%%%%%%%%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [A, E, err]=fenjie(D,lambda,mu,alph,muup,maxIter,tol1,tol2)


[m, n]=size(D);
r=4; %向外延拓r个像素宽度，减少周期边界效应

     h=[1 -1];
     otfDx = psf2otf(h,[m+2*r n+2*r]);
     otfDy = psf2otf(h',[m+2*r n+2*r]);
     Denom = abs(otfDx).^2+ abs(otfDy ).^2;%微分算子对应的负的频域拉普拉斯滤波器
     clear otfDx otfDy


%%  
 A0=zeros(m,n);  
 E0=A0;
 Y=0;

%% Start main loop
numIter=0 ;
dnorm=norm(D,'fro');
tol1=tol1*dnorm;
tol2=tol2*dnorm;

while numIter<maxIter
           Denom1=Denom/mu+1;
           U0=D-E0+Y/mu; 
           U01=padarray(U0,[r r],'replicate');
           fU0=fft2(U01);
           A=real(ifft2(fU0./Denom1));
           A=A(r+1:end-r,r+1:end-r);
           t=lambda/mu;
           d=D-A+Y/mu;
%               d=D+A+Y/mu;



           E=max(d-t,0)+min(d+t,0);
            Y=Y+mu*(D-A-E);

          mu=min(mu*alph,muup);

          numIter=numIter+1;
          err(numIter,:)=[norm(D-A-E,'fro'),norm(E-E0,'fro')];
          E0=E;
          A0=A;
        if err(numIter,1)<tol1 && err(numIter,2)<tol2
              break;
         end
end
err=err/dnorm;
