%%%%%˫�巨
clc;
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('rice.bmp');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ��
figure(1);
imshow(I);title('ԭʼͼ��');%���ԭʼͼ��
figure(2);
imhist(I);title('ֱ��ͼ');axis([0 255 0 10000]);%���ԭʼͼ��ֱ��ͼ
xlabel('�Ҷ�');
ylabel('Ƶ��/��');
th=130;%ѡȡ��ֵ
J=im2bw(I,th/255);%ͼ���ֵ��
figure(3);
imshow(J);title('˫�巨������');%����ָ���
toc;%��ʱ����