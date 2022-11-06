clear all
warning off
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lab E1: DDS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generación de ficheros de test
file_test_gen = 1; %1-> sí; 0->no
file_dir = './';
%% Configuración DDS
% Accumulator length
M = 27 % bits

% Accumulator truncated phase (L <= M)
L = 15 % bits

% Sine LUT word-lemgth
W = 14 % bits

% DDS clock frequency : Sampling frequency (kHz)
fclk = 100; % MHz

% DDS generated frequency (kHz)
fo = 1; % MHz

% Accumulator step Pe
Pe = ((fo*(2^M))/fclk)/(2^M);            

% Number of period to display 
n_periods_to_display = 5;



%% Simulation time
sim_time = n_periods_to_display/fo;

if L>M
    display ('ERROR: L debe ser menor o igual a M')
end
sim('DDS_test.mdl')

figure(101)
t = (0:length(sin_wave)-1)/fclk;
subplot(3,1,1)
plot(t,sin_wave)
legend('sin\_wave')
ylabel('Amplitud')
xlabel('t')
subplot(3,1,2)
plot(t,ramp_wave)
legend('ramp\_wave')
ylabel('Amplitud')
xlabel('t')
subplot(3,1,3)
plot(sqr_wave)
legend('sqr\_wave')
ylabel('Amplitud')
xlabel('t')

%% Test files
if file_test_gen == 1
    % Configuration file
    f=sprintf([file_dir 'config_Pe_DDS.txt']);
    pack_f=fopen(f,'w');
    fprintf(pack_f,[num2str(Pe*2^M) '\n']);
    fclose(pack_f);
    
    % output files
    q_out = quantizer([W W-1],'saturate','floor');
    f=sprintf([file_dir 'out_waves.txt']);
    pack_f=fopen(f,'w');
    for i=1:length(sin_wave)
       fprintf(pack_f,[num2bin(q_out,sin_wave(i)) ' ' num2bin(q_out,ramp_wave(i)) ' ' num2bin(q_out,sqr_wave(i))  '\n']);
    end
    fclose(pack_f);
end