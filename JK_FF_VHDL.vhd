library ieee;
    use ieee.std_logic_1164.all;
 
entity JK_FF_VHDL is
   port(
        j       : in std_logic;
        k       : in std_logic;
        clrn    : in std_logic;
        clk     : in std_logic;
        q       : out std_logic
    );
end JK_FF_VHDL;
 
architecture behv of JK_FF_VHDL is
   signal iq: std_logic;
begin
    process (clk, clrn, j, k) 
    begin
        if clrn = '0' then
            iq <= '0';
        elsif (clk'event and clk = '0') then                 
            if j = '0' and k = '0' then
                iq <= iq;
            elsif j = '0' and k = '1' then
                iq <= '0';
            elsif j = '1' and k = '0' then
                iq <= '1';
            elsif j = '1' and k = '1' then
                iq <= not iq;
            end if;
        end if;
    end process;
    q <= iq;
end behv;