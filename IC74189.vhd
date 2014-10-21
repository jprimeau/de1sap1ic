-- DESCRIPTION: 74189 64-bit (16x4) RAM with inverting 3-state outputs
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    
entity IC74189 is
    port (
        p1_a0       : in std_logic;
        p2_me       : in std_logic;
        p3_we       : in std_logic;
        p4_d1       : in std_logic;
        p5_s1       : out std_logic;
        p6_d2       : in std_logic;
        p7_s2       : out std_logic;
        -- PIN 8 is GND
        p9_s3       : out std_logic;
        p10_d3      : in std_logic;
        p11_s4      : out std_logic;
        p12_d4      : in std_logic;
        p13_a3      : in std_logic;
        p14_a2      : in std_logic;
        p15_a1      : in std_logic
        -- PIN 16 is VCC
    );
end IC74189;

architecture behv of IC74189 is
    type t_ram is array (0 to 15) of std_logic_vector(3 downto 0);
    signal ram  : t_ram := (
        x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0",
        x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0"
    );
    signal addr : integer := 0;
    signal is1, is2, is3, is4 : std_logic := '0';
begin
    addr <= conv_integer(p1_a0 & p15_a1 & p14_a2 & p13_a3);
    process (p2_me, p3_we, addr)
    begin
        if p2_me = '0' and p3_we = '0' then
            is1 <= 'Z';
            is2 <= 'Z';
            is3 <= 'Z';
            is4 <= 'Z';
            ram(addr)(3) <= p4_d1;
            ram(addr)(2) <= p6_d2;
            ram(addr)(1) <= p10_d3;
            ram(addr)(0) <= p12_d4;
        elsif p2_me = '0' and p3_we = '1' then
            is1 <= ram(addr)(3);
            is2 <= ram(addr)(2);
            is3 <= ram(addr)(1);
            is4 <= ram(addr)(0);
        elsif p2_me = '1' then
            is1 <= 'Z';
            is2 <= 'Z';
            is3 <= 'Z';
            is4 <= 'Z';
        end if;
    end process;
    p5_s1 <= is1;
    p7_s2 <= is2;
    p9_s3 <= is3;
    p11_s4 <= is4;
end behv;