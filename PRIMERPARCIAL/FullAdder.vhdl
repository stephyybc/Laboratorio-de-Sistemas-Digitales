--Stephanie Denisse Benitez Cabrera
--A00820320
--Laboratorio de Sistemas Digitales

library ieee;
use ieee.std_logic_1164.all;

--Declaramos la entidad del fulladder
entity FA is
    Port( A,B,Cin: in BIT;--Declaramos entradas
    Cout, S: out BIT);--Declaramos salidas
End entity;

--Armamos a estructura del fulladder
architecture struct of FA is
    begin
        S <= (A xor B) xor Cin;
        Cout <= (A and B) or (A and Cin) or (B and Cin);
    end struct; 