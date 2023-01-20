library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

architecture behavioural of reg_6_bit is
    begin
        process(clk)
        begin
            if(clk'event and clk = '1') then
                if(reset = '1') then
                    q <= "00001111" ;
                else
                    q <= d;
                end if;
            end if;
        end process;
end architecture behavioural;

