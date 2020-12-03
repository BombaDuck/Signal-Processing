clear all;
simplesize= 32;
h = [3 2 1];
g = 0; 
%%=======================generate the signals==============================
s = 2*randi([0,1],1,simplesize)-1;
for i = 12:simplesize
    X(i) = h(1)*s(i) + h(2)*s(i-1) + h(3)*s(i-2);
end
%%===========================generate A====================================
for i = 12:simplesize
    A(i-11,:) = [X(i),X(i-1),X(i-2),X(i-3),X(i-4),X(i-5),X(i-6),X(i-7),X(i-8),X(i-9)];
end
%%=============================out put w=================================== 
[Q,R] = qr(A,0);
W= inv(R) * (Q') * s(12:simplesize)';
y = zeros(simplesize,1);
y(12:simplesize) = (A * W)';
W0 = W(1);W1 = W(2);W2 = W(3);
W3 = W(4);W4 = W(5);W5 = W(6);
W6 = W(7);W7 = W(8);W8 = W(9);
W9 = W(10);

%%=================================�M����==================================
for j = 1:simplesize
    if y(j) > 0 
        y(j) = 1;
    else
        y(j) = -1;
    end
end
%%===============================error rate================================
for k = 12:simplesize
        if y(k) == s(k)
            g = g+1;
        end
end
eror_rate = (21-g)/(32);

%%=======================generate u(34) & u(34)============================
s33 = 2*randi([0,1],1,1)-1;
s34 = 2*randi([0,1],1,1)-1;
u33 =[s33,s(32),s(31),s(30),s(29),s(29),s(27),s(26),s(25),s(24)];
u34 =[s34,s33,s(32),s(31),s(30),s(29),s(29),s(27),s(26),s(25)];

y33 = u33*W;
y34 = u34*W;

if y33 > 0
    y33 = 1;
else
    y33 = -1;
end

if y34 > 0
    y34 = 1;
else
    y34 = -1;
end



