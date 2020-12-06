 [y,fs]=audioread('D:\xu li tin hieu so\bai tap nhom\TinHieuMau-20201102T133235Z-001\TinHieuMau\studio_female.wav');
 %[y,fs]=audioread('D:\xu li tin hieu so\bai tap nhom\TinHieuMau-20201102T133235Z-001\TinHieuMau\studio_male.wav');
 %[y,fs]=audioread('D:\xu li tin hieu so\bai tap nhom\TinHieuMau-20201102T133235Z-001\TinHieuMau\lab_female.wav');
 %[y,fs]=audioread('D:\xu li tin hieu so\bai tap nhom\TinHieuMau-20201102T133235Z-001\TinHieuMau\lab_male.wav');
%sound(y,fs); 

nguongchung = 0.001; %# Nguong nang luong, > tieng noi, < khoang lang.

%%%%%%%%%%%%%%%%%%

%chia khung tin hieu theo thoi gian

ThoiLuongKhung= 0.02; %s=20ms;
DoDaiKhung=ThoiLuongKhung * fs; %so mau trong 1 khung
SoLuongKhung= floor(length(y)/DoDaiKhung); %so luong khung trong tin hieu y
Khung=zeros(SoLuongKhung,DoDaiKhung); %tao ma tran cac khung co SoLuongKhung cot va DoDaiKhung hang
for k=1:SoLuongKhung
    Khung(k,:)=y(DoDaiKhung*(k-1)+1 :DoDaiKhung*k);%chia tung khung cua tin hieu y vao tung khung
end

%%%%%%%%%%%%%%%%%

%tinh nang luong cua tung khung
ste = STEFunc(Khung);
%ghep cac nang luong tung khung thanh tin hieu song
ste_wave = 0; %tin hieu nang luong song
for j = 1 : length(ste) 
    l = length(ste_wave);
    ste_wave(l : l + DoDaiKhung) = ste(j);
end  
t = linspace(0,length(y)/fs,length(y)); %tao vecto t gom length(y) diem cach deu nhau tu 0 den length(y)/fs
t1 = linspace(0,length(ste_wave)/fs,length(ste_wave));%tao vecto t1
subplot(3,1,1);
plot(t,y);  %ve tin hieu vao
title('tin hieu vao');
subplot(3,1,2);
plot(t1,ste_wave); %ve nang luong cua tin hieu
title('Nang luong tin hieu ');
a = [];
%# Danh dau cac diem > nguong = 1, <nguong = 0
for diem = 1 : length(ste)
    if (ste(diem) > nguongchung)
        a = [a 1];
    else 
        a = [a 0];
        
    end
end
%# Kiem tra dieu kien : khong ton tai khoang lang nho hon 200ms 
for i = 1 : length(a)-10 % 200ms = 10 khung tin hieu
    if (a(i) == 1 && a(i+10)==1)   
        a(i : i+10) = 1;
    end
end
%# Bien cac a hop le theo don vi thoi gian
a2 = [];
for i = 1 : length(a)-1 
    if (a(i) + a(i+1)== 1)
        a2 = [a2 i*ThoiLuongKhung];
    end
end
%# Ke cac duong phan chia tin hieu

subplot(3,1,3);
plot(t,y); hold on;
plot([a2;a2], [-1 1], 'm--'); 
title('phan biet tieng noi, khoang lang');



