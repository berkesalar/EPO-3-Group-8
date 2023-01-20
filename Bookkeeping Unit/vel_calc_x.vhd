library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity vel_calc_x is
    port(
        clk             : in    std_logic;
	enable_vel		: in	std_logic;
        rst             : in    std_logic;
        b               : in    std_logic;
        collision       : in    std_logic_vector(3 downto 0);
        a_x             : in    std_logic_vector(5 downto 0);
        v_x_out         : out   std_logic_vector(10 downto 0)
    );
end vel_calc_x;

