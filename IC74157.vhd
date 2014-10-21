-- DESCRIPTION: 74157 Quad 2/1 Data Selector
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    
entity IC74157 is
    port (
        p1_sel      : in std_logic;
        p2_a1       : in std_logic;
        p3_b1       : in std_logic;
        p4_y1       : out std_logic;
        p5_a2       : in std_logic;
        p6_b2       : in std_logic;
        p7_y2       : out std_logic;
        -- PIN 8 is GND
        p9_y3       : out std_logic;
        p10_b3      : in std_logic;
        p11_a3      : in std_logic;
        p12_y4      : out std_logic;
        p13_b4      : in std_logic;
        p14_a4      : in std_logic;
        p15_g       : in std_logic
        -- PIN 16 is VCC
    );
end IC74157;

architecture behv of IC74157 is
    signal iy1, iy2, iy3, iy4 : std_logic := '0';
begin
    process (p15_g, p1_sel, p2_a1, p5_a2, p11_a3, p14_a4,
            p3_b1, p6_b2, p10_b3, p13_b4)
    begin
        if p15_g = '1' then
            iy1 <= '0';
            iy2 <= '0';
            iy3 <= '0';
            iy4 <= '0';
        else
            if p1_sel = '0' then
                iy1 <= p2_a1;
                iy2 <= p5_a2;
                iy3 <= p11_a3;
                iy4 <= p14_a4;
            else
                iy1 <= p3_b1;
                iy2 <= p6_b2;
                iy3 <= p10_b3;
                iy4 <= p13_b4;
            end if;
        end if;
    end process;
    p4_y1 <= iy1;
    p7_y2 <= iy2;
    p9_y3 <= iy3;
    p12_y4 <= iy4;
end behv;