--Stephanie Denisse Benitez Cabrera
--A00820320
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

--Primero ponemos la entidad de la LCD
entity LCD is 
port(RESET: in std_logic;
    CLK : in std_logic;
    DATA_INSTRUCTIONS: in std_logic_vector(7 downto 0);
    RS: is std_logic;-- data
    RW: in std_logic);-- reads and write

    SIGNAL_RS: out std_logic;
    SIGNAL_RW: out std_logic;
    SIGNAL_EN: out std_logic; --esta es la señal del enable
    DATA: out std_logic_vector(7 downto 0));
end entity LCD;

architecture DisplayDeLcd of LCD is
type state is(IDLE,RUN);
signal present: state;

begin 

process(CLK)
 variable clk_count: integer := 0;
 begin
    if rising_edge(CLK) then
        case present is
            when IDLE=>
                if(RW = '1') and (RESET = '0') then
                SIGNAL_RS <= '0';
                SIGNAL_RW <= RW;
                DATA <= DATA_INSTRUCTIONS;
                present <= RUN;
                else
                SIGNAL_RS <= '0';
                SIGNAL_RW <= '0';
                SIGNAL_EN <= "00000000";
                present <= IDLE;
                end if;
            
            when RUN =>
                if(clk_count <= 10) then 
                clk_count := clk_count + 1;
                SIGNAL_EN <= '1';
                present <= RUN;
                else
                    SIGNAL_EN <= '0';
                    clk_count := 0;
                    present <= IDLE;
                end if;
            when others => null;
                    end case;
                    end if;
end process;
end DisplayDeLcd; 

