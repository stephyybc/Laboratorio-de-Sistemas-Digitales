--Stephanie Denisse Benitez Cabrera
--A00820320
--Contador de 0 a 99
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity cotador is
    Port ( reloj : in std_logic;
           reset : in std_logic;
           habent : in std_logic;
           habsal : out std_logic;
         cuentamax: in std_logic_vector (3 downto 0);
           selec:in std_logic_vector (3 downto 0);
			  anodosut std_logic_vector (3 downto 0);
			  salida : out std_logic_vector (6 downto 0));
			  
end cotador;

architecture Behavioral of cotador is
 signal clock:std_logic; 
 signal count:std_logic_vector (3 downto 0);
 begin

process(reloj)
   variable conta : integer range 0 to 50000000 :=0;
     begin
        if reloj = '1' and reloj'event then
            if conta =50000000 then
					conta :=0;
					clock <='1';
				else
					conta:=conta+1;
					clock<='0';
				end if;
		  end if;
 end process;  




   process (cuentamax,clock, reset)
     variable cuenta: std_logic_vector (3 downto 0):="0000";
      begin
         if reset = '1' then
          count<="0000";
            elsif clock='1' and clock'event then
               if habent='0' then 
                 if count = cuentamax then
                    count<="0000";
                 else
                     count<=count+1;
                 end if;
                end if;
          end if;


   
   
   if count=cuentamax and habent = '0' and clock = '1' then
     habsal<='0';
      	else
        habsal<='1';
 
	 end if;
	
  end process;

with count select
	salida<="1111001" when "0001",
			  "0100100" when "0010",
			  "0110000" when "0011",
			  "0011001" when "0100",
			  "0010010" when "0101",
			  "0000010" when "0110",
			  "1111000" when "0111",
			  "0000000" when "1000",
			  "0010000" when "1001",
			  "1000000" when others;

										 anodos<=selec;

end Behavioral;