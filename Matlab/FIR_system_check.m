clear all;
simplesize= 13 ;
h = [3 2 1];
%%==============================signal=================================
%%產生已知 H 的訊號 B 
s = 2*randi([0,1],1,simplesize)-1;
for i = 5:simplesize
    B(i) = h(1)*s(i) + h(2)*s(i-1) + h(3)*s(i-2);
end
%%=============================加上雜訊=================================
noise_1 = 0.5*randn(1,1);    
noise_2 = 1.5*randn(1,1);     
for i = 5:simplesize
    B_1(i-4) = B(i) + noise_1;
    B_2(i-4) = B(i) + noise_2;
end
%%=============================產生A====================================
%A為當前加上前兩個時段的訊號(含雜訊)
for i = 5:simplesize
    A(i-4,:) = [s(i),s(i-1),s(i-2)];
end
%%========================= 帶入公式找出H ===============================
h_1 = (inv(A' * A))* (A') * B_1';
h_2 = (inv(A' * A))* (A') * B_2';
%%========================== QR轉換做法 =================================
[Q,R] = qr(A,0);
hqr01 = inv(R)* (Q)' *(B_1)';
hqr02 = inv(R)* (Q)' *(B_2)';
%==============================計算錯誤率================================ 
erroRate1_1 = (hqr01(1) - h(1))^2;
erroRate2_1 = (hqr02(1) - h(1))^2;
%==============================計算錯誤率================================
erroRate1_2 = (hqr01(2) - h(2))^2;
erroRate2_2 = (hqr02(2) - h(2))^2;
%==============================計算錯誤率================================
erroRate1_3 = (hqr01(3) - h(3))^2;
erroRate2_3 = (hqr02(3) - h(3))^2;

% 
% %=============================錯誤率var =1 =================================
% if  erroRate1_1(z) >= 0 & erroRate1_1(z) <= 1;
%     e1_1_avg = (e1_1_avg + erroRate1_1(z))/100;
% end
% if  erroRate1_2(z) >= 0 & erroRate1_2(z) <= 1;
%     e1_2_avg = (e1_2_avg + erroRate1_2(z))/100;
% end
% 
% %==========================錯誤率 var = 1.5 ================================
% if  erroRate2_1(z) >= 0 & erroRate2_1(z) <= 1;    
%     e2_1_avg = (e2_1_avg + erroRate2_1(z))/100;
% end
% if  erroRate2_2(z) >= 0 & erroRate2_2(z) <= 1;
%     e2_2_avg = (e2_2_avg + erroRate2_2(z))/100;
% end
% 
