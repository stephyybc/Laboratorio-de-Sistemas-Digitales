--Stephanie Denisse Benitez Cabrera
--A00820320
--Practica 3 CONTADOR DE DECADAS

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY counter4uds is
    PORT (CLK,S: IN BIT;
    M:OUT BIT_VECTOR(3 DOWNTO 0));
END counter4uds;
ARCHITECTURE struc OF counter4uds is
COMPONENT ffta
PORT(T,CLK,RESET: IN BIT;
Q,QINV: OUT BIT);
END COMPONENT;
COMPONENT mux21 is
PORT (A,B: IN BIT;
C: OUT BIT);
END COMPONENT;
SIGNAL Q_INV, Q: BIT_VECTOR(3 DOWNTO 0);
SIGNAL A: BIT_VECTOR(2 DOWNTO 0);

begin
    T0: ffta PORT MAP('1',CLK,'0'Q(0),Q_INV(0));
    A0:and2bit PORT MAP('1',Q(0),A(0));
    T1:ffta PORT MAP(A(0),CLK,'0'Q(1),Q_INV(1));
    A1:and2bit PORT MAP(A(0),Q(1),A(1));
    T2:ffta PORT MAP(A(1),CLK,'0'Q(2),Q_INV(2));
    A2:and2bit PORT MAP(A(1),Q(2),A(2));
    T3:ffta PORT MAP(A(3),CLK,'0'Q(3),Q_INV(3));
    M0:mux21 PORT MAP (Q(0),Q_INV(0),S,M(0));
    M1:mux21 PORT MAP (Q(1),Q_INV(1),S,M(1));
    M2:mux21 PORT MAP (Q(2),Q_INV(2),S,M(2));
    M3:mux21 PORT MAP (Q(3),Q_INV(3),S,M(3));
END struct;
