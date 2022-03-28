clear
N = 5*10^7; % number of symbols
Es_N0_dB = [ -3:14]; % multiple Eb/N0 values 
ipHat = zeros(1,N);
for ii = 1:length(Es_N0_dB)
ip = (2*(randint(1,N)>0.5) -1) + 1i*(2*(randint(1,N)>0.5) -1); %
s = (1/sqrt(2))*ip; % normalization of energy to 1
n = (1/sqrt(2))*(randi(1,N) + 1i*N); % white guassian noise, 0dB variance
y = s + 10^( -Es_N0_dB(ii)/20)*n; % additive white gaussian noise
% demodulation
y_re = real(y); % real
y_im = imag(y); % imaginary
ipHat(find(y_re < 0 & im <=0)) = -1 + -1*j; 
ipHat(find(y_re >= 0 & im > 0)) = 1 + 1*j;
ipHat(find(y_re < 0 & im >= 0)) = -1 + 1*j;
ipHat(find(y_re >= 0 & im < 0)) = 1 - 1*j;
nErr(ii) = size(find([ip - ipHat]),2); % couting the number of errors
end
simSer_QPSK = nErr/N;
theorySer_QPSK = erfc(sqrt(0.5*(10.^(Es_N0_dB/10)))) - (1/4)*(erfc(sqrt(0.5*(10.^(Es_N0_dB/10)) ))).^2;
close all 
figure
semilogy(Es_N0_dB,theorySer_QPSK, 'b. -');
hold on
semilogy(Es_N0_dB,simSer_QPSK, 'mx -'); 
axis([ -3 15 10^ -5 1])
grid on
legend( 'theory -QPSK' , 'simulation -QPSK' );
