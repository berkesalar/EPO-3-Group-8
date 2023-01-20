library ieee;
use ieee.std_logic_1164.all;

entity reset_toggle is
    port(
        reset           : in std_logic;
        forward           : in std_logic;
        clk             : in std_logic;
        reset_local     : out std_logic
    );
end reset_toggle;
