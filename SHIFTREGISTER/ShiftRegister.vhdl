--Stephanie Benitez 
--A00820320
--Registro de corrimiento 8 bits
library ieee; 
use ieee.std_logic_1164.all; 
 
entity shift is 
port(C, SI, LEFT_RIGHT : in std_logic; 
      PO : out std_logic_vector(7 downto 0)); 
end shift; 
architecture archi of shift is 
  signal tmp: std_logic_vector(7 downto 0); 
  begin 
    process (C) 
      begin 
        if (C'event and C='1') then 
          if (LEFT_RIGHT='0') then 
            tmp <= tmp(6 downto 0) & SI; 
          else 
            tmp <= SI & tmp(7 downto 1); 
          end if; 
        end if; 
    end process; 
    PO <= tmp; 
end archi; 
