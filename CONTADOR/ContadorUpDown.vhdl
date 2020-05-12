--Stephanie Benitez
--A00820320
--Contador Up/Down 4 bits
library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
entity counter is 
  port(C, CLR, UP_DOWN : in std_logic; 
        Q : out std_logic_vector(3 downto 0)); 
end counter; 
architecture archi of counter is 
  signal tmp: std_logic_vector(3 downto 0); 
  begin  
    process (C, CLR) 
      begin 
        if (CLR='1') then 
          tmp <= "0000"; 
        elsif (C'event and C='1') then 
          if (UP_DOWN='1') then 
            tmp <= tmp + 1; 
          else 
            tmp <= tmp - 1; 
          end if; 
        end if; 
    end process; 
    Q <= tmp; 
end archi; 
