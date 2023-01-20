library ieee;
use ieee.std_logic_1164.all;

entity mario_timer is
    port(
        clk, rst:       in std_logic;
        count:          in std_logic_vector(23 downto 0);
        rst_counter:    out std_logic;
        time_up:        out std_logic;
        seconds:        out std_logic_vector(8 downto 0);
        warning:        out std_logic
    );
end mario_timer;
