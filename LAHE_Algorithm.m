%�ֲ�ֱ��ͼ���⻯�����ӿ��ص��㷨��
clc;
clear all;
close all;
tic;%��ʼ��ʱ
I=imread('shuisheng.bmp');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ
I=im2double(I);%ת��ͼ�����ݸ�ʽ
I=imresize(I,[216 216]);%�ı�ͼ���С����ֵ�任ԭ��
[a,b]=size(I);%��ȡͼ��ĳߴ�
m=73;
n=73;%�����ƶ�ģ���С
I = padarray(I, [m n], 'symmetric');%��ͼ���ԵΪ���Ķ�ͼ����жԳƸ��ƣ����ȷ������⸴��n�У���ȷ������⸴��m�У�����LAHE�㷨�޷���ͼ��߽����д����ȱ��
I1=zeros(m,n)%���ɿյ��ƶ�ģ��;
I2=zeros(a,b);%������ԭͼ��ߴ���ͬ�ľ���
for i = m+1:1:m + a
for j = n+1:1:n + b
    I1=I((i-(m-1)/2):(i+(m-1)/2),(j-(m-1)/2):(j+(m-1)/2));
    I1=histeq(I1);
    I(i,j)=I1((m+1)/2,(m+1)/2);
    I1=zeros(m,n);
end
end%�ֲ�ֱ��ͼ���⻯����
I2=I(m+1:m+a, n+1:n+b);%�������ͼ����Ч������ȡ����
figure(1);
imshow(I2);%���LAHE������ͼ��
title('�ֲ�ֱ��ͼ���⻯������ͼ��')
figure(2);
imhist(I2);%���LAHE������ͼ��ֱ��ͼ
xlabel('�Ҷ�');
ylabel('Ƶ��/��');
title('ͼ�����ֱ��ͼ');
toc;%��ʱ����