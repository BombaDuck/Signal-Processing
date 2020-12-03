clear all;
simplesize= 3000;
H = [0.5 0.4;-0.3 0.1;1.7 0.9;2 -1];
%%-----------------------------signal--------------------------------------
s1 = 2*randi([0,1],1,simplesize)-1;s2 = 2*randi([0,1],1,simplesize)-1;
S  = [s1;s2];
%%--------------------------------H*s--------------------------------------
HS = H*S; 
%%-------------------------------雜訊--------------------------------------
a = size(HS);
r_line1 = a(1);
r_line2 = a(2);
noise_1 = randn(r_line1,r_line2);   
noise_2 = 2*randn(r_line1,r_line2);   
noise_3 = 5*randn(r_line1,r_line2);   
noise_4 = 10*randn(r_line1,r_line2);  
%%----------------------------訊號加上雜訊----------------------------------
y1  = HS + noise_1;     
y2  = HS + noise_2;     
y3  = HS + noise_3;     
y4  = HS + noise_4;     
%%------------------------------- G ---------------------------------------
G     = H * inv(H'*H);   %找出G
G_NULL   = null(G');
G_2_1    = G(1:4)' + G_NULL;
G_2_2    = G(5:8)' + G_NULL;
G2       = [G_2_1 G_2_2 ];
g_1 = G'* H;             %確認G與H的關係是否相乘為單位矩陣
g_2 = G2'* H;            %確認G2與H的關係是否相乘為單位矩陣
%%-------------------------------G*Y --------------------------------------
answer_y1 = G'*y1;
answer_y2 = G'*y2;
answer_y3 = G'*y3;
answer_y4 = G'*y4;
%%------------------------------等化器-------------------------------------
for i=1:simplesize;
    if answer_y1(i) > 0
        answer_y1(i) = 1;
    else
        answer_y1(i) = -1;
    end
    if answer_y2(i) > 0
        answer_y2(i) = 1;
    else
        answer_y2(i) = -1;
    end  
    if answer_y3(i) > 0
        answer_y3(i) = 1;
    else
        answer_y3(i) = -1;
    end     
    if answer_y4(i) > 0
        answer_y4(i) = 1;
    else
        answer_y4(i) = -1;
    end
end

%----------------------------------(v)-------------------------------------
counter_q1 = 0;
counter_q2 = 0;
counter_q3 = 0;
counter_q4 = 0;
for k = 1:simplesize;
    if answer_y1(k) == S(k)
        counter_q1 = counter_q1 + 1;
    end
    
    if answer_y2(k) == S(k)
        counter_q2 = counter_q2 + 1;
    end
    
    if answer_y3(k) == S(k)
        counter_q3 = counter_q3 + 1;
    end
    
    if answer_y4(k) == S(k)
        counter_q4 = counter_q4 + 1;
    end    
    
end
%---------------------------------錯誤率-----------------------------------
error_rate_S1 = (simplesize-counter_q1)/simplesize    
error_rate_S2 = (simplesize-counter_q2)/simplesize
error_rate_S3 = (simplesize-counter_q3)/simplesize
error_rate_S4 = (simplesize-counter_q4)/simplesize
    
