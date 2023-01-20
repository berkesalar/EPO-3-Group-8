library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behavioural of bit_counter_25 is

    signal      count_0, new_count: unsigned(23 downto 0);
    constant    one_second:         integer := 12500000;

begin
    
    process(clk)
    begin

        if(reset = '1') then
            count_0 <= (others => '0');
        else
            if(rising_edge(clk)) then
                count_0 <= new_count;
            end if;
        end if;
    end process;
    
    process(count_0)
    begin
        if (count_0 < to_unsigned(one_second, 24)) then
            new_count <= count_0 + 1;
        else
            new_count <= count_0;
        end if;
    
    end process;
    
    count_out <= std_logic_vector(count_0);
    
end architecture behavioural;
