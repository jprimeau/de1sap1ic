-- DESCRIPTION: 7410 Dual 4-Input NAND Gates
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
entity IC7420 is
    port (
        p1_a1       : in std_logic;
        p2_b1       : in std_logic;
        -- PIN 3 is NC
        p4_c1       : in std_logic;
        p5_d1       : in std_logic;
        p6_y1       : out std_logic;
        -- PIN 7 is GND
        p8_y2       : out std_logic;
        p9_a2       : in std_logic;
        p10_b2      : in std_logic;
        -- PIN 11 is NC
        p12_c2      : in std_logic;
        p13_d2      : in std_logic
        -- PIN 14 is VCC
    );
end IC7420;

architecture behv of IC7420 is
begin
    p6_y1 <= not(p1_a1 and p2_b1  and p4_c1  and p5_d1);
    p8_y2 <= not(p9_a2 and p10_b2 and p12_c2 and p13_d2);
end behv;