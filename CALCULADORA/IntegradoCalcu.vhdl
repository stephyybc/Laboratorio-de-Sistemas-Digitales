--Stephanie Denisse Benitez Cabrera
-- A00820320
-- Integrado de la calculadora mcd

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:16:16 06/01/2020 
-- Design Name: 
-- Module Name:    MCD - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_bit.all; 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity integradoMCD is
    Port ( GO : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           X : in  STD_LOGIC_vector(3 downto 0);
           Y : in  STD_LOGIC_vector(3 downto 0);
			  State: out string (1 to 7); 
           Datao : out  STD_LOGIC_vector(3 downto 0));
end integradoMCD;

architecture Behavioral of integradoMCD is

component Datapath is 
	Port ( Xi : in  STD_LOGIC_vector(3 downto 0);
           Yi : in  STD_LOGIC_vector (3 downto 0);
			  Oenb : in STD_LOGIC; 
			  selX, selY: in STD_LOGIC ; -- MUX
			  xld, yld, CLK: in STD_LOGIC; --Register
			  Xsub, Ysub: in STD_LOGIC; --Substractor
			  x_gt_y, x_eq_y, x_lt_y: out std_logic;
           datao : out  STD_LOGIC_vector(3 downto 0);
			  ssx, ssy: out std_logic_vector (3 downto 0));
end component; 

signal Xi, Yi : STD_LOGIC_vector(3 downto 0); 
signal selX, selY, Oenb : STD_LOGIC; 
signal xld, yld : STD_LOGIC; 
signal xsub, ysub: STD_LOGIC:= '0'; 
signal x_gt_y, x_eq_y, x_lt_y: std_logic;
signal ssx, ssy : std_logic_vector (3 downto 0); 


type State_type is (mux, regist, comparator, output); 

signal future_state : state_type := MUX; 
begin

	DP: Datapath port map (Xi, Yi, Oenb, selX, SelY, xld, yld, Clk, xsub, ysub,x_gt_y, x_eq_y, x_lt_y ,Datao, ssx, ssy; 
	
	
	process (CLK)
	begin 
	if rising_edge(CLK) then  
		case future_state is 
			when Mux => 
				state<= "State 0"; 
				if GO ='1' then
					 
					if x_gt_y = '1' then 
						selX<='1'; 
						selY<='0'; 
						Xi<= ssx; 
						future_state<= regist;
					elsif x_lt_y ='1' then 
						selX<='0';
						selY<='1';
						Yi<= ssy; 
						future_state<= regist;
					else 
						selX<='0'; 
						selY<='0';
						xi<=X; 
						yi<=Y; 
						future_state<= regist;
					end if; 
				else 
					future_state<= Mux; 
				end if; 
			
			when regist => 
				state<= "State 1"; 
				
				xld<= '1'; 
				yld<='1'; 
			   future_state<= comparator; 
			when comparator => 
				state<= "State 2"; 
				 
				xld<= '0'; 
				yld<='0';
				future_state<= output;
			when output => 
				state<="State 3"; 			
				if x_eq_y = '1' then 
					Oenb<='1';
				end if; 
				future_state<= Mux; 				
		end case;
		end if; 
	end process; 

end Behavioral;