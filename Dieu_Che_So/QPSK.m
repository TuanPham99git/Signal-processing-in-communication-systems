function QPSK(in)
% Ve tin hieu QPSK voi chuoi bit cho truoc

% n = 1 ; loai A
% n = 2; loai B

%% Khoi tao
lengthsignal = 4*size(in,2);
input = hexToBinaryVector(in,lengthsignal);
N = 2; % so bit dieu che

t2 = 0:0.01:2*pi; % 1 bit
t = 0:0.01:2*N*pi;  % 1 ki hieu ( N bit)
t = t/N;
lengthbit = size(t,2);
lengthbit2 = size(t2,2);

bit0_0 = zeros(1,lengthbit2);
bit00_1 = sin(t + pi/2);
bit00_2 = sin(t + 3*pi/4);
bit1_0 = ones(1,lengthbit2);
bit01_1 = sin(t + pi);
bit01_2 = sin(t - 3*pi/4);
bit11_1 = sin(t - pi/2);
bit11_2 = sin(t - pi/4);
bit10_1 = sin(t);
bit10_2 = sin(t + pi/4);
%plot(bit00_1);
%% thay the
graphic_a = zeros(1,lengthsignal*lengthbit2);
graphic_b = graphic_a;
graphic_c = zeros(1,lengthsignal*lengthbit2);
for i = 0:2:lengthsignal-2
    if [input(1,i+1) input(1,i+2)] == [0 0]
        i = i/2;
        graphic_a(1,(i)*lengthbit+1:(i+1)*lengthbit) = bit00_1;
        graphic_b(1,(i)*lengthbit+1:(i+1)*lengthbit) = bit00_2;
        
    elseif [input(1,i+1) input(1,i+2)] == [0 1]
        i = i/2;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit01_1;
        graphic_b(1,i*lengthbit+1:(i+1)*lengthbit) = bit01_2;
    elseif [input(1,i+1) input(1,i+2)] == [1 1]
        i = i/2;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit11_1;
        graphic_b(1,i*lengthbit+1:(i+1)*lengthbit) = bit11_2;
    else
        i = i/2;
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit10_1;
        graphic_b(1,i*lengthbit+1:(i+1)*lengthbit) = bit10_2;
        
    end
end
for i = 0:lengthsignal-1
    if input(1,i+1) == 1
        graphic_c(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit1_0;
        
    else
        graphic_c(1,i*lengthbit2+1:(i+1)*lengthbit2) = bit0_0;
    end
end
subplot(3,1,1);
plot(graphic_c,'b');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_a,2)]);
ax.XTick = [0:lengthbit2:size(graphic_a,2)];ax.XTickLabel = {'|','','',''};
title('Tin Hieu Vao');

subplot(3,1,2);
plot(graphic_a,'r');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_a,2)]);
ax.XTick = [0:lengthbit2:size(graphic_a,2)];ax.XTickLabel = {'|','','',''};
title('4-PSK Gray');
subplot(3,1,3);
plot(graphic_b,'r');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_b,2)]);
ax.XTick = [0:lengthbit2:size(graphic_b,2)];ax.XTickLabel = {'|','','',''};
title('QPSK - Gray');
end