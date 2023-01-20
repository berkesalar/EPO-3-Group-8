library IEEE;
use IEEE.std_logic_1164.ALL;

entity clock_module is
   port(clk     : in  std_logic;
	reset   : in  std_logic;
	clk_from_map : in std_logic;
        enable_acc : out std_logic;
        enable_vel : out std_logic;
        enable_xy  : out std_logic;
		  enable_ani : out std_logic;
	enable_goomba: out std_logic);
end clock_module;


