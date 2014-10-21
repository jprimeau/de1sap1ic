library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    
--use work.all;

entity SAP1_16X8RAM is
    port (
        clock       : in std_logic;
        addr        : in std_logic_vector(3 downto 0);
        data        : in std_logic_vector(7 downto 0);
        me          : in std_logic;
        we          : in std_logic;
        sense       : out std_logic_vector(7 downto 0)
    );
end SAP1_16X8RAM;

architecture behv of SAP1_16X8RAM is
    type t_ram is array (0 to 15) of std_logic_vector(7 downto 0);
    signal ram : t_ram := (
        x"09", x"EF", x"1A", x"EF",  x"1B", x"2C", x"EF", x"FF",
        x"FF", x"05", x"07", x"03", x"04", x"FF", x"FF", x"FF"
    );
begin
    process (clock, me, ram, addr)
    begin
        if me = '0' then
            sense <= ram(conv_integer(addr));
        else
            sense <= (others=>'Z');
        end if;
    end process;

--    process (clock, we, data, addr)
--    begin
--        if we = '0' then
--            ram(conv_integer(addr)) <= data;
--            sense <= (others=>'Z');
--        end if;
--    end process;

--    C6 : IC74189
--    port map (
--        pX_clk  => clock,
--        p1_a0   => addr(3),
--        p2_me   => me,
--        p3_we   => we,
--        p4_d1   => data(7),
--        p5_s1   => sense(7),
--        p6_d2   => data(6),
--        p7_s2   => sense(6),
--        -- PIN 8 is GND
--        p9_s3   => sense(5),
--        p10_d3  => data(5),
--        p11_s4  => sense(4),
--        p12_d4  => data(4),
--        p13_a3  => addr(0),
--        p14_a2  => addr(1),
--        p15_a1  => addr(2)
--        -- PIN 16 is VCC
--    );
--    
--    C7 : IC74189
--    port map (
--        pX_clk  => clock,
--        p1_a0   => addr(3),
--        p2_me   => me,
--        p3_we   => we,
--        p4_d1   => data(3),
--        p5_s1   => sense(3),
--        p6_d2   => data(2),
--        p7_s2   => sense(2),
--        -- PIN 8 is GND
--        p9_s3   => sense(1),
--        p10_d3  => data(1),
--        p11_s4  => sense(0),
--        p12_d4  => data(0),
--        p13_a3  => addr(0),
--        p14_a2  => addr(1),
--        p15_a1  => addr(2)
--        -- PIN 16 is VCC
--    );
end behv;