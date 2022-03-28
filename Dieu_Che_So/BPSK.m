function BPSK(in)
% Ve tin hieu BPSK voi chuoi bit cho truoc

% n = 1 ; loai A
% n = 2; loai B

%% Khoi tao
lengthsignal = 4*size(in,2);
input = hexToBinaryVector(in,lengthsignal);

t = 0:0.01:2*pi;
lengthbit = size(t,2);

bit0_0 = zeros(1,lengthbit);
bit0_1 = cos(t);
bit0_2 = -sin(t);
bit1_0 = ones(1,lengthbit);
bit1_1 = -cos(t);
bit1_2 = sin(t);

%% thay the
graphic_a = zeros(1,lengthsignal*lengthbit);
graphic_b = graphic_a;
graphic_c = graphic_a;
for i = 0:lengthsignal-1
    if input(1,i+1) == 1
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit1_1;
        graphic_b(1,i*lengthbit+1:(i+1)*lengthbit) = bit1_2;
        graphic_c(1,i*lengthbit+1:(i+1)*lengthbit) = bit1_0;
        
    else
        graphic_a(1,i*lengthbit+1:(i+1)*lengthbit) = bit0_1;
        graphic_b(1,i*lengthbit+1:(i+1)*lengthbit) = bit0_2;
        graphic_c(1,i*lengthbit+1:(i+1)*lengthbit) = bit0_0;
    end
end

subplot(3,1,1);
plot(graphic_c,'b');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_a,2)]);
ax.XTick = 0:lengthbit:size(graphic_a,2);
ax.XTickLabel = {'|','','',''};
title('Tin Hieu Vao');

subplot(3,1,2);
plot(graphic_a,'r');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_a,2)]);
ax.XTick = 0:lengthbit:size(graphic_a,2);
ax.XTickLabel = {'|','','',''};
title('BPSK - Loai A');
subplot(3,1,3);
plot(graphic_b,'r');
ylim([-1.2 1.2]);grid on;ax = gca;
xlim([0 size(graphic_b,2)]);
ax.XTick = [0:lengthbit:size(graphic_b,2)];ax.XTickLabel = {'|','','',''};
title('BPSK - Loai B');
end