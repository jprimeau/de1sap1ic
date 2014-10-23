-- DESCRIPTION: SAP-1 PROGRAM COUNTER
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_PROGRAM_COUNTER is
    port (
        clkn        : in std_logic;
        clrn        : in std_logic;
        cp          : in std_logic;
        ep          : in std_logic;
        q           : out std_logic_vector(3 downto 0)
    );
end SAP1_PROGRAM_COUNTER;

architecture behv of SAP1_PROGRAM_COUNTER is
    signal c1a_q    : std_logic := '0';
    signal c1b_q    : std_logic := '0';
    signal c2a_q    : std_logic := '0';
    signal c2b_q    : std_logic := '0';
begin
    C1 : IC74107
    port map (
        p1_1j       => cp,
        p2_1qn      => open,
        p3_1q       => c1a_q,
        p4_1k       => cp,
        p5_2q       => c1b_q,
        p6_2qn      => open,
        -- PIN 7 is GND
        p8_2j       => cp,
        p9_2clk     => c2a_q,
        p10_2clrn   => clrn,
        p11_2k      => cp,
        p12_1clk    => c1b_q,
        p13_1clrn   => clrn
        -- PIN 14 is VCC
    );
    
    C2 : IC74107
    port map (
        p1_1j       => cp,
        p2_1qn      => open,
        p3_1q       => c2a_q,
        p4_1k       => cp,
        p5_2q       => c2b_q,
        p6_2qn      => open,
        -- PIN 7 is GND
        p8_2j       => cp,
        p9_2clk     => clkn,
        p10_2clrn   => clrn,
        p11_2k      => cp,
        p12_1clk    => c2b_q,
        p13_1clrn   => clrn
        -- PIN 14 is VCC
    );
    
    C3 : IC74126
    port map (
        p1_c1       => ep,
        p2_a1       => c1a_q,
        p3_y1       => q(3),
        p4_c2       => ep,
        p5_a2       => c1b_q,
        p6_y2       => q(2),
        -- PIN 7 is GND
        p8_y3       => q(1),
        p9_a3       => c2a_q,
        p10_c3      => ep,
        p11_y4      => q(0),
        p12_a4      => c2b_q,
        p13_c4      => ep
        -- PIN 14 is VCC
    );
end behv;