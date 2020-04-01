--Stephanie Denisse Benitez Cabrera
--a00820310
--Laboratorio de sistemas digitales
--Practica 3 simulacion

LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY testbench IS
  END testbench;

  ARCHITECTURE behavior OF testbench IS 

  -- Component Declaration
          COMPONENT Counter0_99
          PORT(
                  CLK : IN bit;
                  CLR : IN bit;       
                  SET : IN bit; 
						Q : out bit_vector (7 downto 0));
          END COMPONENT;

          SIGNAL CLK : bit;
          SIGNAL  CLR : bit;       
          SIGNAL SET : bit; 
			 SIGNAL Q : bit_vector (7 downto 0);
          
	constant CLK_period : time := 100 ns;
  BEGIN

  -- Component Instantiation
          uut: Counter0_99 PORT MAP(
                  CLK => CLK,
                  CLR => CLR, 
						SET => SET, 
						Q => Q
          );

	
	
	CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 100 ns; 
		  CLR<= '1'; 
		  SET<= '0'; 
		  
		  wait for 10 ns; 
		  CLR<= '0'; 
		  SET<= '0';
        wait; -- will wait forever
     END PROCESS tb;
  --  End Test Bench 

  END;