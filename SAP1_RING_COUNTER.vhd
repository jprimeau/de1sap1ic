-- DESCRIPTION: SAP-1 RING COUNTER
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_RING_COUNTER is
    port (
        clk         : in std_logic;
        clrn        : in std_logic;
        T1          : out std_logic;
        T2          : out std_logic;
        T3          : out std_logic;
        T4          : out std_logic;
        T5          : out std_logic;
        T6          : out std_logic
    );
end SAP1_RING_COUNTER;

architecture behv of SAP1_RING_COUNTER is
    signal c36aq, c36aqn : std_logic := '0';
    signal c36bq, c36bqn : std_logic := '0';
    signal c37aq, c37aqn : std_logic := '0';
    signal c37bq, c37bqn : std_logic := '0';
    signal c38aq, c38aqn : std_logic := '0';
    signal c38bq, c38bqn : std_logic := '0';
begin
    T6 <= c36aq;
    T5 <= c36bq;
    T4 <= c37aq;
    T3 <= c37bq;
    T2 <= c38aq;
    T1 <= c38bqn;

    C36 : IC74107
    port map (
        p1_1j       => c36bq,
        p2_1qn      => c36aqn,
        p3_1q       => c36aq,
        p4_1k       => c36bqn,
        p5_2q       => c36bq,
        p6_2qn      => c36bqn,
        -- PIN 7 is GND
        p8_2j       => c37aq,
        p9_2clk     => clk,
        p10_2clrn   => clrn,
        p11_2k      => c37aqn,
        p12_1clk    => clk,
        p13_1clrn   => clrn
        -- PIN 14 is VCC
    );
    
    C37 : IC74107
    port map (
        p1_1j       => c37bq,
        p2_1qn      => c37aqn,
        p3_1q       => c37aq,
        p4_1k       => c37bqn,
        p5_2q       => c37bq,
        p6_2qn      => c37bqn,
        -- PIN 7 is GND
        p8_2j       => c38aq,
        p9_2clk     => clk,
        p10_2clrn   => clrn,
        p11_2k      => c38aqn,
        p12_1clk    => clk,
        p13_1clrn   => clrn
        -- PIN 14 is VCC
    );
    
    C38 : IC74107
    port map (
        p1_1j       => c38bqn,
        p2_1qn      => c38aqn,
        p3_1q       => c38aq,
        p4_1k       => c38bq,
        p5_2q       => c38bq,
        p6_2qn      => c38bqn,
        -- PIN 7 is GND
        p8_2j       => c36aqn,
        p9_2clk     => clk,
        p10_2clrn   => clrn,
        p11_2k      => c36aq,
        p12_1clk    => clk,
        p13_1clrn   => clrn
        -- PIN 14 is VCC
    );
end behv;