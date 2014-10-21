-- DESCRIPTION: 7400 Quad 2-input NAND gates
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
entity IC7400 is
    port (
        p1_a1       : in std_logic;
        p2_b1       : in std_logic;
        p3_y1       : out std_logic;
        p4_a2       : in std_logic;
        p5_b2       : in std_logic;
        p6_y2       : out std_logic;
        -- PIN 7 is GND
        p8_y3       : out std_logic;
        p9_a3       : in std_logic;
        p10_b3      : in std_logic;
        p11_y4      : out std_logic;
        p12_a4      : in std_logic;
        p13_b4      : in std_logic
        -- PIN 14 is VCC
    );
end IC7400;

architecture behv of IC7400 is
begin
    p3_y1  <= p1_a1  nand p2_b1;
    p6_y2  <= p4_a2  nand p5_b2;
    p8_y3  <= p9_a3  nand p10_b3;
    p11_y4 <= p12_a4 nand p13_b4;
end behv;