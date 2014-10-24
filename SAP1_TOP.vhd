library ieee;
    use ieee.std_logic_1164.all;
    
use work.all;

entity SAP1_TOP is
    port (
        -- BEGIN: SIMULATION ONLY
--        iLDA_out    : out std_logic;
--        iADD_out    : out std_logic;
--        iSUB_out    : out std_logic;
--        iOUT_out    : out std_logic;
--        iHLT_out    : out std_logic;
--        Cp_out      : out std_logic;
--        Ep_out      : out std_logic;
--        Lm_out      : out std_logic;
--        CE_out      : out std_logic;
--        Li_out      : out std_logic;
--        Ei_out      : out std_logic;
--        La_out      : out std_logic;
--        Ea_out      : out std_logic;
--        Su_out      : out std_logic;
--        Eu_out      : out std_logic;
--        Lb_out      : out std_logic;
--        Lo_out      : out std_logic;
--        mar_out     : out std_logic_vector(3 downto 0);
--        mux_out     : out std_logic_vector(3 downto 0);
--        i_reg_out   : out std_logic_vector(3 downto 0);
--        T1_out      : out std_logic;
--        T2_out      : out std_logic;
--        T3_out      : out std_logic;
--        T4_out      : out std_logic;
--        T5_out      : out std_logic;
--        T6_out      : out std_logic;
--        clk_out     : out std_logic;
--        clkn_out    : out std_logic;
--        clr_out     : out std_logic;
--        clrn_out    : out std_logic;
        -- END: SIMULATION ONLY
    
        clock       : in std_logic;
        adress      : in std_logic_vector(3 downto 0);
        data        : in std_logic_vector(7 downto 0);
        start       : in std_logic;
        step        : in std_logic;
        manual      : in std_logic;
        ld_pgm      : in std_logic;
        run         : in std_logic;
        store       : in std_logic;
        addr_out    : out std_logic_vector(3 downto 0);
        data_out    : out std_logic_vector(7 downto 0);
        bus_out     : out std_logic_vector(7 downto 0);
        halt_out    : out std_logic
    );
end SAP1_TOP;

architecture behv of SAP1_TOP is
    signal w_bus        : std_logic_vector(7 downto 0) := x"00";
    
    signal mar          : std_logic_vector(3 downto 0) := x"0";
    signal mux          : std_logic_vector(3 downto 0) := x"0";
    signal i_reg        : std_logic_vector(3 downto 0) := x"0";
    signal acc          : std_logic_vector(7 downto 0) := x"00";
    signal b_reg        : std_logic_vector(7 downto 0) := x"00";
    
    signal iLDA         : std_logic := '0';
    signal iADD         : std_logic := '0';
    signal iSUB         : std_logic := '0';
    signal iOUT         : std_logic := '0';
    signal iHLT         : std_logic := '1';
    
    signal T1           : std_logic := '0';
    signal T2           : std_logic := '0';
    signal T3           : std_logic := '0';
    signal T4           : std_logic := '0';
    signal T5           : std_logic := '0';
    signal T6           : std_logic := '0';
    
    signal Cp           : std_logic := '0';
    signal Ep           : std_logic := '0';
    signal Lm           : std_logic := '1';
    signal CE           : std_logic := '0';
    signal Li           : std_logic := '1';
    signal Ei           : std_logic := '1';
    signal La           : std_logic := '0';
    signal Ea           : std_logic := '0';
    signal Su           : std_logic := '0';
    signal Eu           : std_logic := '0';
    signal Lb           : std_logic := '1';
    signal Lo           : std_logic := '1';
    
    signal clk          : std_logic := '0';
    signal clkn         : std_logic := '0';
    signal clr          : std_logic := '0';
    signal clrn         : std_logic := '0';
begin
    addr_out <= mux;
    bus_out <= w_bus;
    halt_out <= not iHLT;
    
    -- BEGIN: SIMULATION ONLY
