library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_PANEL is
    port (
        start          : in std_logic;
        step           : in std_logic;
        manual         : in std_logic;
        clock          : in std_logic;
        halt           : in std_logic;
        clr            : out std_logic;
        clrn           : out std_logic;
        clk            : out std_logic;
        clkn           : out std_logic
    );
end SAP1_PANEL;

architecture behv of SAP1_PANEL is
    signal c24y1, c24y2, c24y3, c24y4 : std_logic := '0';
    signal c25y1 : std_logic := '0';
    signal c26y1, c26y2, c26y3, c26y4 : std_logic := '0';
    signal c27y1, c27y2, c27y3 : std_logic := '0';
    signal c29q : std_logic := '0';
    signal iclrn : std_logic := '0';
begin
    iclrn  <= c24y1;
    clrn <= iclrn;
    clr <= c24y2;
    clk  <= c27y2;
    clkn <= c27y3;
    
    C24 : IC7400 -- CLEAR/START & SINGLE STEP
    port map (
        p1_a1       => not start,
        p2_b1       => c24y2,
        p3_y1       => c24y1,
        p4_a2       => c24y1,
        p5_b2       => start,
        p6_y2       => c24y2,
        -- PIN 7 is GND
        p8_y3       => c24y3,
        p9_a3       => step,
        p10_b3      => c24y4,
        p11_y4      => c24y4,
        p12_a4      => c24y3,
        p13_b4      => not step
        -- PIN 14 is VCC
    );
    
    C25 : IC7410
    port map (
        p1_a1       => halt,
        p2_b1       => c24y4,
        p3_a2       => '0',  -- unused
        p4_b2       => '0',  -- unused
        p5_c2       => '0',  -- unused
        p6_y2       => open, -- unused
        -- PIN 7 is GND
        p8_y3       => open, -- unused
        p9_a3       => '0',  -- unused
        p10_b3      => '0',  -- unused
        p11_c3      => '0',  -- unused
        p12_y1      => c25y1,
        p13_c1      => c26y1
        -- PIN 14 is VCC
    );
    
    C26 : IC7400 -- MANUAL/AUTO
    port map (
        p1_a1       => not manual,
        p2_b1       => c26y2,
        p3_y1       => c26y1,
        p4_a2       => c26y1,
        p5_b2       => manual,
        p6_y2       => c26y2,
        -- PIN 7 is GND
        p8_y3       => c26y3,
        p9_a3       => c26y2,
        p10_b3      => c29q,
        p11_y4      => c26y4,
        p12_a4      => c25y1,
        p13_b4      => c26y3
        -- PIN 14 is VCC
    );
    
    C27 : IC7404 -- CLOCK BUFFERS
    port map (
        p1_1a       => c26y4,
        p2_1y       => c27y1,
        p3_2a       => c27y1,
        p4_2y       => c27y2,
        p5_3a       => c26y4,
        p6_3y       => c27y3,
        -- PIN 7 is GND
        p8_4y       => open, -- unused
        p9_4a       => '0',  -- unused
        p10_5y      => open, -- unused
        p11_5a      => '0',  -- unused
        p12_6y      => open, -- unused
        p13_6a      => '0'   -- unused
        -- PIN 14 is VCC
    );
    
    C29 : IC74107
    port map (
        p1_1j       => halt,
        p2_1qn      => open, -- unused
        p3_1q       => c29q,
        p4_1k       => halt,
        p5_2q       => open, -- unused
        p6_2qn      => open, -- unused
        -- PIN 7 is GND
        p8_2j       => '0',  -- unused
        p9_2clk     => '0',  -- unused
        p10_2clrn   => '0',  -- unused
        p11_2k      => '0',  -- unused
        p12_1clk    => clock,
        p13_1clrn   => iclrn
        -- PIN 14 is VCC
    );
end behv;