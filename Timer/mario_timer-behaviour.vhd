library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behavioural of mario_timer is

    signal      seconds_current:    unsigned(8 downto 0);
    signal      seconds_next:       unsigned(8 downto 0);
    signal      rst_counter_int:    std_logic;
    constant    max_timer:          integer := 401;
    constant    warning_value:      integer := 101;

begin

    sequential: process(clk)
    begin
        if (rising_edge (clk)) then
            if (rst = '1') then
                seconds_next <= to_unsigned(0, 9);
                rst_counter_int <= '1';
            else
                if(unsigned(count) > to_unsigned(12499999, 24)) then
                    rst_counter_int <= '1';
                else
                    rst_counter_int <= '0';
                end if;
                seconds_next <= seconds_current;
            end if;
        end if;
    end process;

    combinatorial: process(count)
    begin
        if((to_unsigned(max_timer, 9) > seconds_next) and rst = '0') then
            time_up <= '0';
            if(rst_counter_int = '1') then
                seconds_current <= seconds_next + 1;
            else
                seconds_current <= seconds_next;
            end if;
        else
            seconds_current <= seconds_next;
            if(rst = '0') then
                time_up <= '1';
            else
                time_up <= '0';
            end if;
        end if;
    end process;

    seconds     <=  std_logic_vector(to_unsigned(max_timer, 9) - seconds_next);
    warning     <=  '1' when (to_unsigned(warning_value, 9) > (to_unsigned(max_timer, 9) - seconds_next)) else
                    '0';
    rst_counter <= rst_counter_int;
                
end architecture behavioural;