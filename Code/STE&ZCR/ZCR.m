function [zcr, zcr_mau] = ZCR(khung, N, DoDaiKhung)
    [r, c] = size(khung);
    for i = 1 : r
        x = khung(i, :);
        %dem so lan bang qua 0
        zc(i) = 0;
         for k = 1:length(x) - 1
             if (x(k) * x(k + 1) < 0)
                zc(i) = zc(i) + 1;
             end
         end
    end
    
    zcr = zc / N; %tox do bang qua 0 ZCR
    zcr = zcr/max(zcr); %chuan hoa
    zcr_mau = 0;
    for j = 1 : length(zcr)
        l = length(zcr_mau);
        zcr_mau(l : l + DoDaiKhung) = zcr(j);
end