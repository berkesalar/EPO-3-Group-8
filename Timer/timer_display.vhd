library ieee;
use ieee.std_logic_1164.all;

entity timer_display is
    port(
        clk, rst                  : in std_logic;
        time_up                   : out std_logic;
        Seven_Segment_h           : out std_logic_vector (6 downto 0);
        Seven_Segment_t           : out std_logic_vector (6 downto 0);
        Seven_Segment_o           : out std_logic_vector (6 downto 0);
        warning                   : out std_logic
    );
end timer_display;