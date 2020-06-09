--Stephanie Denisse Benitez Cabrera
--A00820320
--Output register design vhdl


library ieee;
use ieee.std_logic_1164.all;

entity Register4B is
    port (
        --Declaramos entradas y salidas para el output register
        FFd_in : in std_logic_vector(3 downto 0);
        clk : in std_logic;
        load : in std_logic;
        reset : in std_logic;
        FFd_out : out std_logic_vector(3 downto 0)
    );
end entity;

architecture behaivoral of Register4B is 
   begin
   process (clk) 
   begin
         if (reset = '1') then
             FFd_out <= "0000";
         else
             if(rising_edge(clk)) then
                 if (load = '1') then
                     FFd_out <= FFd_in;
                 else 
                     null;
                 end if;
             end if;
         end if;
     end process;
   

end behaivoral;