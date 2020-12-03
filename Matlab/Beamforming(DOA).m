clear all;
simplesize= 1000 ;
angles=(-90:0.1:90);
P=6;
doas=[-70 10 80]*pi/180; %DOA of signals.
r=length(doas);
%%=================Compute the simple correlation matrix===================
A=exp(-j*pi*(0:P-1)'*sin([doas(:).']))
%%==========================Generate the signals===========================
for k = 1:3
    s(k,:) = 2*randi([0,1],1,simplesize)-1;
end
noise = sqrt(1/2) * (randn(P,simplesize) + i * randn(P,simplesize));
AA = A * diag(sqrt(P)) * s + noise;

R = AA*AA'/simplesize;
%%===========Eigenvalue and sepration(signals and noise)===================
[Q ,D]=eig(R) 
[D,I]=sort(diag(D),1,'descend'); 
Q=Q (:,I) 
Qs=Q (:,1:r);
Qn=Q(:,r+1:P);
%%==============================Scanning===================================
angles=(-90:0.1:90);
%Compute steering vectors corresponding values in angles
a1=exp(-i*pi*(0:P-1)'*sin([angles(:).']*pi/180));
for k=1:length(angles)
%Compute MUSIC “spectrum?
pseudo_spectrum(k)=(a1(:,k)'*a1(:,k))/(a1(:,k)'*Qn*Qn'*a1(:,k));
end
%%================================Plot=====================================
plot(angles,abs(pseudo_spectrum))
grid on
title('Pseudo Spectrum')
xlabel('Angle in degrees')

