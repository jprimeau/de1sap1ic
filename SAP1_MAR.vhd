library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_MAR is
    port (
        input       : in std_logic_vector(3 downto 0);
        clk         : in std_logic;
        Lm          : in std_logic;
        output      : out std_logic_vector(3 downto 0)
    );
end SAP1_MAR;

architecture behv of SAP1_MAR is
begin
    C4 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => output(3),
        p4_q2       => output(2),
        p5_q3       => output(1),
        p6_q4       => output(0),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => Lm,
        p10_g2n     => Lm,
        p11_d4      => input(0),
        p12_d3      => input(1),
        p13_d2      => input(2),
        p14_d1      => input(3),
        p15_clr     => '0'
        -- PIN 16 is VCC
    );
end behv;