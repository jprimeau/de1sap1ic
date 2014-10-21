library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_INSTRUCTION_REGISTER is
    port (
        input       : in std_logic_vector(7 downto 0);
        clk         : in std_logic;
        clr         : in std_logic;
        Li          : in std_logic;
        Ei          : in std_logic;
        out_inst    : out std_logic_vector(3 downto 0);
        out_bus     : out std_logic_vector(3 downto 0)
    );
end SAP1_INSTRUCTION_REGISTER;

architecture behv of SAP1_INSTRUCTION_REGISTER is
begin
    C8 : IC74173
    port map (
        p1_m        => '0',
        p2_n        => '0',
        p3_q1       => out_inst(3),
        p4_q2       => out_inst(2),
        p5_q3       => out_inst(1),
        p6_q4       => out_inst(0),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => Li,
        p10_g2n     => Li,
        p11_d4      => input(4),
        p12_d3      => input(5),
        p13_d2      => input(6),
        p14_d1      => input(7),
        p15_clr     => clr
        -- PIN 16 is VCC
    );
    
    C9 : IC74173
    port map (
        p1_m        => Ei,
        p2_n        => Ei,
        p3_q1       => out_bus(3),
        p4_q2       => out_bus(2),
        p5_q3       => out_bus(1),
        p6_q4       => out_bus(0),
        p7_clk      => clk,
        -- PIN 8 is GND
        p9_g1n      => Li,
        p10_g2n     => Li,
        p11_d4      => input(0),
        p12_d3      => input(1),
        p13_d2      => input(2),
        p14_d1      => input(3),
        p15_clr     => '0'
        -- PIN 16 is VCC
    );
end behv;