 [y,fs]=audioread('studio_male.wav');
nguongchung = 0.08;
 %# Threshold, > Voice, < Silence

%%%%%%%%%%%%%%%%%%

%Chia khung tin hieu theo thoi gian
ThoiLuongKhung= 0.02; %s=20ms;
DoDaiKhung=ThoiLuongKhung * fs;
SoLuongKhung= floor(length(y)/DoDaiKhung); %So luong khung trong tin hieu y
Khung=zeros(SoLuongKhung,DoDaiKhung); %Tao ma tran cac khung co SoLuongKhung cot va DoDaiKhung hang
for k=1:SoLuongKhung
    Khung(k,:)=y(DoDaiKhung*(k-1)+1 :DoDaiKhung*k);%Chia tung khung
end

%%%%%%%%%%%%%%%%%
%tinh do lon trung binh cua tung khung
ma = MA(Khung);
%ghep cac do lon trung binh tung khung thanh tin hieu song
ma_wave = 0; %tin hieu song
for j = 1 : length(ma) 
    l = length(ma_wave);
    ma_wave(l : l + DoDaiKhung) = ma(j);
end  
t = linspace(0,length(y)/fs,length(y)); %tao vecto t gom length(y) diem cach deu nhau tu 0 den length(y)/fs
t1 = linspace(0,length(ma_wave)/fs,length(ma_wave));%tao vecto t1
subplot(3,1,1);
plot(t,y);  %ve tin hieu vao
title('Signal');
subplot(3,1,2);
plot(t1,ma_wave); %ve nang luong cua tin hieu
title('Magnitude Average');
id = [];
%# Danh dau cac diem > nguong = 1, <nguong = 0
for sam = 1 : length(ma)
    if (ma(sam) > nguongchung)
        id = [id 1];
    else 
        id = [id 0];
        
    end
end
%# Kiem tra dieu kien : khong ton tai khoang lang nho hon 200ms 
for i = 1 : length(id)-10 % 200ms = 10 khung tin hieu
    if (id(i) == 1 && id(i+10)==1)   
        id(i : i+10) = 1;
    end
end
%# Bien cac id hop le theo don vi thoi gian
id2 = [];
for i = 1 : length(id)-1 
    if (id(i) + id(i+1)== 1)
        id2 = [id2 i*ThoiLuongKhung];
    end
end
%# Ke cac duong phan chia tin hieu

subplot(3,1,3);
plot(t,y,'g'); hold on;
plot([id2;id2], [-1 1], '--k'); 
title('Voice/ Silience Discriminate');



