%%%%%��С������ʷ�
clc;
close all;
clear all;
tic;%��ʱ��ʼ
I=imread('rice.bmp');%����ͼ��
I1=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
%%%%%�������ܼ���Լ��˲�Ч�����
%I1=imnoise(I1,'gaussian',0,0.01);%�����ֵΪ0����Ϊ0.01�ĸ�˹������
%I1=wiener2(I1,[7 7]);%ά���˲�
%I1=filter2(fspecial('average',[3 3]),I1);%��ֵ�˲�
%I1=round(I1);%�Ҷ�ֵȡ��
%%%%%
I1=double(I1);
figure(1);
imshow(I1,[0 255]);%���ͼ���˲������룬����ԭͼ��
%%%%%����ͼ��
[a,b]=size(I1);%��ȡͼ��ߴ�
I4=zeros(a,b);
I4=I;%����ͼ��
I4=rgb2gray(I4);%ת��Ϊ�Ҷ�ͼ
I4=double(I4);%���ݸ�ʽת��
%%%%%
I1max=max(max(I1));%��ȡͼ�����Ҷ�ֵ
I1min=min(min(I1));%��ȡͼ����С�Ҷ�ֵ
GTH=zeros(I1max+1,1);%Ŀ�꺯������
for TH=I1min:1:I1max
count_back=0;
count_object=0;
sum_back=0;
sum_object=0;
average_back=0;
average_object=0;
variance_object=0;
variance_back=0;
pow_object=0;
pow_back=0;
for i=1:1:a
for j=1:1:b
if I1(i,j)<=TH
    count_object=count_object+1;
    sum_object=sum_object+I1(i,j);
else
    count_back=count_back+1;
    sum_back=sum_back+I1(i,j);
end
end
end%�󱳾���Ŀ������ص��Լ��Ҷ��ܺ�
if count_object<=1||count_back<=1%��ֹ����Ϊ0
    GTH(TH+1,1)=100;
else
    average_object=sum_object/count_object;
    average_back=sum_back/count_back;
end
if average_object>I1min&&average_back<I1max&&average_object<I1max&&average_object>I1min%��ֹ����Ϊ0
    for i=1:1:a
    for j=1:1:b
    if I1(i,j)<=TH
    pow_object=pow_object+(I1(i,j)-average_object)^2;
    else
    pow_back=pow_back+(I1(i,j)-average_back)^2;
    end
    end
    end%�󷽲�ķ��Ӳ���
    variance_object=pow_object/(count_object-1);
    variance_back=pow_back/(count_back-1);
    GTH(TH+1,1)=1+count_object*log(variance_object)+count_back*log(variance_back)-2*(count_object*log(count_object)+count_back*log(count_back));%Ŀ�꺯��
else
    GTH(TH+1,1)=100;
end

end
Gmin=min(min(GTH));%��ȡ��Сֵ
THbest=max(find(GTH(:,1)==Gmin)-1);%��ȡ���Ŀ�����ֵ
 for i=1:1:a
 for j=1:1:b
    if I1(i,j)<=THbest
  I1(i,j)=0;
    else
  I1(i,j)=1;
    end
end
end
t=['��С����ֵ�ָ��ֵ=' num2str(THbest)];
figure(3);imshow(I1);title(t);%����ָ���
toc;%��ʱ����
%%%%%%%�ָ��������۲���
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
    if I1(i,j)==1
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
    if I1(i,j)==1
        c1=c1+(I4(i,j)-f1)^2;
    else
        c2=c2+(I4(i,j)-f2)^2;
    end
end
end
d1=c1/b1;
d2=c2/b2;
S=1-((d1+d2)/1000000);%����һ����