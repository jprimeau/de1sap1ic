-- DESCRIPTION: 7410 Triple 3-Input NAND Gates
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
entity IC7410 is
    port (
        p1_a1       : in std_logic;
        p2_b1       : in std_logic;
        p3_a2       : in std_logic;
        p4_b2       : in std_logic;
        p5_c2       : in std_logic;
        p6_y2       : out std_logic;
        -- PIN 7 is GND
        p8_y3       : out std_logic;
        p9_a3       : in std_logic;
        p10_b3      : in std_logic;
        p11_c3      : in std_logic;
        p12_y1      : out std_logic;
        p13_c1      : in std_logic
        -- PIN 14 is VCC
    );
end IC7410;

architecture behv of IC7410 is
begin
    p12_y1 <= not(p1_a1 and p2_b1  and p13_c1);
    p6_y2  <= not(p3_a2 and p4_b2  and p5_c2);
    p8_y3  <= not(p9_a3 and p10_b3 and p11_c3);
end behv;