--    iLDA_out <= iLDA;
--    iADD_out <= iADD;
--    iSUB_out <= iSUB;
--    iOUT_out <= iOUT;
--    iHLT_out <= iHLT;
--    Cp_out <= Cp;
--    Ep_out <= Ep;
--    Lm_out <= Lm;
--    CE_out <= CE;
--    Li_out <= Li;
--    Ei_out <= Ei;
--    La_out <= La;
--    Ea_out <= Ea;
--    Su_out <= Su;
--    Eu_out <= Eu;
--    Lb_out <= Lb;
--    Lo_out <= Lo;
--    mar_out <= mar;
--    mux_out <= mux;
--    i_reg_out <= i_reg;
--    T1_out <= T1;
--    T2_out <= T2;
--    T3_out <= T3;
--    T4_out <= T4;
--    T5_out <= T5;
--    T6_out <= T6;
--    clk_out <= clk;
--    clkn_out <= clkn;
--    clr_out <= clr;
--    clrn_out <= clrn;
    -- END: SIMULATION ONLY

    PROMGRAM_COUNTER : SAP1_PROGRAM_COUNTER
    port map (
        clkn        => clkn,
        clrn        => clrn,
        cp          => Cp,
        ep          => Ep and run, -- * Not in original design, should be: Ep,
        q           => w_bus(3 downto 0)
    );
    
    MEMORY_ADDRESS_REGISTER : SAP1_MAR
    port map (
        input       => w_bus(3 downto 0),
        clk         => clk,
        Lm          => Lm,
        output      => mar
    );
    
    MULTIPLEXER : SAP1_2TO1_MULTIPLEXER
    port map (
        sel         => run,
        input_a     => adress,
        input_b     => mar,
        output      => mux
    );
    
    RAM : SAP1_16X8RAM
    port map (
        ld_pgm      => ld_pgm,
        addr        => mux,
        data        => data,
        me          => CE and run, -- * Not in original design, should be: CE,
        we          => not store,
        sense       => w_bus
    );
    
    INSTRUCTION_REGISTER : SAP1_INSTRUCTION_REGISTER
    port map (
        input       => w_bus,
        clk         => clk,
        clr         => clr,
        Li          => Li,
        Ei          => Ei,
        out_inst    => i_reg,
        out_bus     => w_bus(3 downto 0)
    );
    
    ACCUMULATOR : SAP1_ACCUMULATOR
    port map (
        input       => w_bus,
        clk         => clk,
        La          => La,
        Ea          => Ea,
        out_add_sub => acc,
        out_bus     => w_bus
    );
    
    ADD_SUB : SAP1_ADDER_SUBTRACTOR
    port map (
        input_a     => acc,
        input_b     => b_reg,
        Eu          => Eu,
        Su          => Su,
        output      => w_bus
    );
    
    B_REGISTER : SAP1_B_REGISTER
    port map (
        input       => w_bus,
        clk         => clk,
        Lb          => Lb,
        output      => b_reg
    );
    
    OUTPUT_REGISTER : SAP1_OUTPUT_REGISTER
    port map (
        input       => w_bus,
        clk         => clk,
        clr         => clr,
        Lo          => Lo,
        output      => data_out
    );
    
    PANEL : SAP1_PANEL
    port map (
        start       => start,
        step        => step,
        manual      => manual,
        clock       => clock,
        halt        => iHLT,
        clr         => clr,
        clrn        => clrn,
        clk         => clk,
        clkn        => clkn
    );
    
    I_DECODER : SAP1_INSTRUCTION_DECODER
    port map (
        i           => i_reg,
        iLDA        => iLDA,
        iADD        => iADD,
        iSUB        => iSUB,
        iOUT        => iOUT,
        iHLT        => iHLT
    );
    
    RC : SAP1_RING_COUNTER
    port map (
        clk         => clk,
        clrn        => clrn,
        T1          => T1,
        T2          => T2,
        T3          => T3,
        T4          => T4,
        T5          => T5,
        T6          => T6
    );
    
    CM : SAP1_CONTROL_MATRIX
    port map (
        T1          => T1,
        T2          => T2,
        T3          => T3,
        T4          => T4,
        T5          => T5,
        T6          => T6,
        iLDA        => iLDA,
        iADD        => iADD,
        iSUB        => iSUB,
        iOUT        => iOUT,
        Cp          => Cp,
        Ep          => Ep,
        Lm          => Lm,
        CE          => CE,
        Li          => Li,
        Ei          => Ei,
        La          => La,
        Ea          => Ea,
        Su          => Su,
        Eu          => Eu,
        Lb          => Lb,
        Lo          => Lo
    );
end behv;