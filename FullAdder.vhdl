--Stephanie Denisse Benitez Cabrera
-- A00820320
-- Practica 2
-- Full Addervhdl program

--Usare el programa de dos half adders para pdoer realizar este FA
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FA isport(x,y,cin: in std_logic;
s, cout: out std_logic);
end FA;

architecture struct of FA is
    signal s1,c1,c2: std_logic;
    component HA 
       port(A,B:in STD_LOGIC;
       sum, Carry: out STD_LOGIC);
    end  component;
    begin 

    HA1: HA port map(x,y,s1,c1);
    HA2: HA port map(s1,cin,s,c2);
    cout<=c1 or c2;

end struct;



