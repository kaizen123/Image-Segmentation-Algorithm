%%%%%һά����ط�
clc;
clear all;
close all;
tic;%��ʱ��ʼ
I=imread('rice.bmp');%����ͼ��
I=rgb2gray(I);%ת��Ϊͼ��
%I=round(imnoise(I,'gaussian',0,0.01));%��������
I=double(I);%ͼ�����ݸ�ʽת��
%I=round(medfilt2(I,[7 7]));%��ֵ�˲�
%I=round(filter2(fspecial('average',[7 7]),I));%��ֵ�˲�
%I=round(wiener2(I,[9 9]));%ά���˲��������˲�Ч���ȽϺ�ѡ������˲���
[a,b]=size(I);%��ȡͼ��ߴ�
%%%%%%����ԭʼͼ��
I4=zeros(a,b);
I4=I;
%%%%%
Gray=zeros(256,1);%�Ҷ�ֱ��ͼ����
for i=1:1:a
for j=1:1:b
    Gray(I(i,j)+1,1)=Gray(I(i,j)+1,1)+1;
end
end%ͳ��ͼ��Ҷȷֲ�
%figure;
%bar(Gray,0.2);%���ƻҶ�ֱ��ͼ
count=sum(Gray);
gray=Gray/count;%ת��Ϊ���Ҷȸ���
max=max(max(I));%��ͼ�����Ҷ�ֵ
min=min(min(I));%��ͼ����С�Ҷ�ֵ
Hbest=zeros(max+1,1);%Ŀ�꺯������
for th=min:1:max
    H=0;
    H_all=0;
    HO=0;
    HB=0;
    P=sum(gray((min+1):(th+1),1));
    if P~=0&&P~=1
        for s=(min+1):1:(th+1)
            if gray(s,1)~=0
               H=-gray(s,1)*log(gray(s,1))+H;  
            end
               HO=log(P)+H/P;
        end
        for s=(min+1):1:(max+1)
            if gray(s,1)~=0
                H_all=-gray(s,1)*log(gray(s,1))+H_all;
            end
            HB=log(1-P)+(H_all-H)/(1-P);
        end
           Hbest(th+1,1)=HB+HO;%Ŀ�꺯��     
    end
    P=0;    
end
Hmax=0;
THbest=0;
for s=1:1:(max+1)
    if Hbest(s,1)>=Hmax
        Hmax=Hbest(s,1);
        THbest=s-1;
    end
end%��������ֵ
 for i=1:1:a
 for j=1:1:b
    if I(i,j)<=THbest
  I(i,j)=0;
    else
  I(i,j)=255;
    end
end
 end%ͼ���ֵ��
t=['һά����ط���ֵ�ָ��ֵ=' num2str(THbest)];
imshow(I);title(t);%����ָ���
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