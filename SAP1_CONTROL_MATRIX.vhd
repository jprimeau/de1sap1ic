library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_CONTROL_MATRIX is
    port (
        T1          : in std_logic;
        T2          : in std_logic;
        T3          : in std_logic;
        T4          : in std_logic;
        T5          : in std_logic;
        T6          : in std_logic;
        iLDA        : in std_logic;
        iADD        : in std_logic;
        iSUB        : in std_logic;
        iOUT        : in std_logic;
        Cp          : out std_logic;
        Ep          : out std_logic;
        Lm          : out std_logic;
        CE          : out std_logic;
        Li          : out std_logic;
        Ei          : out std_logic;
        La          : out std_logic;
        Ea          : out std_logic;
        Su          : out std_logic;
        Eu          : out std_logic;
        Lb          : out std_logic;
        Lo          : out std_logic
    );
end SAP1_CONTROL_MATRIX;

architecture behv of SAP1_CONTROL_MATRIX is
    signal c39y1, c39y2, c39y3, c39y4 : std_logic := '0';
    signal c40y1, c40y2, c40y3, c40y4 : std_logic := '0';
    signal c41y1, c41y2, c41y3, c41y4 : std_logic := '0';
    signal c42y1, c42y2, c42y3, c42y4 : std_logic := '0';
    signal c43y1, c43y2, c43y3 : std_logic := '0';
    signal c44y1, c44y2 : std_logic := '0';
    signal c45y1, c45y2 : std_logic := '0';
    signal c46y1, c46y2 : std_logic := '0';
    signal c47y1, c47y2, c47y3, c47y4, c47y5, c47y6, c47y7 : std_logic := '0';
    signal c48y1, c48y2, c48y3, c48y4 : std_logic := '0';
begin
    Cp <= T2;
    Ep <= T1;
    Lm <= c47y1;
    CE <= c47y2;
    Li <= c47y3;
    Ei <= c47y4;
    La <= c47y5;
    Ea <= c47y6;
    Su <= c48y1;
    Eu <= c46y1;
    Lb <= c48y2;
    Lo <= c43y3;

    C39 : IC7400
    port map (
        p1_a1       => iLDA,
        p2_b1       => T4,
        p3_y1       => c39y1,
        p4_a2       => iADD,
        p5_b2       => T4,
        p6_y2       => c39y2,
        -- PIN 7 is GND
        p8_y3       => c39y3,
        p9_a3       => iSUB,
        p10_b3      => T4,
        p11_y4      => c39y4,
        p12_a4      => iLDA,
        p13_b4      => T5
        -- PIN 14 is VCC
    );
    
    C40 : IC7400
    port map (
        p1_a1       => iADD,
        p2_b1       => T5,
        p3_y1       => c40y1,
        p4_a2       => iSUB,
        p5_b2       => T5,
        p6_y2       => c40y2,
        -- PIN 7 is GND
        p8_y3       => c40y3,
        p9_a3       => iLDA,
        p10_b3      => T4,
        p11_y4      => c40y4,
        p12_a4      => iADD,
        p13_b4      => T4
        -- PIN 14 is VCC
    );
    
    C41 : IC7400
    port map (
        p1_a1       => iSUB,
        p2_b1       => T4,
        p3_y1       => c41y1,
        p4_a2       => iLDA,
        p5_b2       => T5,
        p6_y2       => c41y2,
        -- PIN 7 is GND
        p8_y3       => c41y3,
        p9_a3       => iADD,
        p10_b3      => T6,
        p11_y4      => c41y4,
        p12_a4      => iSUB,
        p13_b4      => T6
        -- PIN 14 is VCC
    );
    
    C42 : IC7400
    port map (
        p1_a1       => iOUT,
        p2_b1       => T4,
        p3_y1       => c42y1,
        p4_a2       => iSUB,
        p5_b2       => T6,
        p6_y2       => c42y2,
        -- PIN 7 is GND
        p8_y3       => c42y3,
        p9_a3       => iADD,
        p10_b3      => T6,
        p11_y4      => c42y4,
        p12_a4      => iSUB,
        p13_b4      => T6
        -- PIN 14 is VCC
    );
    
    C43 : IC7400
    port map (
        p1_a1       => iADD,
        p2_b1       => T5,
        p3_y1       => c43y1,
        p4_a2       => iSUB,
        p5_b2       => T5,
        p6_y2       => c43y2,
        -- PIN 7 is GND
        p8_y3       => c43y3,
        p9_a3       => iOUT,
        p10_b3      => T4,
        p11_y4      => open,
        p12_a4      => '0',
        p13_b4      => '0'
        -- PIN 14 is VCC
    );
    
    C44 : IC7420
    port map (
        p1_a1       => c48y3,
        p2_b1       => c39y1,
        -- PIN 3 is NC
        p4_c1       => c39y2,
        p5_d1       => c39y3,
        p6_y1       => c44y1,
        -- PIN 7 is GND
        p8_y2       => c44y2,
        p9_a2       => c48y4,
        p10_b2      => c39y4,
        -- PIN 11 is NC
        p12_c2      => c40y1,
        p13_d2      => c40y2
        -- PIN 14 is VCC
    );
    
    C45 : IC7410
    port map (
        p1_a1       => c40y3,
        p2_b1       => c40y4,
        p3_a2       => c41y2,
        p4_b2       => c41y3,
        p5_c2       => c41y4,
        p6_y2       => c45y2,
        -- PIN 7 is GND
        p8_y3       => open, -- unused
        p9_a3       => '0',  -- unused
        p10_b3      => '0',  -- unused
        p11_c3      => '0',  -- unused
        p12_y1      => c45y1,
        p13_c1      => c41y1
        -- PIN 14 is VCC
    );
    
    C46 : IC7400
    port map (
        p1_a1       => c42y3,
        p2_b1       => c42y4,
        p3_y1       => c46y1,
        p4_a2       => c43y1,
        p5_b2       => c43y2,
        p6_y2       => c46y2,
        -- PIN 7 is GND
        p8_y3       => open, -- unused
        p9_a3       => '0',  -- unused
        p10_b3      => '0',  -- unused
        p11_y4      => open, -- unused
        p12_a4      => '0',  -- unused
        p13_b4      => '0'   -- unused
        -- PIN 14 is VCC
    );
    
    C47 : IC7404
    port map (
        p1_1a       => c44y1,
        p2_1y       => c47y1,
        p3_2a       => c44y2,
        p4_2y       => c47y2,
        p5_3a       => T3,
        p6_3y       => c47y3,
        -- PIN 7 is GND
        p8_4y       => c47y4,
        p9_4a       => c45y1,
        p10_5y      => c47y5,
        p11_5a      => c45y2,
        p12_6y      => c47y6,
        p13_6a      => c42y1
        -- PIN 14 is VCC
    );
    
    C48 : IC7404
    port map (
        p1_1a       => c42y2,
        p2_1y       => c48y1,
        p3_2a       => c46y2,
        p4_2y       => c48y2,
        p5_3a       => T1,
        p6_3y       => c48y3,
        -- PIN 7 is GND
        p8_4y       => c48y4,
        p9_4a       => T3,
        p10_5y      => open, -- unused
        p11_5a      => '0',  -- unused
        p12_6y      => open, -- unused
        p13_6a      => '0'   -- unused
        -- PIN 14 is VCC
    );

end behv;