library ieee;
use ieee.std_logic_1164.all;

architecture behavioural of reset_toggle is

signal reset_int: std_logic;

begin
    
    process(reset, forward, reset_int, clk)
    begin
        if(rising_edge(clk)) then
            if(reset = '1') then
                reset_int <= '1';
            elsif(forward = '0' and reset_int = '1' and reset = '0') then
                reset_int <= '0';
            else
                reset_int <= reset_int;
            end if;
        end if;
    end process;
    
    reset_local <= reset_int;
    
end architecture behavioural;
