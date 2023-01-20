library IEEE;
use IEEE.std_logic_1164.ALL;

entity xy_calc is
    port(
        clk             : in std_logic;
	enable_xy		: in std_logic;
        rst             : in std_logic;
        v_x             : in std_logic_vector(10 downto 0);
        v_y             : in std_logic_vector(11 downto 0);
        x_out           : out std_logic_vector(11 downto 0);
        y_out           : out std_logic_vector(7 downto 0);
			Ani		: out std_logic
        );
end xy_calc;
