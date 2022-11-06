-- iTEAM - GISED
-- Author: Fabian Angarita (faanpre@iteam.upv.es)
-- 
-- Description: 
--   RS-232 Serial communication core. 
-- 
-- Version    Date           Author     Comments
--  v1.0       01/10/2014     Fabian     Final release

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity comm_rs232 is
    generic(ncpb: integer:= 434);                    --number of clock cycles per serial bit
    port(id_rxds : in std_logic;                     --rx serial data
         id_txdw : in std_logic_vector(7 downto 0);  --data to transmit : u[8 0]
         ic_txena : in std_logic;                    --transmit enable
         ic_clk : in std_logic;                      --clock signal
         ic_rst : in std_logic;                      --reset signal
         od_txds : out std_logic;                    --tx serial data
         oc_txbsy : out std_logic;                   --transmitting busy
         od_rxdw : out std_logic_vector(7 downto 0); --received data : u[8 0]
         oc_rxrdy : out std_logic);                  --received ready
end comm_rs232;

architecture rtl of comm_rs232 is
    --functions
    function log2(n: integer) return integer is
    begin
        for i in 0 to 31 loop
            if (2**i >= n) then return(i);
            end if;
        end loop;
        return(31);
    end function;
    --b0: rs232 receiver
    constant b0_loadbit_c: std_logic_vector(0 to 15):= x"8001";
    constant b0_rxcontrol_c: std_logic_vector(0 to 7):= x"70";
    signal b0_rxsyn_r: std_logic_vector(5 downto 0); --u[6 0]
    signal b0_rxsld_s: std_logic;
    signal b0_rxbit_r: std_logic;
    signal b0_rxcrun_r,b0_rxcend_s: std_logic;
    signal b0_rxcaddr_s: std_logic_vector(2 downto 0); --[3 0]
    signal b0_cntb_inc_s: std_logic;
    signal b0_cntw_r: std_logic_vector(log2(ncpb)-1 downto 0); --u[ncpb 0]
    signal b0_cntb_r: std_logic_vector(3 downto 0); --u[4 0]
    signal b0_rxsrl_r: std_logic_vector(8 downto 0); --u[9 0]
    signal b0_rxtick_s: std_logic;
    signal b0_rxdw_r: std_logic_vector(7 downto 0); --u[8 0]
    signal b0_rxrdy_r: std_logic;
    --b1: rs232 transmitter
    constant b1_txcontrol_c: std_logic_vector(0 to 7):= x"70";
    signal b1_txcrun_r,b1_txcend_s: std_logic;
    signal b1_txcaddr_s: std_logic_vector(2 downto 0); --[3 0]
    signal b1_cntb_inc_s: std_logic;
    signal b1_cntw_r: std_logic_vector(log2(ncpb)-1 downto 0); --u[ncpb 0]
    signal b1_cntb_r: std_logic_vector(3 downto 0); --u[4 0]
    signal b1_psrl_r: std_logic_vector(8 downto 0); --u[9 0]
    signal b1_txtick_s: std_logic;
    --
begin
    --b0: rs232 receiver
    process(ic_clk)
    begin
        if rising_edge(ic_clk) then
            if ic_rst='1' then
                b0_rxsyn_r <= (others => '0');
                b0_rxbit_r <= '0';
                b0_rxcrun_r <= '0';
                b0_cntw_r <= (others => '0');
                b0_cntb_r <= (others => '0');
                b0_rxsrl_r <= (others => '0');
                b0_rxdw_r <= (others => '0');
                b0_rxrdy_r <= '0';
            else
                b0_rxsyn_r <= not(id_rxds)&b0_rxsyn_r(5 downto 1);
                if b0_rxsld_s='1' then
                    b0_rxbit_r <= b0_rxsyn_r(0);
                end if;
                b0_rxcrun_r <= b0_rxcontrol_c(conv_integer(b0_rxcaddr_s));
                if b0_rxcrun_r='0' or b0_cntw_r=(ncpb-1) then
                    b0_cntw_r <= (others => '0');
                else
                    b0_cntw_r <= b0_cntw_r + '1';
                end if;
                if b0_rxcrun_r='0' or b0_rxcend_s='1' then
                    b0_cntb_r <= (others => '0');
                else
                    b0_cntb_r <= b0_cntb_r + b0_cntb_inc_s;
                end if;
                if b0_rxtick_s='1' then
                    b0_rxsrl_r <= not(b0_rxbit_r)&b0_rxsrl_r(8 downto 1);
                end if;
                if b0_rxcend_s='1' then
                    b0_rxdw_r <= b0_rxsrl_r(7 downto 0);
                end if;
                b0_rxrdy_r <= b0_rxcend_s;
            end if;
        end if;
    end process;
    b0_rxsld_s <= b0_loadbit_c(conv_integer(b0_rxsyn_r(3 downto 0)));
    b0_rxcaddr_s <= b0_rxcend_s & b0_rxbit_r & b0_rxcrun_r;
    b0_cntb_inc_s <= '1' when b0_cntw_r=(ncpb-1) else '0';
    b0_rxcend_s <= '1' when b0_cntb_r="1001" and b0_cntw_r=(ncpb-1) else '0';
    b0_rxtick_s <= '1' when b0_cntw_r=(ncpb/2) else '0';
    --b1: rs232 transmitter
    process(ic_clk)
    begin
        if rising_edge(ic_clk) then
            if ic_rst='1' then
                b1_txcrun_r <= '0';
                b1_cntw_r <= (others => '0');
                b1_cntb_r <= (others => '0');
                b1_psrl_r <= (others => '0');
            else
                b1_txcrun_r <= b1_txcontrol_c(conv_integer(b1_txcaddr_s));
                if b1_txcrun_r='0' or b1_cntw_r=(ncpb-1) then
                    b1_cntw_r <= (others => '0');
                else
                    b1_cntw_r <= b1_cntw_r + '1';
                end if;
                if b1_txcrun_r='0' or b1_txcend_s='1' then
                    b1_cntb_r <= (others => '0');
                else
                    b1_cntb_r <= b1_cntb_r + b1_cntb_inc_s;
                end if;
                if ic_txena='1' and b1_txcrun_r='0' then
                    b1_psrl_r <= not(id_txdw)&"1";
                elsif b1_txtick_s='1' then
                    b1_psrl_r <= "0"&b1_psrl_r(8 downto 1);
                end if;
            end if;
        end if;
    end process;
    b1_txcaddr_s <= b1_txcend_s & ic_txena & b1_txcrun_r;
    b1_cntb_inc_s <= '1' when b1_cntw_r=(ncpb-1) else '0';
    b1_txcend_s <= '1' when b1_cntb_r="1001" and b1_cntw_r=(ncpb-1) else '0';
    b1_txtick_s <= '1' when b1_cntw_r=(ncpb-1) else '0';
    --
    od_txds <= not(b1_psrl_r(0));
    oc_txbsy <= b1_txcrun_r;
    od_rxdw <= b0_rxdw_r;
    oc_rxrdy <= b0_rxrdy_r;
end rtl;
