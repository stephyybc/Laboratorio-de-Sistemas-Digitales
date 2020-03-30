-- Stephanie Denisse Benitez Cabrera
-- A00820320
-- Practica 2
-- Half Adder 

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity HA is
    port(A,B:in STD_LOGIC;
    Sum, Carry: out STD_LOGIC);
    end HA;

architecture struct of HA is
    component myXOR 
    port(in1,in2: in STD_LOGIC;
    out1: out STD_LOGIC);
    end component;
    begin 
    X1: myXOR port map(A,B,SUM);
    Carry <=A and B;
end struct;

