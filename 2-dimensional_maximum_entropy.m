%%%%%��ά����ط�
clc;
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('sidescan.JPG');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
%I=imnoise(I,'gaussian',0,0.01);%�����ֵΪ0����Ϊ0.01�ĸ�˹������
I=double(I);%ͼ������ת��
[a,b]=size(I);%��ȡͼ��ߴ�
%%%%%%����ԭʼͼ��
I4=zeros(a,b);
I4=I;
%%%%%
%I=round(medfilt2(I,[7 7]));%��ֵ�˲�
%I=round(filter2(fspecial('average',[7 7]),I));%��ֵ�˲��������˲���ѡһ
figure(1);
imshow(I/255);%���ͼ��
I1=round(filter2(fspecial('average',[3 3]),I));%�������ֵͼ��

Imax=max(max(I));%��ȡͼ��Ҷ�ֵ���ֵ
Imin=min(min(I));%��ȡͼ��Ҷ�ֵ��Сֵ
I1max=max(max(I1));%��ȡ����ͼ��Ҷ�ֵ���ֵ
I1min=min(min(I1));%��ȡ����ͼ��Ҷ�ֵ��Сֵ
P=zeros(Imax+1,I1max+1);%ͳ��ͼ��Ҷ�-����Ҷ�����Ƶ������
Z=zeros(Imax+1,I1max+1);%Ŀ�꺯������
X=zeros(Imax+1,I1max+1);%Ŀ�������ܸ��ʾ���
for i=1:1:a
for j=1:1:b
    P(I(i,j)+1,I1(i,j)+1)=P(I(i,j)+1,I1(i,j)+1)+1;
end
end%ͳ��ͼ��Ҷ�-����Ҷ�����Ƶ��
p=P/(a*b);%��Ҷ�-����Ҷȸ���
Hl=0;
for s=(Imin+1):1:(Imax+1)
for t=(I1min+1):1:(I1max+1)
    if p(s,t)~=0;
    Hl=Hl-p(s,t)*log(p(s,t));%������ͼ���ά��ɢ��
    end
end
end
for s=(Imin+1):1:(Imax+1)
for t=(I1min+1):1:(I1max+1)
    Ha=0;
    Pa=sum(sum(p((Imin+1):s,(I1min+1):t)));%Ŀ������ܺ�
    X(s,t)=Pa;%��ͬ��ֵ����Ŀ������ܺ�
if Pa>0&&Pa<1
for u=(Imin+1):1:s
for v=(I1min+1):1:t
    if p(u,v)~=0;
        Ha=Ha-p(u,v)*log(p(u,v));%�Ҷ�-����Ҷ�ͼ����A������
    end
end
end
    Z(s,t)=log(Pa*(1-Pa))+(Ha/Pa)+((Hl-Ha)/(1-Pa));%Ŀ�꺯��
end
end
end
Zmax=(max(max(Z)));%������Ŀ�꺯��
[sbest1,tbest1]=find(Z==Zmax);%�õ�������ֵ��
sbest=sbest1(1)-1;
tbest=tbest1(1)-1;%��������ֵ����ѡȡ��һ����ֵ
 for i=1:1:a
 for j=1:1:b
    if I(i,j)<=sbest&&I1(i,j)<=tbest
  I(i,j)=0;
    elseif I(i,j)>sbest&&I1(i,j)>tbest
  I(i,j)=255;
    end
end
 end%ͼ���ֵ��
figure(2);
T=['��ά����ط���ֵ�ָ��ֵ=' num2str(sbest)];
imshow(I);title(T);%����ָ���
toc;%��ʱ����
%%%%%%%�ָ�Ч�����۲���
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
for i=1:1:a
for j=1:1:b
    if I(i,j)==255
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
for i=1:1:a
for j=1:1:b
    if I(i,j)==255
        c1=c1+(I4(i,j)-f1)^2;
    else
        c2=c2+(I4(i,j)-f2)^2;
    end
end
end
d1=c1/b1;
d2=c2/b2;
S=1-((d1+d2)/1000000);%����һ����