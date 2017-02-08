function f = target1( T,T1,M )%��Ӧ�Ⱥ�����TΪ������ͼ��T1Ϊ������ͼ�������ֵ��MΪ��ֵ����
Tmean=mean(mean(T));%ͼ��ҶȾ�ֵ
T1mean=mean(mean(T1));%����ͼ��ҶȾ�ֵ
[U,V]=size(T);
W=length(M);
f=zeros(W,1);
M1=zeros(W,1);%M1(k)�Ǹ����ص��ֵ
M2=zeros(W,1);%M2(k)�Ǹ����ص������ֵ
a=zeros(16,1);
for k=1:1:W
    t=16;
    while M(k)~0
        a(t)=mod(M(k),2);
        M(k)=(M(k)-a(t))/2;
        t=t-1;
    end
    for t=1:1:8
        M1(k)=M1(k)+a(t)*2^(8-t);%M1(k)�Ǹ����ص��ֵ,�˲�Ϊ����ת��
    end
    for t=9:1:16
        M2(k)=M2(k)+a(t)*2^(16-t);%M2(k)�Ǹ����ص������ֵ,�˲�Ϊ����ת��
    end
    %%%%%%%%%�����Ƕ�άOTSU����Ӧ�Ⱥ������㷽��
    Tsum_back=0;
    Tsum_object=0;
    T1sum_back=0;
    T1sum_object=0;
    Taverage_back=0;
    Taverage_object=0;
    T1average_back=0;
    T1average_object=0;
    count_back=0;
    count_object=0;%ͳ��Ŀ��ͼ��ͱ���ͼ����Ե����ظ����Լ�����֮��
    for i=1:1:U
        for j=1:1:V
            if T(i,j)>M1(k) && T1(i,j)>M2(k)
            Tsum_object=Tsum_object+T(i,j);
            T1sum_object=T1sum_object+T1(i,j);
            count_object=count_object+1;
            end
            if T(i,j)<=M1(k) && T1(i,j)<=M2(k)
            Tsum_back=Tsum_back+T(i,j);
            T1sum_back=T1sum_back+T1(i,j);
            count_back=count_back+1;
            end
        end
    end
    if count_object==0||count_back==0
    f(k)=0;
    else    
    Taverage_object=Tsum_object/count_object;
    Taverage_back=Tsum_back/count_back;
    T1average_object=T1sum_object/count_object;
    T1average_back=T1sum_back/count_back;
    f(k)=(count_object/(U*V))*((Taverage_object-Tmean)^2+(T1average_object-T1mean)^2)+(count_back/(U*V))*((Taverage_back-Tmean)^2+(T1average_back-T1mean)^2);%������Ӧ�Ⱥ���ֵ
    end
    
end
end
