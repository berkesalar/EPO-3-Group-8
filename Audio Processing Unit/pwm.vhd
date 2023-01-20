library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--component for translating amplitude to PWM signal
entity pwm is
    port (
        clk: in std_logic;
        reset: in std_logic;
        amplitude: in std_logic_vector(5 downto 0);
        count: in std_logic_vector(5 downto 0);
        pwm: out std_logic);
end entity pwm;

architecture behaviour of pwm is

    type sample_state is(off, active);
    signal state, new_state: sample_state;
    signal on_time: std_logic_vector(5 downto 0);

begin

    on_time <= amplitude;
    
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

    process(state, count, on_time)
    begin
        case state is
            when off =>
                pwm <= '0';

                --signal goes high when the sampling period ends
                if(unsigned(count) = to_unsigned(0, 6)) then
                    new_state <= active;
                else
                    new_state <= off;
                end if;
            
            when active =>
                pwm <= '1';

                --signal goes low after the specified on-time
                if(unsigned(count) >= unsigned(on_time)) then
                    new_state <= off;
                else
                    new_state <= active;
                end if;
        end case;
    end process;

end architecture;
