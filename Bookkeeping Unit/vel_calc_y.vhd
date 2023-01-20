library IEEE;
use IEEE.std_logic_1164.ALL;

entity vel_calc_y is
	port(
        clk             : in    std_logic;
	enable_vel		: in	std_logic;
        rst             : in    std_logic;
	a_y		: in	std_logic_vector(10 downto 0);
	collision       : in    std_logic_vector(3 downto 0);
	v_y_out		: out	std_logic_vector(11 downto 0)
    );
end vel_calc_y;

