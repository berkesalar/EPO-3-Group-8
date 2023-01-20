library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--FSM for the pulse channels
entity pulse is
    port(
        clk:        in std_logic;
        reset:      in std_logic;
        duty:       in std_logic_vector(1 downto 0);
        period:     in std_logic_vector(7 downto 0);
        count:      in std_logic_vector(7 downto 0);
        count_reset:out std_logic;
        active:     out std_logic);
end entity;

architecture structural of pulse is

    type pulse_state is(low, high, temp);
    signal state, new_state: pulse_state;

begin

    --FSM reset and next-state handling
    process(reset, clk)
    begin
        if(rising_edge(clk)) then
	        if(reset = '1') then
            	state <= low;
		    else
            	state <= new_state;
        	end if;
	end if;
    end process;

    --3-state FSM for creating the pulse wave
    process(state, count, duty, period)
    begin
        case state is
            when low =>
                active <= '0';
                count_reset <= '0';
                
                if((unsigned(count) = unsigned(period)) and (duty /= "00" and period /= "00000000")) then --at the end of the period, start the next cycle
                    new_state <= temp;
                else
                    new_state <= low;
                end if;
            
            --this state is a way to avoid mealy machine behaviour
            when temp =>
                active <= '0';
                count_reset <= '1';
                new_state <= high;

            when high =>
                active <= '1';
                count_reset <= '0';

                --if statements to create different duty cycles
                if(duty = "00") then
                    new_state <= low;
                elsif((duty = "01") and (unsigned(count) = unsigned(period)/8)) then
                    new_state <= low;
                elsif((duty = "10") and (unsigned(count) = unsigned(period)/4)) then
                    new_state <= low;
                elsif((duty = "11") and (unsigned(count) = unsigned(period)/2)) then
                    new_state <= low;
                else
                    new_state <= high;
                end if;
            
        end case;
    end process;

end architecture structural;    
