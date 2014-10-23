-- DESCRIPTION: SAP-1 ADDER / SUBTRACTOR
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_ADDER_SUBTRACTOR is
    port (
        input_a     : in std_logic_vector(7 downto 0);
        input_b     : in std_logic_vector(7 downto 0);
        Su          : in std_logic;
        Eu          : in std_logic;
        output      : out std_logic_vector(7 downto 0)
    );
end SAP1_ADDER_SUBTRACTOR;

architecture behv of SAP1_ADDER_SUBTRACTOR is
    signal add_sub_in, add_sub_out : std_logic_vector(7 downto 0);
    signal cout : std_logic := '0';
begin
    C14 : IC7486
    port map (
        p1_a1       => input_b(7),
        p2_b1       => Su,
        p3_y1       => add_sub_in(7),
        p4_a2       => input_b(6),
        p5_b2       => Su,
        p6_y2       => add_sub_in(6),
        -- PIN 7 is GND
        p8_y3       => add_sub_in(5),
        p9_a3       => input_b(5),
        p10_b3      => Su,
        p11_y4      => add_sub_in(4),
        p12_a4      => input_b(4),
        p13_b4      => Su
        -- PIN 14 is VCC
    );
    
    C15 : IC7486
    port map (
        p1_a1       => input_b(3),
        p2_b1       => Su,
        p3_y1       => add_sub_in(3),
        p4_a2       => input_b(2),
        p5_b2       => Su,
        p6_y2       => add_sub_in(2),
        -- PIN 7 is GND
        p8_y3       => add_sub_in(1),
        p9_a3       => input_b(1),
        p10_b3      => Su,
        p11_y4      => add_sub_in(0),
        p12_a4      => input_b(0),
        p13_b4      => Su
        -- PIN 14 is VCC
    );
    
    C16 : IC7483
    port map (
        p1_a4       => input_a(7),
        p2_s3       => add_sub_out(6),
        p3_a3       => input_a(6),
        p4_b3       => add_sub_in(6),
        -- PIN 5 is GND
        p6_s2       => add_sub_out(5),
        p7_b2       => add_sub_in(5),
        p8_a2       => input_a(5),
        p9_s1       => add_sub_out(4),
        p10_a1      => input_a(4),
        p11_b1      => add_sub_in(4),
        -- PIN 12 is VCC
        p13_c0      => cout,
        p14_c4      => open,
        p15_s4      => add_sub_out(7),
        p16_b4      => add_sub_in(7)
    );
    
    C17 : IC7483
    port map (
        p1_a4       => input_a(3),
        p2_s3       => add_sub_out(2),
        p3_a3       => input_a(2),
        p4_b3       => add_sub_in(2),
        -- PIN 5 is GND
        p6_s2       => add_sub_out(1),
        p7_b2       => add_sub_in(1),
        p8_a2       => input_a(1),
        p9_s1       => add_sub_out(0),
        p10_a1      => input_a(0),
        p11_b1      => add_sub_in(0),
        -- PIN 12 is VCC
        p13_c0      => Su,
        p14_c4      => cout,
        p15_s4      => add_sub_out(3),
        p16_b4      => add_sub_in(3)
    );
    
    C18 : IC74126
    port map (
        p1_c1       => Eu,
        p2_a1       => add_sub_out(7),
        p3_y1       => output(7),
        p4_c2       => Eu,
        p5_a2       => add_sub_out(6),
        p6_y2       => output(6),
        -- PIN 7 is GND
        p8_y3       => output(5),
        p9_a3       => add_sub_out(5),
        p10_c3      => Eu,
        p11_y4      => output(4),
        p12_a4      => add_sub_out(4),
        p13_c4      => Eu
        -- PIN 14 is VCC
    );
    
    C19 : IC74126
    port map (
        p1_c1       => Eu,
        p2_a1       => add_sub_out(3),
        p3_y1       => output(3),
        p4_c2       => Eu,
        p5_a2       => add_sub_out(2),
        p6_y2       => output(2),
        -- PIN 7 is GND
        p8_y3       => output(1),
        p9_a3       => add_sub_out(1),
        p10_c3      => Eu,
        p11_y4      => output(0),
        p12_a4      => add_sub_out(0),
        p13_c4      => Eu
        -- PIN 14 is VCC
    );

end behv;