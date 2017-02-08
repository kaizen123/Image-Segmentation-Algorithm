%%%%%������
clc;
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('rice.bmp');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
[a,b]=size(I);%��ȡͼ��Ĵ�С
%%%%%%����ԭʼͼ��
I4=zeros(a,b);
I4=I;
I4=double(I4);%ת��ͼ�����ݸ�ʽ
%%%%%��֤�����Ժ��˲�Ч��ģ��
%I=imnoise(I,'gaussian',0,0.01);%�����ֵΪ0����Ϊ0.01�ĸ�˹������
%I=wiener2(I,[7 7]);%ά���˲�
%%%%%
tmin=min(I(:));%��ȡͼ��Ҷ���Сֵ
tmax=max(I(:));%��ȡͼ��Ҷ����ֵ
th=(tmin+tmax)/2;%��ʼ�ָ���ֵ�趨Ϊͼ��Ҷ�ƽ��ֵ
th1=0;%�趨�ٽ���ֵ
ok=true;%ѭ����ֹ����
while ok
    g1=I>=th;
    g2=I<th;
    u1=mean(I(g1));
    u2=mean(I(g2));
    thnew=(u1+u2)/2;
    ok=abs(th-thnew)==th1;
    th=thnew;
end%������ȡ������ֵ
th=floor(th);%��������ֵ����ȡ������
J=im2bw(I,th/255);%ͼ���ֵ��
figure(1);
imshow(I);title('ԭʼͼ��');%���ԭʼͼ��
figure(2);
str=['�����ָ�:��ֵTH=',num2str(th)];
imshow(J);title(str);%����ָ���
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
    if J(i,j)==1
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
    if J(i,j)==1
        c1=c1+(I4(i,j)-f1)^2;
    else
        c2=c2+(I4(i,j)-f2)^2;
    end
end
end
d1=c1/b1;
d2=c2/b2;
S=1-((d1+d2)/1000000);%����һ����