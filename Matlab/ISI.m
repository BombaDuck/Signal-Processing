clear all;
simplesize= 99;
H = [3.2 2.6 -1.8 0.7 -2.2];
%%================================signal===================================
s = 2*randi([0,1],1,simplesize)-1;
%%==============================Generate H=================================
[H_row,H_column] = size(H);
h = zeros(simplesize);
for j = 1:simplesize;
        h(j,j) = H(1);
        h(j,j+1) = H(2);
        h(j,j+2) = H(3);
        h(j,j+3) = H(4);
        h(j,j+4) = H(5);
end
h = h(1:(simplesize - H_column + 1),1:simplesize);   
%%============================ y = h*s ====================================
y(1) = H(1) * s(1);
y(2) = H(1) * s(2) + H(2) * s(1);
y(3) = H(1) * s(3) + H(2) * s(2) + H(3) * s(1);
for i = 4:simplesize;
    y(i) = H(3)*s(i-2) + H(2)*s(i-1) + H(1)*s(i);
end
%%==============================Noise======================================
a = size(y);
r_line1 = a(1);
r_line2 = a(2);
noise_1 = randn(r_line1,r_line2);     
y1  = y + noise_1;     
%=============================== U & W=====================================
[h_row,h_column] = size(h);
z1 = zeros(1,3);
for i = 1:simplesize; 
clear EUW2 k; 
k = 1;
U = h(:,i);
W = h(:,2:simplesize);
if i >=2;
    j=i+1;
    k=i-1;
    W = cat(2,h(:,1:k),h(:,j:simplesize));
end
    
UW = [U' * U,U' * W; W' * U, W' * W];
U0 = cat(2,U,zeros(simplesize-4,simplesize-1)) ;
UWH = [U';W'];
EUW = U0 * UW * UWH;
[EUW_C,EUW_R] = size(EUW);
for j = 1 : (EUW_C*EUW_R)
    if EUW(j) ~= 0;
        EUW2(k) = EUW(j);
        k = k+1;
    else
        continue
    end
end
EUW2 = EUW2';
%%============================== EUW Y ====================================
answer_U_y1 = (EUW2 * y1(i));
%%==============================正交投影===================================
answer_y(i) = inv(EUW2' * EUW2) * EUW2' * answer_U_y1;  
end
%%===============================決策器====================================
for j = 1:simplesize
    if answer_y(j) > 0 ;
        answer_y(j) = 1;
    else;
        answer_y(j) = -1;
    end
end
%%=================================錯誤率==================================
g = 0;
for k = 5:simplesize;
        if answer_y(k) == s(k);
            g = g+1;
        end
end
eror_mate = (simplesize-3-g)/(simplesize-3)