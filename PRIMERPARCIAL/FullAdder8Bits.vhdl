--Stephanie Denisse Benitez Cabrera
--A00820320
--Laboratorio de Sistemas Digitales
--Sumador/restador 8 bits con signo(complemento a 2)
--Programación basada en el esquema

--Primero declaramos la libreria
Library ieee;
use ieee.std_logic_1164.ALL;

--Declaramos la entidad
entity sumrest is
    port(
        X: in bit_vector(7 DOWNTO 0);--Se declara operando X y el número de bits
        Y: in bit_vector(7 DOWNTO 0);--Se declara operando Y y el número de bits
        T: in bit;--define la operación suma resta
        C_FLAG: out bit;--bandera de carry out
        OV_FLAG: out bit;--bandera de overflow
        R: out bit_vector(7 DOWNTO 0)--resultado y número de bits
    );
end entity;

--Declaramos la arquitectura del sumador/restador
architecture struct of sumrest is
    component FA is
        Port(
            X,Y,Cin: in bit;
            Cout, S: out bit
        );
    end component;
    signal C: bit_vector(7 DOWNTO 0);--salida del carry
    signal Q: bit_vector(7 DOWNTO 0)--salida del xor para complementarlo
    begin 
    Q(0): <= Y(0) xor T;
    Q(0): <= Y(1) xor T; 
    Q(0): <= Y(2) xor T; 
    Q(0): <= Y(3) xor T; 
    Q(0): <= Y(4) xor T; 
    Q(0): <= Y(5) xor T; 
    Q(0): <= Y(6) xor T; 
    Q(0): <= Y(7) xor T;  

    FA0: FullAdder port map(FullAdder port map(A(0),Q(0),T,C(0),R(0));
    FA1: FullAdder port map(FullAdder port map(A(1),Q(1),T,C(1),R(1));
    FA2: FullAdder port map(FullAdder port map(A(2),Q(2),T,C(2),R(2));
    FA3: FullAdder port map(FullAdder port map(A(3),Q(3),T,C(3),R(3));
    FA4: FullAdder port map(FullAdder port map(A(4),Q(4),T,C(4),R(4));
    FA5: FullAdder port map(FullAdder port map(A(5),Q(5),T,C(5),R(5));
    FA6: FullAdder port map(FullAdder port map(A(6),Q(6),T,C(6),R(6));
    FA7: FullAdder port map(FullAdder port map(A(7),Q(7),T,C(7),R(7));
    
    C_Flag <= C(7);--Se encuentra en el útlimo FA
    OV_Flag <= C(7) xor C(6);--Es la comapración entre el útlimo carry y el penúltimo
end struct; 

