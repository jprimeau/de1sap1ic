-- DESCRIPTION: 74173 4-bit D-Type registers with 3-state outputs
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
entity IC74173 is
    port (
        p1_m        : in std_logic;
        p2_n        : in std_logic;
        p3_q1       : out std_logic;
        p4_q2       : out std_logic;
        p5_q3       : out std_logic;
        p6_q4       : out std_logic;
        p7_clk      : in std_logic;
        -- PIN 8 is GND
        p9_g1n      : in std_logic;
        p10_g2n     : in std_logic;
        p11_d4      : in std_logic;
        p12_d3      : in std_logic;
        p13_d2      : in std_logic;
        p14_d1      : in std_logic;
        p15_clr     : in std_logic
        -- PIN 16 is VCC
    );
end IC74173;

architecture behv of IC74173 is
    signal iq1, iq2, iq3, iq4 : std_logic := '0';
begin
    process (p7_clk, p15_clr, p1_m, p2_n,
             iq1, iq2, iq3, iq4)
    begin
        if p15_clr = '1' then
            iq1 <= '0';
            iq2 <= '0';
            iq3 <= '0';
            iq4 <= '0';
        elsif p7_clk'event and p7_clk = '1' then
            if p9_g1n = '0' and p10_g2n = '0' then
                iq1 <= p14_d1;
                iq2 <= p13_d2;
                iq3 <= p12_d3;
                iq4 <= p11_d4;
            end if;
        end if;
        if p1_m = '0' and p2_n = '0' then
            p3_q1 <= iq1;
            p4_q2 <= iq2;
            p5_q3 <= iq3;
            p6_q4 <= iq4;
        else
            p3_q1 <= 'Z';
            p4_q2 <= 'Z';
            p5_q3 <= 'Z';
            p6_q4 <= 'Z';
        end if;
    end process;
end behv;