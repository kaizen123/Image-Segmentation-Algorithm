%%%%%ȫ��ֱ��ͼ���⻯����
clc;
clear all;
close all;
I=imread('shuisheng.bmp');%����ͼ��
I=rgb2gray(I);%ת��Ϊ�Ҷ�ͼ
I=im2double(I);%ͼ������ת��
figure(1);
imhist(I);%���ͼ����ǰ��ֱ��ͼ
xlabel('�Ҷ�');ylabel('Ƶ��/��');
title('ͼ����ǰֱ��ͼ');
I=histeq(I);%ȫ��ֱ��ͼ���⻯
figure(2);
imshow(I);title('ȫ��ֱ��ͼ���⻯������ͼ��');%���ͼ������ͼ��
