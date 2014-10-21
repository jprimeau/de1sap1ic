library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_B_REGISTER is
    port (
        input       : in std_logic_vector(7 downto 0);
        clk         : in std_logic;
        Lb          : in std_logic;
        output      : out std_logic_vector(7 downto 0)
    );
end SAP1_B_REGISTER;

architecture behv of SAP1_B_REGISTER is
begin
    C20 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => output(7),
        p4_q2       => output(6),
        p5_q3       => output(5),
        p6_q4       => output(4),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => Lb,
        p10_g2n     => Lb,
        p11_d4      => input(4),
        p12_d3      => input(5),
        p13_d2      => input(6),
        p14_d1      => input(7),
        p15_clr     => '0'
        -- PIN 16 is VCC
    );
    
    C21 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => output(3),
        p4_q2       => output(2),
        p5_q3       => output(1),
        p6_q4       => output(0),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => Lb,
        p10_g2n     => Lb,
        p11_d4      => input(0),
        p12_d3      => input(1),
        p13_d2      => input(2),
        p14_d1      => input(3),
        p15_clr     => '0'
        -- PIN 16 is VCC
    );

end behv;