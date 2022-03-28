function PSK16(in)
% Ve tin hieu 16-PSK voi chuoi bit cho truoc


%% Khoi tao
lengthsignal = 4*size(in,2);
input = hexToBinaryVector(in,lengthsignal);


%% khoi tao ki hieu

N = 4; % so bit dieu che

t2 = 0:0.01:2*pi;   % 1 bit
t = 0:0.01:2*N*pi;  % 1 ki hieu ( N bit)
t = t/N;
lengthbit = size(t,2);
lengthbit2 = size(t2,2);

bit0_0 = zeros(1,lengthbit2);
bit1_0 = ones(1,lengthbit2);

% tao s1 s2 cua signal
gap = 2*pi/2^N;
signal = zeros(2^N,2);
ar = 1;
ct = 1;
for i = pi/2:gap:2*pi+pi/2-0.00001
ps = i;
signal(ct,1) = round(ar*sin(ps),4);
signal(ct,2) = round(ar*cos(ps),4);
ct = ct+1;
end
% tao bang chuyen doi bin to gray code
gray_arr = gray(N)+1;
    

% chuyen doi ki hieu bit sang tin hieu sin
           
bit = zeros(N^2,lengthbit);
for i = 1:N^2
    bit(gray_arr(1,i),:) = convertBitToSineWave(signal(i,:),t);
end

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

for i = 0:4:lengthsignal-4
    ix = binaryVectorToDecimal(input(1,i+1:i+4))+1;
    i = i/4;
    graphic_a(1,(i)*lengthbit+1:(i+1)*lengthbit) = bit(ix,:);
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
title('16-PSK Gray');

end