entity multiplier is
  port(a0, a1, a2, a3: in bit;
    b0, b1, b2, b3: in bit;
    z0, z1, z2, z3, z4, z5, z6, z7, z8: out bit);
end multiplier;

architecture logic of multiplier is
  component Full_Add
    port (i0, i1 : in bit; ci : in bit;
      s : out bit;
      co : out bit);
  end component;
  component HalfAdd
    port (i0, i1 : in bit;
      s : out bit;
      co : out bit);
    end component;
signal AN00, AN10, AN20, AN30: bit;
signal AN01, AN11, AN21, AN31: bit;
signal AN02, AN12, AN22, AN32: bit;
signal AN03, AN13, AN23, AN33: bit;
signal CA1, CA2, CA3, CA4, CA5, CA6: bit;
signal CA7, CA8, CA9, CA10, CA11, CA12: bit;
signal SUM1, SUM2, SUM3, SUM4, SUM5, SUM6: bit;

begin
  z0 <= AN00;
  HA1: HalfAdd port map(AN01, AN11, z1, CA1);
  FA1: Full_Add port map(AN11, AN21, CA1, SUM1, CA2);
  FA2: Full_Add port map(AN21, AN31, CA2, SUM2, CA3);
  FA3: Full_Add port map(AN31, '1', CA3, SUM3, CA4);
  HA2: HalfAdd port map(AN02, SUM1, z2, CA5);
  FA4: Full_Add port map(AN12, SUM2, CA5, SUM4, CA6);
  FA5: Full_Add port map(AN22, SUM3, CA6, SUM5, CA7);
  FA6: Full_Add port map(AN32, CA4, CA7, SUM6, CA8);
  HA3: HalfAdd port map(AN03, SUM4, z3, CA9);
  FA7: Full_Add port map(AN13, SUM5, CA9, z4, CA10);
  FA8: Full_Add port map(AN23, SUM6, CA10, z5, CA11);
  FA9: Full_Add port map(AN33, CA8, CA11, z6, CA12);
  HA4: HalfAdd port map('1', CA12, z7, z8);
  AN00 <= a0 AND b0;
  AN10 <= a1 AND b0;
  AN20 <= a2 AND b0;
  AN30 <= a3 NAND b0;
  AN01 <= a0 AND b1;
  AN11 <= a1 AND b1;
  AN21 <= a2 AND b1;
  AN31 <= a3 NAND b1;
  AN02 <= a0 AND b2;
  AN12 <= a1 AND b2;
  AN22 <= a2 AND b2;
  AN32 <= a3 NAND b2;
  AN03 <= a0 NAND b3;
  AN13 <= a1 NAND b3;
  AN23 <= a2 NAND b3;
  AN33 <= a3 AND b3;
end logic;
