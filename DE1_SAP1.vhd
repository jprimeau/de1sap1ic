-- DESCRIPTION: SAP-1 - DE1 specific layer
-- AUTHOR: Jonathan Primeau
--
-- o o o o o o o o o o  oo oo oo oo
-- | | | | | | | | | |  [] [] [] []
-- 
-- SW[9] -> PROG/RUN
-- SW[8] -> MAN/AUTO
-- SW[7] -> LOAD PROGRAM/D7
-- SW[6] ->    D6
-- SW[5] ->    D5
-- SW[4] ->    D4
-- SW[3] -> A3/D3
-- SW[2] -> A2/D2
-- SW[1] -> A1/D1
-- SW[0] -> A0/D0
-- 
-- KEY[3] -> ADDR/DATA
-- KEY[2] -> STORE
-- KEY[1] -> STEP
-- KEY[0] -> CLEAR/START
--
-- HEX[3] -> ADDRESS
-- HEX[2] ->
-- HEX[1] -> DATA HI
-- HEX[0] -> DATA LO

library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
    
use work.all;

entity DE1_SAP1 is
    port (
        CLOCK_50    : in std_logic;
        SW          : in std_logic_vector(9 downto 0);
        KEY         : in std_logic_vector(3 downto 0);
        LEDR        : out std_logic_vector(9 downto 0);
        LEDG        : out std_logic_vector(7 downto 0);
        HEX0        : out std_logic_vector(0 to 6);
        HEX1        : out std_logic_vector(0 to 6);
        HEX2        : out std_logic_vector(0 to 6);
        HEX3        : out std_logic_vector(0 to 6)
    );
end DE1_SAP1;

architecture rtl of DE1_SAP1 is

    signal clock        : std_logic;
    signal counter      : std_logic_vector(25 downto 0);

    signal addr_port    : std_logic_vector(3 downto 0);
    signal data_port    : std_logic_vector(7 downto 0);
    signal bus_port     : std_logic_vector(7 downto 0);
    signal data_disp    : std_logic_vector(7 downto 0);

    signal run_mode     : std_logic := '0';
    signal auto_mode    : std_logic := '0';
    signal man_mode     : std_logic := '0';
    signal step         : std_logic := '0';
    signal ld_pgm       : std_logic := '0';
    signal store_mode   : std_logic := '0';
    signal start_mode   : std_logic := '0';
    signal clear_mode   : std_logic := '1';
    signal addr_mode    : std_logic := '1';
    
    signal halt         : std_logic := '0';
    
    signal panel_addr   : std_logic_vector(3 downto 0) := (others=>'0');
    signal panel_data   : std_logic_vector(7 downto 0) := (others=>'0');

begin
    LEDR <= SW;
    HEX2 <= (others => '1') when halt = '0' else "1001000";

    run_mode <= SW(9);
    auto_mode <= SW(8);
    man_mode <= not SW(8);

    LEDG(7) <= addr_mode;
    LEDG(6) <= not addr_mode;
    
    store_mode <= not KEY(2);
    LEDG(5) <= store_mode;
    LEDG(4) <= store_mode;
    
    step <= not KEY(1);
    LEDG(3) <= clock when auto_mode = '1' and run_mode = '1' and halt = '0' else step;
    LEDG(2) <= clock when auto_mode = '1' and run_mode = '1' and halt = '0' else step;
    
    LEDG(1) <= clear_mode;
    LEDG(0) <= not clear_mode;
    
    data_disp <= data_port when run_mode = '1' else bus_port;
    
    -- Address and data input
    process (KEY(3), SW, addr_mode)
    begin
        if KEY(3)'event and KEY(3) = '0' then
            -- Switch between address and data input
            addr_mode <= not addr_mode;
        end if;
        if addr_mode = '1' then
            -- Adress mode active: store address
            panel_addr <= SW(3 downto 0);
            ld_pgm <= SW(7);
        else
            -- Data mode active: store data
            panel_data <= SW(7 downto 0);
            ld_pgm <= '0';
        end if;
    end process;
    
    -- Switch between clear and start mode
    CLEAR_START_MODE:
    process (KEY(0), run_mode, clear_mode)
    begin
        if KEY(0)'event and KEY(0) = '0' then
            if run_mode = '1' then
                clear_mode <= not clear_mode;
            end if;
        end if;
    end process;
    start_mode <= not clear_mode;

    -- Generate a 1Hz clock.
    process(CLOCK_50)
    begin
        if CLOCK_50'event and CLOCK_50 = '1' then
            if clear_mode = '1' then
                clock <= '0';
                counter <= (others => '0');
            else
                if conv_integer(counter) = 25000000 then
                    counter <= (others => '0');
                    clock <= not clock;
                else
                    counter <= counter + 1;
                end if;
            end if;
        end if;
    end process;
    
    HEX3_DISPLAY : SSD
    port map
    (
        input   => addr_port,
        output  => HEX3
    );
    
    HEX1_DISPLAY : SSD
    port map
    (
        input   => data_disp(7 downto 4),
        output  => HEX1
    );
    
    HEX0_DISPLAY : SSD
    port map
    (
        input   => data_disp(3 downto 0),
        output  => HEX0
    );

    SAP1: entity work.SAP1_TOP
    port map (
        clock       => clock and not halt,
        adress      => panel_addr,
        data        => panel_data,
        start       => start_mode,
        step        => step,
        manual      => man_mode,
        ld_pgm      => ld_pgm,
        run         => run_mode,
        store       => store_mode,
        addr_out    => addr_port,
        data_out    => data_port,
        bus_out     => bus_port,
        halt_out    => halt
    );

end architecture rtl;