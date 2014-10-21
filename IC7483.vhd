-- DESCRIPTION: 7483 4-bit Binary Adder with Fast Carry
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
entity IC7483 is
    port (
        p1_a4       : in std_logic;
        p2_s3       : out std_logic;
        p3_a3       : in std_logic;
        p4_b3       : in std_logic;
        -- PIN 5 is GND
        p6_s2       : out std_logic;
        p7_b2       : in std_logic;
        p8_a2       : in std_logic;
        p9_s1       : out std_logic;
        p10_a1      : in std_logic;
        p11_b1      : in std_logic;
        -- PIN 12 is VCC
        p13_c0      : in std_logic;
        p14_c4      : out std_logic;
        p15_s4      : out std_logic;
        p16_b4      : in std_logic
    );
end IC7483;

architecture behv of IC7483 is
    signal c1, c2, c3 : std_logic;
begin
    c1     <= (p10_a1 and p11_b1) or (p10_a1 and p13_c0) or (p11_b1 and p13_c0);
    c2     <= (p8_a2  and p7_b2)  or (p8_a2  and c1)     or (p7_b2 and c1);
    c3     <= (p3_a3  and p4_b3)  or (p3_a3  and c2)     or (p4_b3  and c2);
    p14_c4 <= (p1_a4  and p16_b4) or (p1_a4  and c3)     or (p16_b4 and c3);
    p9_s1  <= p10_a1 xor p11_b1 xor p13_c0;
    p6_s2  <= p8_a2  xor p7_b2  xor c1;
    p2_s3  <= p3_a3  xor p4_b3  xor c2;
    p15_s4 <= p1_a4  xor p16_b4 xor c3;
end behv;