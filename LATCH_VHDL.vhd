library ieee;
    use ieee.std_logic_1164.all;
    
entity LATCH_VHDL is
    port (
        d       : in std_logic;
        ena     : in std_logic;
        q       : out std_logic
    );
end LATCH_VHDL;

architecture behv of LATCH_VHDL is
    signal iq   : std_logic := '0';
begin		
    process(d, ena)
    begin
        if ena = '1' then
            iq <= d;
        end if;
    end process;
    q <= iq;
end behv;