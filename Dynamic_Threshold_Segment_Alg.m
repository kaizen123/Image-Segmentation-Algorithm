%%%%%��̬��ֵ�ָ�
clc;
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('shuisheng.bmp');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
I=im2double(I);%ͼ����������ת��
I=imresize(I,[216 216]);%�ı�ͼ��ߴ���ڷָ�ͼ��
[I,noise]=wiener2(I,[3 3]);%ά���˲�
%%%%%%%�ֲ�ֱ��ͼ���⻯
[a,b]=size(I);
m=121;
n=121;
I = padarray(I, [m n], 'symmetric');%%%��ͼ���Ե���������ͼ��������Ե�޷����������
I1=zeros(m,n);
I2=zeros(a,b);
for i = m+1:1:m + a
for j = n+1:1:n + b
    I1=I((i-(m-1)/2):(i+(m-1)/2),(j-(m-1)/2):(j+(m-1)/2));
    I1=histeq(I1);
    I(i,j)=I1((m+1)/2,(m+1)/2);
    I1=zeros(m,n);
end
end
I2=I(m+1:m+a, n+1:n+b);
figure;
imshow(I2);%�����LAHE������ͼ��
%%%%%%%%%
th=graythresh(I2);%��OTSU����ȫ����ֵ���ָ�ͼ��
J=im2bw(I2,th);
figure;
imshow(J);%ȫ����ֵ�ָ�Ч��
Oimage=zeros(216,216);%�õ���ͼ��ߴ���ͬ�ľ���
Oimage1=zeros(216,216);%�õ���ͼ��ߴ���ͬ�ľ���
TH=zeros(12,12);%�ӿ���ֵ����X
TH1=zeros(216,216);%��ֵ����ֵ����Y
for i=1:1:216
    for j=1:1:216
    Oimage(i,j)=I2(i,j);
    Oimage1(i,j)=I2(i,j);
    end
end%����ͼ��
TH_Oimage=graythresh(Oimage);%�õ�ȫ����ֵ
TH_Oimage1=zeros(216,216);%�õ���ͼ��ߴ���ͬ�ľ���
for i=1:1:216
    for j=1:1:216
    TH_Oimage1(i,j)=TH_Oimage;
    end
end%�õ���ͼ��ߴ���ͬ��ȫ����ֵ����
for i=1:1:12
for j=1:1:12
    J=Oimage((i-1)*216/12+1:i*216/12,(j-1)*216/12+1:j*216/12);
    TH(i,j)=graythresh(J);%��OSTU�㷨�õ�ÿ��С�������ֵ������12*12�ľ���
end
end
%���ڽ�TH����ͨ����ֵ�õ�һ��216*216���µ���ֵ����Y����˫���Բ�ֵ��
TH1=imresize(TH,18,'bilinear');%�õ��µ���ֵ����Y��
%%%%���µõ��ľ������ƽ������������״ЧӦ
A=fspecial('average',[3 3]); %���ɵ�3X3��ֵ�˲���  
TH1=filter2(A,TH1);           %�����ɵ��˲��������˲�
%%%%
M=zeros(216,216);%���ȫ����ֵ�Ķ�̬��ֵ����Y*
%
for i=1:1:95
    for j=1:1:90
    M(i,j)=0.5*TH_Oimage1(i,j)+(1-0.5)*TH1(i,j);%K��Ϊ0.5,ȫ����ֵ�;ֲ���ֵͨ����ȨK���ʹ�á����Ͻǡ�
    end
end
%
for i=96:1:216
    for j=1:1:108
    M(i,j)=0.6*TH_Oimage1(i,j)+(1-0.6)*TH1(i,j);%K��Ϊ0.6,ȫ����ֵ�;ֲ���ֵͨ����ȨK���ʹ�á����½�
    end
end
%
for i=1:1:95
    for j=91:1:216
    M(i,j)=0.8*TH_Oimage1(i,j)+(1-0.2)*TH1(i,j);%K��Ϊ0.8,ȫ����ֵ�;ֲ���ֵͨ����ȨK���ʹ�á����Ͻ�
    end
end
%
for i=96:1:216
    for j=109:1:216
    M(i,j)=0.8*TH_Oimage1(i,j)+(1-0.8)*TH1(i,j);%K��Ϊ0.8,ȫ����ֵ�;ֲ���ֵͨ����ȨK���ʹ�á����½�
    end
end
%
for i=1:1:216
for j=1:1:216
    if(Oimage1(i,j)<=M(i,j))%��ԭͼ�������ص����µ���ֵ������зָ
        Oimage1(i,j)=0;
    else
        Oimage1(i,j)=1;
    end
end
end%ͼ���ֵ��
figure;
imshow(Oimage1);%����ָ�Ч��
toc;%��ʱ����