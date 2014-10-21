library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_ACCUMULATOR is
    port (
        input       : in std_logic_vector(7 downto 0);
        clk         : in std_logic;
        La          : in std_logic;
        Ea          : in std_logic;
        out_add_sub : out std_logic_vector(7 downto 0);
        out_bus     : out std_logic_vector(7 downto 0)
    );
end SAP1_ACCUMULATOR;

architecture behv of SAP1_ACCUMULATOR is
    signal iq       : std_logic_vector(7 downto 0) := x"00";
begin
    out_add_sub <= iq;

    C10 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => iq(7),
        p4_q2       => iq(6),
        p5_q3       => iq(5),
        p6_q4       => iq(4),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => La,
        p10_g2n     => La,
        p11_d4      => input(4),
        p12_d3      => input(5),
        p13_d2      => input(6),
        p14_d1      => input(7),
        p15_clr     => '0'
        -- PIN 16 is VCC
    );
    
    C11 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => iq(3),
        p4_q2       => iq(2),
        p5_q3       => iq(1),
        p6_q4       => iq(0),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => La,
        p10_g2n     => La,
        p11_d4      => input(0),
        p12_d3      => input(1),
        p13_d2      => input(2),
        p14_d1      => input(3),
        p15_clr     => '0'
        -- PIN 16 is VCC
    );
    
    C12 : IC74126
    port map (
        p1_c1       => Ea,
        p2_a1       => iq(0),
        p3_y1       => out_bus(0),
        p4_c2       => Ea,
        p5_a2       => iq(1),
        p6_y2       => out_bus(1),
        -- PIN 7 is GND
        p8_y3       => out_bus(2),
        p9_a3       => iq(2),
        p10_c3      => Ea,
        p11_y4      => out_bus(3),
        p12_a4      => iq(3),
        p13_c4      => Ea
        -- PIN 14 is VCC
    );
    
    C13 : IC74126
    port map (
        p1_c1       => Ea,
        p2_a1       => iq(4),
        p3_y1       => out_bus(4),
        p4_c2       => Ea,
        p5_a2       => iq(5),
        p6_y2       => out_bus(5),
        -- PIN 7 is GND
        p8_y3       => out_bus(6),
        p9_a3       => iq(6),
        p10_c3      => Ea,
        p11_y4      => out_bus(7),
        p12_a4      => iq(7),
        p13_c4      => Ea
        -- PIN 14 is VCC
    );
end behv;