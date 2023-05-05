clc;
clear variable;
close all;

% Define variables
A1 = 15;
A2 = 6;
f = 0.28;
theta1 = 3;
theta2 = 2;
t0 = 0.11;
group_number = 11;

% Time vector
t = 0:1/(f*1e+3):2/f;

% Generate sine waves
s1 = A1*sin(2*pi*f*t);
s2 = A1*sin(2*pi*f*t + theta1);
s3 = A2*sin(2*pi*f*t);
s4 = A1*sin(2*pi*f*(t - t0));

% Plot s3 and s4 on the same graph
figure;
plot(t, s3);
grid on
hold on;
plot(t, s4);
grid on
title('s3 and s4');
xlabel('Time (s)');
ylabel('Amplitude');
legend('s3', 's4');

% Calculate time shift between s1 and s2
[correlation, lag] = xcorr(s1, s2);
[~, I] = max(abs(correlation));
time_shift = lag(I) * (1/(f*1e+3));

% Plot 3s1 and -3s1 on the same graph
figure;
plot(t, 3*s1);
grid on
hold on;
plot(t, -3*s1);
title('3s1 and -3s1');
xlabel('Time (s)');
ylabel('Amplitude');
legend('3s1', '-3s1');

% Calculate phase shift between s3 and s4
[correlation, lag] = xcorr(s3, s4);
[~, I] = max(abs(correlation));
phase_shift_2 = angle(lag(I)*(1/(f*1e+3)) * 2*pi);

% Rewrite s1 + s2 as a single sinusoidal signal
amp = sqrt(A1^2 + A2^2 + 2*A1*A2*cos(theta1 - theta2));
ang = theta1 + atan2(A2*sin(theta2) , (A1 + A2*cos(theta2)));

s5 = amp*sin(2*pi*f*t + ang);
s6=s1+s2;

% Plot s1 + s2 and s5 side-by-side
figure;
subplot(1,2,1);
plot(t, s1 + s2);
grid on
title('s1 + s2');
xlabel('Time (s)');
ylabel('Amplitude');
subplot(1,2,2);
plot(t, s6);
grid on
title('s5');
xlabel('Time (s)');
ylabel('Amplitude');

% Save workspace
filename = sprintf('group_%d_workspace.mat', group_number);
save(filename);