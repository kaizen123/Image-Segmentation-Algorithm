%%%%%��׼�Ŵ��㷨
clc;
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('%sidescan.JPG');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
I=im2double(I);%ת�����ݸ�ʽ

%%%%�ֲ�ֱ��ͼ���⻯��LAHE�㷨
I=imresize(I,[216 216]);
[I,noise]=wiener2(I,[3 3]);  
[u,v]=size(I);
m=73;
n=73;
I= padarray(I, [m n], 'symmetric');
I1=zeros(m,n);
X=zeros(u,v);
for i = m+1:1:m + u
for j = n+1:1:n + v
    I1=I((i-(m-1)/2):(i+(m-1)/2),(j-(m-1)/2):(j+(m-1)/2));
    I1=histeq(I1);
    I(i,j)=I1((m+1)/2,(m+1)/2);
    I1=zeros(m,n);
end
end
X=round(255*I(m+1:m+u, n+1:n+v));
%%%%
%%%%����ͼ��
I4=zeros(u,v);
I4=X;
%%%%
figure(1);
imshow(X/255);%���ͼ��
[m,n]=size(X);%��ȡͼ��ߴ�
X1=zeros(m,n);%�����������
X1=around_mean(X);%�������ֵͼ��around_mean�����Լ�д��
NIND=30;%������Ŀ
MAXGEN=30;%����Ŵ�����
PRECI=16;%�����Ķ�����λ��
GGAP=1;%����0.9

%��������������
FieldD=[16;1;(2^16);1;0;1;1];
%FieldD�����Ľṹ��
%FieldD=[len  lb  ub  code  scale  lbin  ubin]
%len:������Chrom���е�ÿ���Ӵ��ĳ��ȣ�PRECI��
%lb ,ub:�ֱ�ָÿ���������½���Ͻ�
%code:�����Ӵ�����ô������ġ�code=1,Ϊ��׼�Ķ����Ʊ��룻code=2��Ϊ���ױ��롣
%scale:ÿ���Ӵ��Ƿ��õĶ����̶Ȼ��������̶�.scale=0��Ϊ�����̶ȣ�scale=1��Ϊ�����̶ȡ�
%lbin  ubin���Ƿ���������ı߽磬Ϊ0��ȥ���߽�;Ϊ1������߽硣

Chrom=crtbp(NIND,PRECI);%������ʼ��Ⱥ
gen=0;
Gen=zeros(30,1);
phen=bs2rv(Chrom,FieldD);%��ʼ��Ⱥʮ����ת��
Objv=target1(X,X1,phen);%������Ⱥ��Ӧ��ֵ
while gen<MAXGEN %����Ŵ���
    Gen(gen+1,1)=max(Objv);
    FitnV=ranking(-Objv);%������Ӧ��ֵ
    SelCh=select('sus',Chrom,FitnV,GGAP);%ѡ�������˴����������ĺ������matlab�Ŵ��㷨������.pdf�� 63��rws
    SelCh=recombin('xovsp',SelCh,0.6);%����xovsp
    SelCh=mut(SelCh,0.01);%����
    phenSel=bs2rv(SelCh,FieldD);%�Ӵ�ʮ����ת��
    ObjVSel=target1(X,X1,phenSel);%�����Ӵ���Ӧ��ֵ
    [Chrom,Objv]=reins(Chrom,SelCh,1,1,Objv,ObjVSel);%�ز���
    gen=gen+1;%������1
end
figure(2);
plot(Gen);%����������Ӧ�Ⱥ���ֵ�仯����
grid on;
xlabel('����/��');
ylabel('��Ӧ�Ⱥ���');
title('������Ӧ�Ⱥ���ֵ�仯����');
axis([0 30 2000 3000])
[Y,I]=max(Objv);%�ҵ������Ӧ�Ⱥ���ֵ
M=bs2rv(Chrom(I,:),FieldD);%��ȡ������ֵ��
%
b=zeros(16,1);
t=16;
while M~0
        b(t)=mod(M,2);
        M=(M-b(t))/2;
        t=t-1;
end
M1=0;
M2=0;
    for t=1:1:8
        M1=M1+b(t)*2^(8-t);%M1�Ǹ����ص��ֵ,�˲�Ϊ����ת��
    end
    for t=9:1:16
        M2=M2+b(t)*2^(16-t);%M2�Ǹ����ص������ֵ,�˲�Ϊ����ת��
    end
for i=1:1:m
for j=1:1:n
    if X(i,j)>M1 && X1(i,j)>M2
        X(i,j)=255;
    else
        X(i,j)=0;
    end
end
end%ͼ���ֵ��
t=['��ά�����䷽���ֵ�ָ��ֵ','M1=',num2str(M1),',','M2=',num2str(M2)];
figure(3);
imshow(X/255);title(t);%����ָ�Ч��
toc;%��ʱ����
%%%%%%%���۲���
f1=0;
f2=0;%���������ƽ��ֵ
a1=0;
a2=0;%��������ĻҶ��ܺ�
b1=0;
b2=0;%�����������Ŀ
c1=0;
c2=0;%���������ƽ�����
d1=0;
d2=0;%��������ķ���
for i=1:1:u
for j=1:1:v
    if X(i,j)==255
        b1=b1+1;
        a1=a1+I4(i,j);
    else
        b2=b2+1;
        a2=a2+I4(i,j);
    end
end
end
f1=a1/b1;
f2=a2/b2;
D=abs(f1-f2)/(f1+f2);%�Աȶ�
for i=1:1:u
for j=1:1:v
    if X(i,j)==255
        c1=c1+(I4(i,j)-f1)^2;
    else
        c2=c2+(I4(i,j)-f2)^2;
    end
end
end
d1=c1/b1;
d2=c2/b2;
S=1-((d1+d2)/1000000);%����һ����