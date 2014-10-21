library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_2TO1_MULTIPLEXER is
    port (
        sel         : in std_logic;
        input_a     : in std_logic_vector(3 downto 0);
        input_b     : in std_logic_vector(3 downto 0);
        output      : out std_logic_vector(3 downto 0)
    );
end SAP1_2TO1_MULTIPLEXER;

architecture behv of SAP1_2TO1_MULTIPLEXER is
begin
    C5 : IC74157
    port map (
        p1_sel      => sel,
        p2_a1       => input_a(0),
        p3_b1       => input_b(0),
        p4_y1       => output(0),
        p5_a2       => input_a(1),
        p6_b2       => input_b(1),
        p7_y2       => output(1),
        -- PIN 8 is GND
        p9_y3       => output(2),
        p10_b3      => input_b(2),
        p11_a3      => input_a(2),
        p12_y4      => output(3),
        p13_b4      => input_b(3),
        p14_a4      => input_a(3),
        p15_g       => '0'
        -- PIN 16 is VCC
    );
end behv;