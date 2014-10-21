library ieee;
    use ieee.std_logic_1164.all;
    
entity TRIBUF_VHDL is
    port (
        d       : in std_logic;
        ena     : in std_logic;
        q       : out std_logic
    );
end TRIBUF_VHDL;

architecture behv of TRIBUF_VHDL is
begin		
    process (d, ena)
    begin
        if ena = '1' then
            q <= d;
        else
            q <= 'Z';
        end if;
    end process;
end behv;