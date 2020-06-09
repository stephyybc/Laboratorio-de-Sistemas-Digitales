--Stephanie Dernisse Benitez Cabrera
--A00820320
--Controller Calculadora

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Controller is
    Port ( GO : in  std_logic;
           CLK : in  std_logic;
			  RESET : in std_logic; 
			  state : out std_logic_vector(1 downto 0));
end Controller;

architecture Behavioral of Controller is
type State_type is (mux, regist, comparator, subtractor); 
signal presentstate : state_type := MUX; 
signal futurestate : state_type; 
begin
	process (CLK) 
	begin 
		if rising_edge(CLK) and GO ='1' then  
			if Reset ='1' then presentstate<= mux; 
			else presentstate<=futurestate;
			end if; 
		end if; 
	end process; 
	
	process (presentstate)
	begin 
		case presentstate is 
			when Mux => 
				state<= "00"; 
				futurestate<= regist; 
			
			when regist => 
				state<= "01"; 
				futurestate<= comparator; 
			
			when comparator => 
				state<= "10"; 
				futurestate<= subtractor; 
				
			when subtractor => 
				state<="11"; 
				futurestate<= Mux; 
		end case; 
	end process; 

end Behavioral;