--Stephanie Denisse Benitez Cabrera
--A00820320
--Laboratorio de sistemas digitales
--Practica 4 simulacion

--Declaramos la libreria
library IEEE;
use IEEE.std_logic_1164.all;

entity decoderBCD4to7segments_tb is
end entity;

architecture arch of decoderBCD4to7segments_tb is

    component decoderBCD4to7segments is
        port (
            a, b, c, d, e, f, g : out std_logic;
            x3, x2, x1, x0 : in std_logic
        );
    end component;

    signal tbVectOut : std_logic_vector (6 downto 0);
    signal tbVectIn : std_logic_vector (3 downto 0);

begin

    unit_unde_test: decoderBCD4to7segments port map (
        a => tbVectOut(6),
        b => tbVectOut(5),
        c => tbVectOut(4),
        d => tbVectOut(3),
        e => tbVectOut(2),
        f => tbVectOut(1),
        g => tbVectOut(0),
        x3 => tbVectIn(3),
        x2 => tbVectIn(2),
        x1 => tbVectIn(1),
        x0 => tbVectIn(0)
    );

    generate_input_signals : process
    begin
        tbVectIn <= "UUUU"; wait for 10 ns;
        tbVectIn <= "0000"; wait for 10 ns;
        tbVectIn <= "0001"; wait for 10 ns;
        tbVectIn <= "0010"; wait for 10 ns;
        tbVectIn <= "0011"; wait for 10 ns;
        tbVectIn <= "0100"; wait for 10 ns;
        tbVectIn <= "0101"; wait for 10 ns;
        tbVectIn <= "0110"; wait for 10 ns;
        tbVectIn <= "0111"; wait for 10 ns;
        tbVectIn <= "1000"; wait for 10 ns;
        tbVectIn <= "1001"; wait for 10 ns;
        tbVectIn <= "1010"; wait for 10 ns;
        tbVectIn <= "1011"; wait for 10 ns;
        tbVectIn <= "1100"; wait for 10 ns;
        tbVectIn <= "1101"; wait for 10 ns;
        tbVectIn <= "1110"; wait for 10 ns;
        tbVectIn <= "1111"; wait for 10 ns;
        report "Simulación terminada.";
        wait;
    end process;

end architecture;