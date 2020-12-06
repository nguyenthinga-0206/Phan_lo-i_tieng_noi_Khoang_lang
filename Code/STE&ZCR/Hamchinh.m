%[data, Fs] = audioread('lab_male.wav');
[data, Fs] = audioread('lab_female.wav');
%[data, Fs] = audioread('studio_male.wav');
%[data, Fs] = audioread('studio_female.wav');

% Chuan hoa du lieu
data = data / abs(max(data));

ThoiLuongKhung = 0.02; %10-30ms
N = length(data);
DoDaiKhung = ThoiLuongKhung * Fs;

 %% Chia khung
n = floor(N / DoDaiKhung);%Tong so frame
tmp = 0;
for i = 1 : n
    khung(i,:) = data(tmp + 1 : tmp + DoDaiKhung);
    tmp = tmp + DoDaiKhung;
end

%Zero Crossing Rate
[zcr, zcr_mau] = ZCR(khung, N, DoDaiKhung);
%Short-Time Energy(STE)
[ste, ste_mau] = STE(khung, DoDaiKhung);

%% Ve do thi ZCR,STE,data
t = (0 : 1/Fs : length(data) / Fs);
t = t(1:end - 1);
t1 = (0 : 1/Fs : length(zcr_mau) / Fs);
t1 = t1(1:end - 1);
t2 = (0 : 1/Fs : length(ste_mau) / Fs);
t2 = t2(1:end - 1);
subplot(3,1,1);
plot(t, data, 'g'); 
axis([0 n*ThoiLuongKhung -1 1]);
legend({'Tin hieu tieng noi'}, 'Location','southeast');
title('Tin hieu tieng noi');
xlabel('Thoi gian');
ylabel('Bien do');
subplot(3,1,2);
plot(t1, zcr_mau,'b', t2, ste_mau,'r'); 
axis([0 n*ThoiLuongKhung -1 1]);
legend({'Zero Crossing Rate', 'Short time energy'}, 'Location','southeast');
title('Short-time Energy - Zero-crossing Rate');
xlabel('Thoi gian');
ylabel('Bien do');

%% Xac dinh vi tri cho khoang lang va tieng noi
ZCRct = 0.6; Ect = 0.001;%thay doi nguong de co duoc ket qua chinh xac
id_zcr = find(zcr < ZCRct);
id_ste = find(ste > Ect);
id = [];
for i = 1:n
     j = 1;
     while j <= length(id_zcr)
         if(i == id_zcr(j))
             k = 1;
             while k <= length(id_ste)
                 if(i == id_ste(k))
                    id = [id,i];
                 end
                 k=k+1;
             end
         end
         j=j+1;
     end
end

%% Tim bien thoi gian giao nhau giua tieng noi va khoang lang
id_speech=id(1)-1;
m=2;
for i = 2:length(id)
     if((ThoiLuongKhung*id(i)-ThoiLuongKhung*id(i-1)) > 0.2)
         id_speech(m)=id(i-1);%bat dau
         id_speech(m+1)=id(i)-1;%ket thuc
         m=m+2;
     end
end
id_speech(m)=id(i);
local_speech=ThoiLuongKhung*id_speech;
% ve do thi phan doan tieng noi va khoang lang
y = (-1: 1);
subplot(3,1,3);
plot(t, data, 'g');
axis([0 n*ThoiLuongKhung -1 1]);
hold on;
for i = 1:length(local_speech)
     plot(local_speech(i)*ones(size(y)), y,'m --');
end
hold off;
legend('Tin hieu tieng noi','Vi tri bat dau va ket thuc tieng noi','Location','southeast');
title('Phan doan tieng noi va khoang lang');
xlabel('Thoi gian');
ylabel('Bien do');