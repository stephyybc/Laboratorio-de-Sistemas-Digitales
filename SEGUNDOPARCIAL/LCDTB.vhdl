--Stephanie Denisse Benitez Cabrera
--A00820320
--Test Bench Reto Segundo Parcial
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_bit.all; 
use ieee.std_logic_textio.all;
Library std; 
use std.textio.all; 
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY LCDTB IS
END LCDTB;
 
ARCHITECTURE behavior OF LCDTB IS 
 
    COMPONENT LCD
    PORT(
         RESET : IN  bit;
         CLK : IN  bit;
         DATA_INSTRUCTIONS : IN  bit_vector(7 downto 0);
         RS : IN  bit;
         RWDATA : IN  bit;
         Señal_RS : OUT  bit;
         Señal_RW : OUT  bit;
         Señal_EN : OUT  bit;
         DATA : OUT  bit_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Declaramos la señal de los inputs
   signal RESET : bit := '0';
   signal CLK : bit := '0';
   signal RS : bit := '0'; 
   signal DATA_INSTRUCTIONS : bit_vector(7 downto 0) := (others => '0');
   signal RWDATA : bit := '0';

 	--Declaramos la señal de los outputs
   signal SIGNAL_RS : bit;
   signal SIGNAL_RW : bit;
   signal SIGNAL_EN : bit;
   signal DATA : bit_vector(7 downto 0);
	
	
   --Declaramos el periodo del clk
   constant CLK_period : time := 20 ns;
 
BEGIN
 
   uut: LCD PORT MAP (
          RESET => RESET,
          CLK => CLK,
          DATA_INSTRUCTIONS => DATA_INSTRUCTIONS,
          RS => RS,
          RWDATA => RWDATA,
          SIGNAL_RS => Señal_RS,
          SIGNAL_RW => Señal_RW,
          SIGNAL_EN => Señal_EN,
          DATA => DATA
        );

   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/10;
		CLK <= '1';
		wait for CLK_period/10;
   end process;
 

   -- Stimulus process
   stim_proc: process
	
		file fin: TEXT open READ_MODE is "input.txt"; 
		
		variable current_read_line : line; 
		variable current_read_field : bit_vector (10 downto 0); 
   begin		
      
		while (not endfile(fin)) loop
		
			wait for 100 ns;	
			readline(fin, current_read_line); 
			read(current_read_line, current_read_field); 
			
			RESET<= current_read_field(10); 
			RS<= current_read_field(9); 
			RWDATA<= current_read_field(8); 
			DATA_INSTRUCTIONS<= current_read_field(7 downto 0); 
      

      end loop; 

      wait;
    end process;
stimulus : process
   file fout : TEXT open WRITE_MODE is "output.txt"; 
      variable current_line :line; 
      begin 

         if (SIGNAL_RS = '0')  and (SIGNAL_EN = '1') then 
           write(current_line, string'("instr("));
           write(current_line, to_integer(signed(DATA)));
           write(current_line, string'(");"));
           writeline(fout, current_line);

         elsif (SIGNAL_RS = '1') and (SIGNAL_EN = '1') then 
            write(current_line, string'("data("));
            write(current_line, to_integer(signed(DATA)));
            write(current_line, string'(");"));  
            writeline(fout, current_line);

         end if;

       wait for 200 ns;
       end process;
    

END;