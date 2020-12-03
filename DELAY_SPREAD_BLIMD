clear all;
receiver = 3 ; %三個天線接收端
delay = 2 ; %兩個訊號DELAY SPREAD 
K = 2 ; %X所需變化的矩陣大小
N = 10; %接收到訊號共有10組
r = delay+K
h_0 = [0.2;0.3;0.5]
h_1 = [0.6;0.35;0.9]
h_2 = [1;2;0.6]
%============================receiver======================================
s = 2*(randi([0,1],1,N))-1; %產生一個M*N的矩陣
%===============================x_k=s*h====================================
x_1 = h_0*s(1);
x_2 = h_0*s(2) + h_1*s(1);
x_3 = h_0*s(3) + h_1*s(2) + h_2*s(1);
x_4 = h_0*s(4) + h_1*s(3) + h_2*s(2);
x_5 = h_0*s(5) + h_1*s(4) + h_2*s(3);
x_6 = h_0*s(6) + h_1*s(5) + h_2*s(4);
x_7 = h_0*s(7) + h_1*s(6) + h_2*s(5);
x_8 = h_0*s(8) + h_1*s(7) + h_2*s(6);
x_9 = h_0*s(9) + h_1*s(8) + h_2*s(7);
x_10 = h_0*s(10) + h_1*s(9) + h_2*s(8);
%===========================產生接收端訊號==================================
%由題目所知 K = 2 則x可列出 k*(N-delay-K+1) 其矩陣算出為 2*7的矩陣
X = [x_3 x_4 x_5 x_6 x_7 x_8 x_9;x_4 x_5 x_6 x_7 x_8 x_9 x_10]
X_rank = rank(X)
%===============================v0=========================================
%由於X(K) 與S(delay+K)有相同的ROW SPACE 故將其轉至後取BASIC 找出VS
X_row =orth(X') %VS
%找出X(K)的NULL SPACE
v0 = null(X)       %x_null
v0_basis= orth(v0) %x_null_basis
%============================= bm =========================================
b1 = [v0_basis(1) v0_basis(2) v0_basis(3) v0_basis(4) v0_basis(5) v0_basis(6) v0_basis(7)]
b2 = [v0_basis(8) v0_basis(9) v0_basis(10) v0_basis(11) v0_basis(12) v0_basis(13) v0_basis(14)]
b3 = [v0_basis(15) v0_basis(16) v0_basis(17) v0_basis(18) v0_basis(19) v0_basis(20) v0_basis(21)]
%============================= u ==========================================
u0 = [b1;b2;b3]
zero = [0;0;0]
U = [u0 zero zero zero;zero u0 zero zero;zero zero u0 zero;zero zero zero u0]
%============================== s =========================================
s_burr = null(U)
s_burr1 = null(U)
for i=1:N
    if s_burr(i)/s_burr(1) > 0
        s_burr(i) = 1
    else 
        s_burr(i) = -1
    end
end
%=================================錯誤率===================================
right_mate =0
for i=1:N
   if s(i) == s_burr(i)
       right_mate = right_mate+1
   end
end
error_mate = (N-right_mate)/N
