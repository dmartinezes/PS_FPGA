%%
% Genearción de ficheros para TB_DP_MOD
%% 
graficas_si = 1; % 1 -> si; 0 -> no
ficheros_si = 1; % 1 -> si; 0 -> no
%% MOD AM/FM CONFIGURATION

% Control FM --> 1, AM --> 0
control_fm_am=1;

% Sampling frequency (MHz)
fsc=100; % MHz

% Carrier frequency (MHz)
fc=10.7; % MHz

% AM modulation index (range [0,1[)
m_am=1*(1-2^-15);

% FM modulation index (kHz)
Kfm=5000; % kHz

% Modulating frequency (kHz)
fmod= 150; % kHz

% Number of period to display 
n_periods_to_display = 1;


%% Simulink
% Simulation time
sim_time = n_periods_to_display/fmod*1e3;

sim('mod_fmam_pf');


%% Verilog simulation values
% Frecuencia portadora: U[24,24]
frec_por = round(fc/fsc*2^24);            
% Índice de modulacion de AM: U[16,15]
im_am =  round(m_am*2^15);
% Índice de modulacion de FM: U[16,16]
im_fm =  round(Kfm*1e-3/fsc*2^16);

% Display por consola
disp(' ')
disp('*****************************************')
disp('Values for HDL simulation')
disp('*****************************************')
disp(['c_fm_am = ' num2str(control_fm_am)])
disp(['frec_por = ' num2str(frec_por)])
disp(['im_am = ' num2str(im_am)])
disp(['im_fm = ' num2str(im_fm)])
disp('*****************************************')

%% Graficas AM/FM
L_s_in= length(s_in);
if graficas_si ==1
    if control_fm_am == 0 % graficas AM
        subplot(2,1,1)
        plot((1:L_s_in),s_in(1:L_s_in))
        ylabel('s\in(n)')
        axis([0 L_s_in -1 1])
        subplot(2,1,2)
        plot((1:L_s_in),s_am(1:L_s_in))
        ylabel('s\_am(n)')
        xlabel('n')
        axis([0 L_s_in -1 1])
    else % Graficas FM
        subplot(2,1,1)
        plot((1:L_s_in),s_in(1:L_s_in))
        ylabel('s\in(n)')
        axis([0 L_s_in -1 1])
        subplot(2,1,2)
        plot((1:L_s_in),s_fm(1:L_s_in))
        ylabel('s\_fm(n)')
        xlabel('n')
        axis([0 L_s_in -1 1])
    end
end
%% Generacion de ficheros de datos 
if ficheros_si == 1
    
 
    
end


