%# Ham tinh song Nang luong. Nhan vao la Frames.
%# Doi tuong ra ve la STE cua tung frame da qua chuan hoa
function [ste] = STEFunc(frames)
    [frameNum, frameWidth] = size(frames); %so khung la hang va do dai khung la cot
    ste = 0; %#Short-Time Energy 
    for i = 1 : frameNum %vong lap chay den tung hang cua so khung
        ste(i) = sum(frames(i,:).^2);  %#Ap dung cong thuc!  
    end
    %#Chuan hoa STE
    ste = (ste - min(ste))/(max(ste)-min(ste));
end

