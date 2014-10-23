-- DESCRIPTION: 74107 Dual J-K Flip-Flop with Clear
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;
    
entity IC74107 is
    port (
        p1_1j       : in std_logic;
        p2_1qn      : out std_logic;
        p3_1q       : out std_logic;
        p4_1k       : in std_logic;
        p5_2q       : out std_logic;
        p6_2qn      : out std_logic;
        -- PIN 7 is GND
        p8_2j       : in std_logic;
        p9_2clk     : in std_logic;
        p10_2clrn   : in std_logic;
        p11_2k      : in std_logic;
        p12_1clk    : in std_logic;
        p13_1clrn   : in std_logic
        -- PIN 14 is VCC
    );
end IC74107;

architecture behv of IC74107 is
    signal i1q : std_logic := '0';
    signal i2q : std_logic := '0';
begin
    JKFF1 : JK_FF_VHDL
    port map (
        j       => p1_1j,
        k       => p4_1k,
        clrn    => p13_1clrn,
        clk     => p12_1clk,
        q       => i1q
    );
    p3_1q <= i1q;
    p2_1qn <= not i1q;
    
    JKFF2 : JK_FF_VHDL
    port map (
        j       => p8_2j,
        k       => p11_2k,
        clrn    => p10_2clrn,
        clk     => p9_2clk,
        q       => i2q
    );
    p5_2q <= i2q;
    p6_2qn <= not i2q;
end behv;