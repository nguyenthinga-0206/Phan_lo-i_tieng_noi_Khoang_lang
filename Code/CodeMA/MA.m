%Ap dung cong thuc
function [ma] = MA(frames)
    [frameNum, frameWidth] = size(frames);
    ma = 0;
    for i = 1:frameNum
        ma(i) = sum(abs(frames(i,:)));
  %Chuan hoa
    end
    ma = ma/max(ma);
end