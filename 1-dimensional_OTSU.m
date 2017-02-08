%%%%%һάOTSU��
clc;
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('rice.bmp');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
%%%%%����ͼ��
[a,b]=size(I);%��ȡͼ��ߴ�
I4=zeros(a,b);
I4=I;
I4=double(I4);%���ݸ�ʽת��
%%%%%
%%%%%�������ܼ���Լ��˲�Ч�����
%I=imnoise(I,'gaussian',0,0.01);%�����ֵΪ0����Ϊ0.01�ĸ�˹������
%I=wiener2(I,[7 7]);%ά���˲�
%I=filter2(fspecial('average',[3 3]),I);%��ֵ�˲�
%I=round(I);%�Ҷ�ֵȡ��
%%%%%
I=double(I);%���ݸ�ʽ�任
figure(1);
imshow(I,[0 255]);%���ͼ���˲������룬����ԭͼ��

Imax=round(max(max(I)));%���ͼ�����Ҷ�ֵ
Imin=round(min(min(I)));%���ͼ����С�Ҷ�ֵ
variance=zeros(Imax+1,1);%Ŀ�꺯������
for TH=Imin:1:Imax
count_back=0;
count_object=0;
count_whole=0;
sum_back=0;
sum_object=0;
average_back=0;
average_object=0;
average_whole=0;
for i=1:1:a
for j=1:1:b
if I(i,j)<=TH
    count_object=count_object+1;
    sum_object=sum_object+I(i,j);
else
    count_back=count_back+1;
    sum_back=sum_back+I(i,j);
end
end
end
%�󱳾���Ŀ������ص��Լ��Ҷ��ܺ�
if count_object<=1||count_back<=1%��ֹƽ��ֵΪ0
    variance(TH+1,1)=0;
else
    average_object=sum_object/count_object;
    average_back=sum_back/count_back;
    count_whole=count_object+count_back;
    average_whole=(sum_object+sum_back)/count_whole;
    variance(TH+1,1)=(count_object/count_whole)*(average_object-average_whole)^2+(count_back/count_whole)*(average_back-average_whole)^2;%Ŀ�꺯��ֵ
end
end
variancemax=max(max(variance));%��Ŀ�꺯�����ֵ
THbest=max(find(variance(:,1)==variancemax)-1);%���������ֵ�������ֵ
 for i=1:1:a
 for j=1:1:b
    if I(i,j)<=THbest
  I(i,j)=0;
    else
  I(i,j)=255;
    end
end
 end%ͼ���ֵ��
t=['һά�����䷽���ֵ�ָ��ֵ=' num2str(THbest)];
figure(2);
imshow(I);title(t);%���ͼ��
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