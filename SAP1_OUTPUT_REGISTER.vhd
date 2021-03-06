-- DESCRIPTION: SAP-1 OUTPUT REGISTER
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_OUTPUT_REGISTER is
    port (
        input       : in std_logic_vector(7 downto 0);
        clk         : in std_logic;
        clr         : in std_logic;
        Lo          : in std_logic;
        output      : out std_logic_vector(7 downto 0)
    );
end SAP1_OUTPUT_REGISTER;

architecture behv of SAP1_OUTPUT_REGISTER is
begin
    C22 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => output(7),
        p4_q2       => output(6),
        p5_q3       => output(5),
        p6_q4       => output(4),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => Lo,
        p10_g2n     => Lo,
        p11_d4      => input(4),
        p12_d3      => input(5),
        p13_d2      => input(6),
        p14_d1      => input(7),
        p15_clr     => clr -- * Not in original design, should be: '0'
        -- PIN 16 is VCC
    );
    
    C23 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => output(3),
        p4_q2       => output(2),
        p5_q3       => output(1),
        p6_q4       => output(0),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => Lo,
        p10_g2n     => Lo,
        p11_d4      => input(0),
        p12_d3      => input(1),
        p13_d2      => input(2),
        p14_d1      => input(3),
        p15_clr     => clr -- * Not in original design, should be: '0'
        -- PIN 16 is VCC
    );

end behv;