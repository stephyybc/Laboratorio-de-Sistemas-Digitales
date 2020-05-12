library IEEE;                                                
use IEEE.STD_LOGIC_1164.ALL;	
use IEEE.std_logic_unsigned.ALL;	

entity Reloj is
	port (start, reset, clk : in bit;
			SU, SD, MU, MD, HU, HD: out bit_VECTOR (3 downto 0)); --- MinutosUnidades y MinutosDecenas
end Reloj;

architecture behavioral of Reloj is
		
	component seg is
		port (Start, reset, clk : in bit;
				pre: in bit_VECTOR (3 downto 0);
			 SU, SD: out bit_VECTOR (3 downto 0));
	end component;

	signal SUaux, SDaux, MUaux, MDaux, HUaux, HDaux : bit_VECTOR (3 downto 0);
	signal clkM, clkH, resetHoras : bit;
	signal preS, Preaux, PreH, Q3, Q2, Q1: bit_VECTOR (3 downto 0);
	
	begin
	
	clkM <= '0' when (SDaux = "0110") else '1';
	clkH <= '0' when (MDaux = "0110") else '1';
	resetHoras <= '1' when (reset = '1' or (HUaux = "0010" and HDaux = "0001")) else '0';
	pres <= "0000";
	preaux <= "1111" when (HUaux = "0000" and HDaux = "0000") else "0000";
	
	process (clk)
		begin
			if(clk = '1' and clk'event) then
				Q1 <= Preaux;
				Q2 <= Q1; 
				Q3 <= Q2;
			end if;
	end process;
	preH <= Q1 and Q2 and not Q3;
	
	Segundos: Seg port map(Start, reset, clk, preS, SUaux, SDaux);
	Minutos : Seg port map('1', reset, clkM, preS, MUaux, MDaux);
	Horas : seg port map('1', resetHoras, clkH, PreH, HUaux, HDaux);
	
		SU <= SUaux;
		SD <= SDaux;
		
		MU <= MUaux;
		MD <= MDaux;
		
		HU <= HUaux;
		HD <= HDaux;
end behavioral;