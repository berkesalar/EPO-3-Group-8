library ieee;
use ieee.std_logic_1164.all;

entity bit_counter_25 is
    port(
        clk, reset: in std_logic;
        count_out: out std_logic_vector(23 downto 0)
    );
end bit_counter_25;
