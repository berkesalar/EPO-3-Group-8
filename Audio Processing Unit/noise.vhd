library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--component for connecting all the noise circuits
entity noise is
    port(
        clk: in std_logic;
        reset: in std_logic;
        period: in std_logic_vector(7 downto 0);
        count: in std_logic_vector(7 downto 0);
        count_reset: out std_logic;
        noisy: out std_logic);
end entity;

architecture behaviour of noise is
    component lfsr is
        port (
            clk: in std_logic;
            reset: in std_logic;
            enable: in std_logic;
            noise: out std_logic);
    end component lfsr;

    type length_state is(off, active);
    signal state, new_state: length_state;
    signal random, restart: std_logic;

begin
    --port map to the LFSR component which generates a pseudo-random signal
L:   lfsr port map(clk, reset, restart, random);  

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

    --FSM to dictate the rate at which the LFSR shifts
    process(state, count, period, random)
    begin
        case state is
            when off =>
                restart <= '0';
                if(unsigned(period) = to_unsigned(0,8)) then --output stays zero when input period is 0
                    new_state <= off;
                    noisy <= '0';
                else
                    noisy <= random;

                    if(unsigned(count) >= unsigned(period)) then
                        new_state <= active;
                    else
                        new_state <= off;
                    end if;
                end if;

            --creates a 1 clock cycle long pulse
            when active =>
                restart <= '1';
                noisy <= random;
                new_state <= off;
        end case;
    end process;

    count_reset <= restart;

end architecture;
