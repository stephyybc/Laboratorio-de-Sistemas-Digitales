--Stephanie Denisse Benitez
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Calculadora is
	port(SW : in BIT_VECTOR(7 downto 0);
		  E,C : in BIT;
		  Disp: out BIT_VECTOR(7 downto 0);
		  en : out BIT_VECTOR (3 downto 0) );
end Calculadora;

architecture Behavioral of Calculadora is
	signal S, SP, SPP, SPPP : BIT_VECTOR(3 downto 0);
	SIGNAL CLK, DE: bit;
	SIGNAL EDA : BIT_VECTOR (7 DOWNTO 0);
	
	COMPONENT DEBOUNCE IS
	PORT (
		CLK : IN BIT;
		DIN : IN BIT;
		QOUT : OUT BIT);
	END COMPONENT;
	
	component DISPLAY IS
	PORT(
		CLK : IN BIT;
		D3 : IN BIT_VECTOR(3 DOWNTO 0);
		D2 : IN BIT_VECTOR(3 DOWNTO 0);
		D1 : IN BIT_VECTOR(3 DOWNTO 0);
		D0 : IN BIT_VECTOR(3 DOWNTO 0);
		S8 : OUT BIT_VECTOR (7 DOWNTO 0);
		EN : OUT BIT_VECTOR(3 DOWNTO 0));
		
END component;

component CLK_500HZ IS
	PORT (
		MCLK : IN BIT;
		CLKOUT : OUT BIT
	);
END component;
	
begin

	ET1 : CLK_500HZ PORT MAP (C,CLK);
	ET3 : DEBOUNCE PORT MAP (CLK,E,DE);
	
	PROCESS (DE)
	BEGIN
		IF DE ='1' AND DE'EVENT THEN
			IF (sw= "00000000" or sw="00000001" or sw = "00000010" or sw="00000100" or sw="00001000" or sw="00010000" or sw="00100000" or sw="01000000" or sw="10000000") then
			SPPP <= SPP;
			SPP <= SP;
			SP <= S;
			EDA <= SW;
			END IF; 
		END IF;
	END PROCESS;
	
	S <= "0000" when (EDA="00000000") else
		  "0001" when (EDA="00000001") else
		  "0010" when (EDA="00000010") else
		  "0011" when (EDA="00000100") else
		  "0100" when (EDA="00001000") else
		  "0101" when (EDA="00010000") else
		  "0110" when (EDA="00100000") else
		  "0111" when (EDA="01000000") else
		  "1000" when (EDA="10000000") else SP;
		  
	ET2 : DISPLAY PORT MAP (CLK, SPPP,SPP,SP,S,Disp,en);
		  
	
end Behavioral;
--------------------------------------------------------------------------
ENTITY DISPLAY IS
	PORT(
		CLK : IN BIT;
		D3 : IN BIT_VECTOR(3 DOWNTO 0);
		D2 : IN BIT_VECTOR(3 DOWNTO 0);
		D1 : IN BIT_VECTOR(3 DOWNTO 0);
		D0 : IN BIT_VECTOR(3 DOWNTO 0);
		S8 : OUT BIT_VECTOR (7 DOWNTO 0);
		EN : OUT BIT_VECTOR(3 DOWNTO 0)
	);
END DISPLAY;

ARCHITECTURE Behavioral OF DISPLAY IS

	SIGNAL STATE, NEW_STATE: BIT_VECTOR(3 DOWNTO 0) := "1000"; 
	SIGNAL DN : BIT_VECTOR(3 DOWNTO 0) := "0000";
	
BEGIN

	PROCESS (CLK)
	BEGIN
		IF (CLK = '1' AND CLK'EVENT) THEN
			STATE <= NEW_STATE;
		END IF;
	END PROCESS;


	NEW_STATE <= "0001" WHEN (STATE = "1000") ELSE
	             "0010" WHEN (STATE = "0001") ELSE
	             "0100" WHEN (STATE = "0010") ELSE
	             "1000" WHEN (STATE = "0100") ELSE
	             "0001";
 
	DN <= D0 WHEN (STATE = "0001") ELSE
	      D1 WHEN (STATE = "0010") ELSE
	      D2 WHEN (STATE = "0100") ELSE
	      D3 WHEN (STATE = "1000") ELSE
	      "1111";
	 
	EN <= NOT STATE;

	S8 <= "11000000" WHEN DN = "0000" ELSE
	      "11111001" WHEN DN = "0001" ELSE
	      "10100100" WHEN DN = "0010" ELSE
	      "10110000" WHEN DN = "0011" ELSE
	      "10011001" WHEN DN = "0100" ELSE
	      "10010010" WHEN DN = "0101" ELSE
	      "10000010" WHEN DN = "0110" ELSE
	      "11111000" WHEN DN = "0111" ELSE
	      "10000000" WHEN DN = "1000" ELSE
	      "10010000" WHEN DN = "1001" ELSE
	      "10001000" WHEN DN = "1010" ELSE
	      "10000011" WHEN DN = "1011" ELSE
	      "11000110" WHEN DN = "1100" ELSE
	      "10100001" WHEN DN = "1101" ELSE
	      "10000110" WHEN DN = "1110" ELSE
	      "10001110";

END Behavioral;
----------------------------------------------------------------------------------------
ENTITY CLK_500HZ IS
	PORT (
		MCLK : IN BIT;
		CLKOUT : OUT BIT
	);
END CLK_500HZ;

ARCHITECTURE Behavioral OF CLK_500HZ IS
	SIGNAL COUNTER : INTEGER RANGE 0 TO 49_999 := 0;
	SIGNAL C500HZ : BIT;
BEGIN
	PROCESS (MCLK)
	BEGIN
		IF MCLK = '1' AND MCLK'EVENT THEN
			IF COUNTER = 49_999 THEN
				COUNTER <= 0;
				C500HZ <= NOT C500HZ;
			ELSE COUNTER <= COUNTER + 1;
			END IF;
		ELSE NULL;
		END IF;
	END PROCESS;

	CLKOUT <= C500HZ;
END Behavioral;
----------------------------------------------------------------------------------------------
LIBRARY IEEE;

ENTITY DEBOUNCE IS
	PORT (
		CLK : IN BIT;
		DIN : IN BIT;
		QOUT : OUT BIT);
END DEBOUNCE;

ARCHITECTURE Behavioral OF DEBOUNCE IS
	SIGNAL Q1, Q2, Q3 : BIT;
BEGIN
	PROCESS (CLK)
	BEGIN
		IF (CLK = '1' AND CLK'EVENT) THEN
			Q1 <= DIN;
			Q2 <= Q1;
			Q3 <= Q2;
		END IF;
	END PROCESS;

	QOUT <= Q1 AND Q2 AND NOT Q3;

END Behavioral;