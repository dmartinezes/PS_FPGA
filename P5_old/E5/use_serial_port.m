clear all

%% Configura operacion
WRITE = 1; % Escritura si -> 1, no ->0
READ = 1; % Lectura si -> 1, no ->0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Configure and open serial port
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Open serial port
%  buffer 4 bytes
buffSize=4;
portID = serial('COM3');  % Comprobar el puerto COMx
portID.BaudRate = 57600;
portID.DataBits = 8;
portID.Parity = 'none';
portID.StopBits = 1;
portID.FlowControl = 'none';
portID.Timeout = 2;
portID.InputBufferSize = buffSize;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Bytes configuración
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% frec_mod registers
frec_mod_b0 = 1;
frec_mod_b1 = 2;
frec_mod_b2 = 3;
% frec_por register
frec_por_b0 = 4;
frec_por_b1 = 5;
frec_por_b2 = 6;
% im_am registers
im_am_b0 = 7;
im_am_b1 = 8;
% im_fm registers
im_fm_b0 = 9;
im_fm_b1 = 10;
% Control register
c_byte = 11;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Write registers 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if WRITE == 1
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
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Read registers 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if READ == 1
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
end
%%
%%%%%%%%%%