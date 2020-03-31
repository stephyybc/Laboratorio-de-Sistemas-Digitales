--Stephanie Denisse Benitez Cabrera
--A00820320
--Practica 2 FULL ADDER
--Test bench

--Declaramos la libreria
library ieee;
use ieee.std_logic_1164.ALL;

--Declaramos la entidad
entity FA_Bhr is
    port(
        Fx, Fy, Fcin: in BIT;
        Fs, Fcout:out BIT
    );
end FA_Bhr;

--Declaramos la arquitectura
architecture FA_struct of FA_Bhr is
    component HA
    port(
        hx,hy: in BIT;
        hs,hcout: out BIT
    );
end component;

--Test
signal s1,c1,c2: BIT;
begin 
HA1:HA port map(Fx,Fy,s1,c1);
HA2:HA port map(s1,Fcin,Fs,c2);
Fcout<=c1 OR c2;
end FA_struct;

