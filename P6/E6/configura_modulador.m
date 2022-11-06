clear all
close all
%% MOD AM/FM CONFIGURATION

% Control FM --> 1, AM --> 0
control_fm_am=0;

% Sampling frequency (MHz)
fsc=100; % MHz

% Carrier frequency (MHz)
fc=1; % MHz

% AM modulation index (range [0,1[)
m_am=1*(1-2^-15);

% FM modulation index (kHz)
Kfm=5000; % kHz

% Modulator source signal: SIN ->0; RAMP->1; SQR->2;
source_sel = 0;

% Modulating frequency (kHz)
fmod= 10; % kHz

%Reset
rst = 1;

%% Verilog simulation values
frec_por = round(fc/fsc*2^24);
im_am = round(m_am*2^15);
im_fm = round(Kfm*1e-3/fsc*2^16);
frec_mod = round(2^24*fmod*1e-3/(fsc/2000));

%% a) 

% Modulating frequency (kHz) to bytes
q_mf = quantizer([24 24],'saturate','floor');
fmod_bin = num2bin(q_mf,(frec_mod * 2^(-24)));

frec_mod_b0 = bin2dec(fmod_bin(17:24));
frec_mod_b1 = bin2dec(fmod_bin(9:16));
frec_mod_b2 = bin2dec(fmod_bin(1:8));

% Frec por (U[24,24]) to bytes
q_fp = quantizer([24 24],'saturate','floor');
frec_por_bin = num2bin(q_fp,frec_por*2^(-24));

frec_por_b0 = bin2dec(frec_por_bin(17:24));
frec_por_b1 = bin2dec(frec_por_bin(9:16));
frec_por_b2 = bin2dec(frec_por_bin(1:8));

% AM modulation index (range [0,1[) to bytes
q_am = quantizer([16 15],'saturate','floor');
am_bin = num2bin(q_am,im_am*2^(-15));

im_am_b0 = bin2dec(am_bin(9:16));
im_am_b1 = bin2dec(am_bin(1:8));

% FM modulation index (range [0,1[) to bytes
q_fm = quantizer([16 16],'saturate','floor');
Kfm_bin = num2bin(q_fm,im_fm*2^(-16));

im_fm_b0 = bin2dec(Kfm_bin(9:16));
im_fm_b1 = bin2dec(Kfm_bin(1:8));

% Control register
%c_byte = ['0' '0' '0' '0' dec2bin(rst) dec2bin(control_fm_am) dec2bin(source_sel)]; 
c_byte_bin = ['0' '0' '0' '0' dec2bin(source_sel,2) dec2bin(control_fm_am,1) dec2bin(rst,1)]; 
c_byte = bin2dec(c_byte_bin);

%% b) 
%% Configure and open serial port
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open serial port
%  buffer 4 bytes
buffSize=4;
portID = serial('COM4');  % Comprobar el puerto COMx
portID.BaudRate = 57600;
portID.DataBits = 8;
portID.Parity = 'none';
portID.StopBits = 1;
portID.FlowControl = 'none';
portID.Timeout = 2;
portID.InputBufferSize = buffSize;


%% Write registers
% Abrir puerto
fopen(portID)
% Envio instruccion
fwrite(portID,hex2dec('0F'))
% Envio 11 bytes
fwrite(portID,frec_mod_b0)
fwrite(portID,frec_mod_b1)
fwrite(portID,frec_mod_b2)
fwrite(portID,frec_por_b0)
fwrite(portID,frec_por_b1)
fwrite(portID,frec_por_b2)
fwrite(portID,im_am_b0)
fwrite(portID,im_am_b1)
fwrite(portID,im_fm_b0)
fwrite(portID,im_fm_b1)
fwrite(portID,c_byte)
% Cierro el puerto
fclose(portID)

%% c)
%% Read registers
% Abre puerto
fopen(portID)
% Envio instruccion lectura
fwrite(portID,hex2dec('F0'))
% Leo 11 bytes
r_frec_mod_b0 = fread(portID,1);
r_frec_mod_b1 = fread(portID,1);
r_frec_mod_b2 = fread(portID,1);
r_frec_por_b0 = fread(portID,1);
r_frec_por_b1 = fread(portID,1);
r_frec_por_b2 = fread(portID,1);
r_im_am_b0 = fread(portID,1);
r_im_am_b1 = fread(portID,1);
r_im_fm_b0 = fread(portID,1);
r_im_fm_b1 = fread(portID,1);
r_c_byte = fread(portID,1);
% Cierra puerto
fclose(portID)

%% d)

r_frec_mod_bT = [dec2bin(r_frec_mod_b2,8) dec2bin(r_frec_mod_b1,8) dec2bin(r_frec_mod_b0,8)];
r_frec_mod = bin2dec(r_frec_mod_bT);

r_frec_por_bT = [dec2bin(r_frec_por_b2,8) dec2bin(r_frec_por_b1,8) dec2bin(r_frec_por_b0,8)];
r_frec_por = bin2dec(r_frec_por_bT);

r_im_am_bT = [dec2bin(r_im_am_b1,8) dec2bin(r_im_am_b0,8)];
r_im_am = bin2dec(r_im_am_bT);

r_im_fm_bT = [dec2bin(r_im_fm_b1,8) dec2bin(r_im_fm_b0,8)];
r_im_fm = bin2dec(r_im_fm_bT);

r_rst = mod(floor(r_c_byte),2);
r_control_fm_am = mod(floor(r_c_byte/2),2);
r_source_sel = mod(floor(r_c_byte/4),4);

% Display por consola
disp(' ')
disp('*****************************************')
disp('Values in r_control:')
disp('*****************************************')
disp(['rst = ' num2str(r_rst)])
disp(['control_fm_am = ' num2str(r_control_fm_am)])
disp(['source_sel = ' num2str(r_source_sel)])
disp('*****************************************')
disp('Rest of values:')
disp('*****************************************')
disp(['frec_mod = ' num2str(r_frec_mod)])
disp(['frec_por = ' num2str(r_frec_por)])
disp(['im_am = ' num2str(r_im_am)])
disp(['im_fm = ' num2str(r_im_fm)])






%c_byte_dec = bin2dec(c_byte);


