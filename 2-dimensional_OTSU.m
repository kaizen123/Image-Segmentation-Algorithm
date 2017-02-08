%%%%%��άOTSU��
clc;%�㷨����1.������ֵ��ͼ��ָ��㷨���о�2.����ģ����ֵ��ͼ��ָ���о�_�����3.�����Ŵ��㷨��ˮ��ͼ��ָ���о�_������sidescan.JPG
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('rice.bmp');%����ͼ��
%I=imnoise(I,'gaussian',0,0.01);%��������
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
I=double(I);%��������ת��
%I=round(wiener2(I,[7 7]));%ά���˲����˲�
[a,b]=size(I);%��ȡͼ��ߴ�
%%%%%%����ԭʼͼ��
I4=zeros(a,b);
I4=I;
%%%%%
I1=zeros(a,b);
I1=round(filter2(fspecial('average',[3 3]),I));%���������ֵ����
Imax=max(max(I));%��ȡͼ��Ҷ����ֵ
Imin=min(min(I));%��ȡͼ��Ҷ���Сֵ
Imean=mean(mean(I));%��ȡͼ��Ҷ�ƽ��ֵ
I1max=max(max(I1));%��ȡ����ͼ��Ҷ����ֵ
I1min=min(min(I1));%��ȡ����ͼ��Ҷ���Сֵ
I1mean=mean(mean(I1));%��ȡ����ͼ��Ҷ�ƽ��ֵ
variance=zeros(Imax+1,I1max+1);%Ŀ�꺯������
for s=Imin:1:Imax
for t=I1min:1:I1max
    Isum_back=0;
    Isum_object=0;
    I1sum_back=0;
    I1sum_object=0;
    Iaverage_back=0;
    Iaverage_object=0;
    I1average_back=0;
    I1average_object=0;
    count_back=0;
    count_object=0;
for i=1:1:a
for j=1:1:b
if I(i,j)>s&&I1(i,j)>t
       Isum_object=Isum_object+I(i,j);
       I1sum_object=I1sum_object+I1(i,j);
       count_object=count_object+1;
elseif I(i,j)<=s&&I1(i,j)<=t
       Isum_back=Isum_back+I(i,j);
       I1sum_back=I1sum_back+I1(i,j);
       count_back=count_back+1;
end
end
end%��ͼ������ͼ����Ŀ���뱳���ĸ��Զ�Ӧ�ܻҶ�ֵ��ƽ���Ҷ�ֵ�����ظ���
if count_object==0||count_back==0%��ֹ��ĸΪ0
   variance(s+1,t+1)=0;
else    
    Iaverage_object=Isum_object/count_object;
    Iaverage_back=Isum_back/count_back;
    I1average_object=I1sum_object/count_object;
    I1average_back=I1sum_back/count_back;
    variance(s+1,t+1)=(count_object/(a*b))*((Iaverage_object-Imean)^2+(I1average_object-I1mean)^2)+(count_back/(a*b))*((Iaverage_back-Imean)^2+(I1average_back-I1mean)^2);%��Ŀ�꺯��
end
end
end
variancemax=max(max(variance));%��Ŀ�꺯�����ֵ
[s1,t1]=find(variance==variancemax);%��������ֵ������
s=s1(1)-1;
t=t1(1)-1;%�������ֵ��
 for i=1:1:a
 for j=1:1:b
    if I(i,j)>s&&I1(i,j)>t
  I(i,j)=255;
    else
  I(i,j)=0;
    end
end
 end%ͼ���ֵ������
T=['��ά�����䷽���ֵ�ָ��ֵ','s=',num2str(s),',','t=',num2str(t)];
figure;
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