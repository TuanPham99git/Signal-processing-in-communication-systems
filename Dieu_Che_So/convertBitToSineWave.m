function out = convertBitToSineWave(in,t)
% convert in [ s1 s2 ] to sinwave with cycle time array t;
s1 = in(1,1);
s2 = in(1,2);
arg =abs(s2+1i*s1);
phs =angle(s2+1i*s1);
%phs/pi;
out = arg*sin(t+phs);
%disp('____________________');
end