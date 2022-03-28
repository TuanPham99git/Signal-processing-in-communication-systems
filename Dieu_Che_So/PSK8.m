function PSK8(in)
% Ve tin hieu 8-PSK voi chuoi bit cho truoc


%% Khoi tao
lengthsignal = 4*size(in,2);
input = hexToBinaryVector(in,lengthsignal);

%% padding 0 vao cuoi
if mod(lengthsignal,3) == 1
    lengthsignal = lengthsignal + 2;
    input = [input 0 0];
elseif mod(lengthsignal,3) == 2
    lengthsignal = lengthsignal + 1;
    input = [input 0];
end
%% khoi tao ki hieu

N = 3; % so bit dieu che

t2 = 0:0.01:2*pi; % 1 bit
t = 0:0.01:2*N*pi;  % 1 ki hieu ( N bit)
t = t/N;
lengthbit = size(t,2);
lengthbit2 = size(t2,2);

bit0_0 = zeros(1,lengthbit2);
bit1_0 = ones(1,lengthbit2);

s = 1/sqrt(2);

signal = [ 1 0;
           s -s;
           0 -1;
           -s -s;
           -1 0;
           -s s;
           0 1;
           s s];
           

bit000 = convertBitToSineWave(signal(1,:),t);
bit001 = convertBitToSineWave(signal(2,:),t);
bit011 = convertBitToSineWave(signal(3,:),t);
bit010 = convertBitToSineWave(signal(4,:),t);
bit110 = convertBitToSineWave(signal(5,:),t);
bit111 = convertBitToSineWave(signal(6,:),t);
bit101 = convertBitToSineWave(signal(7,:),t);
bit100 = convertBitToSineWave(signal(8,:),t);

%% Thay the
graphic_a = zeros(1,lengthsignal*lengthbit2);
graphic_c = zeros(1,lengthsignal*lengthbit2);
for i = 0:lengthsignal-1
    if input(1,i+1) == 1
        graphic_c(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit1_0;
        
    else
        graphic_c(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit0_0;
    end
end

for i = 0:3:lengthsignal-3
    if input(1,i+1:i+3) == [0 0 0]
        i = i/3;
        graphic_a(1,(i)*lengthbit+1:(i+1)*lengthbit) = bit000;
    elseif input(1,i+1:i+3) == [0 0 1]
        i = i/3;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit001;
    elseif input(1,i+1:i+3) == [0 1 1]
        i = i/3;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit011;
    elseif input(1,i+1:i+3) == [0 1 0]
        i = i/3;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit010;
    elseif input(1,i+1:i+3) == [1 1 0]
        i = i/3;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit110;
    elseif input(1,i+1:i+3) == [1 1 1]
        i = i/3;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit111;
    elseif input(1,i+1:i+3) == [1 0 1]
        i = i/3;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit101;
    else
        i = i/3;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit100;
    end
end


%% Ve
subplot(2,1,1);
plot(graphic_c,'b');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_a,2)]);
ax.XTick = [0:lengthbit2:size(graphic_a,2)];ax.XTickLabel = {'|','','',''};
title('Tin Hieu Vao');

subplot(2,1,2);
plot(graphic_a,'r');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_a,2)]);
ax.XTick = [0:lengthbit2:size(graphic_a,2)];ax.XTickLabel = {'|','','',''};
title('8-PSK Gray');

end