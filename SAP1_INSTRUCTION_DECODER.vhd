-- DESCRIPTION: SAP-1 INSTRUCTION DECODER
-- AUTHOR: Jonathan Primeau

library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_INSTRUCTION_DECODER is
    port (
        i           : in std_logic_vector(3 downto 0);
        iLDA        : out std_logic;
        iADD        : out std_logic;
        iSUB        : out std_logic;
        iOUT        : out std_logic;
        iHLT        : out std_logic
    );
end SAP1_INSTRUCTION_DECODER;

architecture behv of SAP1_INSTRUCTION_DECODER is
    signal i_inv : std_logic_vector(3 downto 0) := (others => '0');
    signal i_dec : std_logic_vector(3 downto 0) := (others => '0');
begin
    C31 : IC7404
    port map (
        p1_1a       => i(3),
        p2_1y       => i_inv(3),
        p3_2a       => i(2),
        p4_2y       => i_inv(2),
        p5_3a       => i(1),
        p6_3y       => i_inv(1),
        -- PIN 7 is GND
        p8_4y       => i_inv(0),
        p9_4a       => i(0),
        p10_5y      => open, -- unused
        p11_5a      => '0',  -- unused
        p12_6y      => open, -- unused
        p13_6a      => '0'   -- unused
        -- PIN 14 is VCC
    );

    C32 : IC7420
    port map (
        p1_a1       => i_inv(3),
        p2_b1       => i_inv(2),
        -- PIN 3 is NC
        p4_c1       => i_inv(1),
        p5_d1       => i_inv(0),
        p6_y1       => i_dec(0),
        -- PIN 7 is GND
        p8_y2       => i_dec(1),
        p9_a2       => i_inv(3),
        p10_b2      => i_inv(2),
        -- PIN 11 is NC
        p12_c2      => i_inv(1),
        p13_d2      => i(0)
        -- PIN 14 is VCC
    );
    
    C33 : IC7420
    port map (
        p1_a1       => i_inv(3),
        p2_b1       => i_inv(2),
        -- PIN 3 is NC
        p4_c1       => i(1),
        p5_d1       => i_inv(0),
        p6_y1       => i_dec(2),
        -- PIN 7 is GND
        p8_y2       => i_dec(3),
        p9_a2       => i(3),
        p10_b2      => i(2),
        -- PIN 11 is NC
        p12_c2      => i(1),
        p13_d2      => i_inv(0)
        -- PIN 14 is VCC
    );
    
    C34 : IC7420
    port map (
        p1_a1       => i(3),
        p2_b1       => i(2),
        -- PIN 3 is NC
        p4_c1       => i(1),
        p5_d1       => i(0),
        p6_y1       => iHLT,
        -- PIN 7 is GND
        p8_y2       => open, -- unused
        p9_a2       => '0',  -- unused
        p10_b2      => '0',  -- unused
        -- PIN 11 is NC
        p12_c2      => '0',  -- unused
        p13_d2      => '0'   -- unused
        -- PIN 14 is VCC
    );
    
    C35 : IC7404
    port map (
        p1_1a       => i_dec(0),
        p2_1y       => iLDA,
        p3_2a       => i_dec(1),
        p4_2y       => iADD,
        p5_3a       => i_dec(2),
        p6_3y       => iSUB,
        -- PIN 7 is GND
        p8_4y       => iOUT,
        p9_4a       => i_dec(3),
        p10_5y      => open, -- unused
        p11_5a      => '0',  -- unused
        p12_6y      => open, -- unused
        p13_6a      => '0'   -- unused
        -- PIN 14 is VCC
    );
end behv;