-- DESCRIPTION: 74126 Quad Bus Buffer Tri-State
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;
    
entity IC74126 is
    port (
        p1_c1       : in std_logic;
        p2_a1       : in std_logic;
        p3_y1       : out std_logic;
        p4_c2       : in std_logic;
        p5_a2       : in std_logic;
        p6_y2       : out std_logic;
        -- PIN 7 is GND
        p8_y3       : out std_logic;
        p9_a3       : in std_logic;
        p10_c3      : in std_logic;
        p11_y4      : out std_logic;
        p12_a4      : in std_logic;
        p13_c4      : in std_logic
        -- PIN 14 is VCC
    );
end IC74126;

architecture behv of IC74126 is
    signal i1q : std_logic := '0';
    signal i2q : std_logic := '0';
    signal i3q : std_logic := '0';
    signal i4q : std_logic := '0';
begin

    TRIBUF1 : TRIBUF_VHDL
    port map (
        d       => p2_a1,
        ena     => p1_c1,
        q       => i1q
    );
    p3_y1 <= i1q;

    TRIBUF2 : TRIBUF_VHDL
    port map (
        d       => p5_a2,
        ena     => p4_c2,
        q       => i2q
    );
    p6_y2 <= i2q;
    
    TRIBUF3 : TRIBUF_VHDL
    port map (
        d       => p9_a3,
        ena     => p10_c3,
        q       => i3q
    );
    p8_y3 <= i3q;
    
    TRIBUF4 : TRIBUF_VHDL
    port map (
        d       => p12_a4,
        ena     => p13_c4,
        q       => i4q
    );
    p11_y4 <= i4q;
    
end behv;