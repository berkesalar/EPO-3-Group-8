library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_6_bit is
    port (  clk             : in    std_logic;
            reset           : in    std_logic;
            d               : in    std_logic_vector(7 downto 0);
            q               : out   std_logic_vector(7 downto 0));
end entity reg_6_bit;

