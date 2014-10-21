-- DESCRIPTION: 7404 Hex inverter
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
entity IC7404 is
    port (
        p1_1a       : in std_logic;
        p2_1y       : out std_logic;
        p3_2a       : in std_logic;
        p4_2y       : out std_logic;
        p5_3a       : in std_logic;
        p6_3y       : out std_logic;
        -- PIN 7 is GND
        p8_4y       : out std_logic;
        p9_4a       : in std_logic;
        p10_5y      : out std_logic;
        p11_5a      : in std_logic;
        p12_6y      : out std_logic;
        p13_6a      : in std_logic
        -- PIN 14 is VCC
    );
end IC7404;

architecture behv of IC7404 is
begin
    p2_1y  <= not p1_1a;
    p4_2y  <= not p3_2a;
    p6_3y  <= not p5_3a;
    p8_4y  <= not p9_4a;
    p10_5y <= not p11_5a;
    p12_6y <= not p13_6a;
end behv;