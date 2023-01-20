library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity g_abs_rel is
    port(
        x_abs   : in std_logic_vector(11 downto 0);
        x_cam   : in std_logic_vector(11 downto 0);
        renderable : out std_logic;
        x_rel   : out std_logic_vector(8 downto 0)
    );
end entity g_abs_rel;

architecture behaviour of g_abs_rel is

begin

    x_rel <= std_logic_vector(to_unsigned(to_integer(unsigned(x_abs)) - to_integer(unsigned(x_cam)), 9)) when (to_integer(unsigned(x_abs)) - to_integer(unsigned(x_cam)) <= 319) else
             (others => '0'); 

    renderable <= '1' when (to_integer(unsigned(x_abs)) - to_integer(unsigned(x_cam)) <= 319) else '0';

end behaviour;
