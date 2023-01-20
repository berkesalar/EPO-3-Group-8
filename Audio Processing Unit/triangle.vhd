library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--component for creating a triangle wave
entity triangle is
    port(
        clk:        in std_logic;
        reset:      in std_logic;
        period:     in std_logic_vector(7 downto 0);
        count:      in std_logic_vector(7 downto 0);
        phase:      in std_logic_vector(4 downto 0);
        clk_divided:      in std_logic;
        count_reset:out std_logic;
        amplitude:  out std_logic_vector(3 downto 0));
end entity;

architecture behaviour of triangle is

    type phase_state is(off, active);
    signal state, new_state: phase_state;
    begin

        --FSM reset and next-state handling
        process(reset, clk)
        begin
            if(rising_edge(clk)) then
                if(reset = '1') then
                    state <= off;
                else
                    state <= new_state;
                end if;
            end if;
        end process;

        --2-state FSM to reset the counter after every 1/32 of the note period
        process(state, count, period, clk_divided)
        begin
            case state is
                when off =>
                    count_reset <= '0';
                    if(unsigned(count) = unsigned(period)/8 and clk_divided = '1') then
                        new_state <= active;
                    else
                        new_state <= off;
                    end if;
                
                when active =>
                    count_reset <= '1';
                    new_state <= off;
            end case;
        end process;

        --assigns the amplitude as a function of phase
        process(period, phase)
        begin
            if(unsigned(period) = to_unsigned(0,8)) then
                amplitude <= "0000";
            else
                amplitude(0) <= '0';
				amplitude(1) <= '0';
				amplitude(2) <= phase(2) xor phase(0);
				amplitude(3) <= phase(2) xor phase(1);
            end if;
        end process;

end architecture;
