library IEEE;
use IEEE.std_logic_1164.ALL;

entity acceleration_module is
	port( clk: in std_logic;
	      enable_acc : in std_logic;
	      reset : in std_logic; 
	      L : in std_logic;
              R : in std_logic;
	      B : in std_logic;
	      airborne : in std_logic;
	      Collision_L: in std_logic;
	      Collision_R: in std_logic;
	      Velocity: in std_logic_vector(10 downto 0);
	      Acceleration: out std_logic_vector(5 downto 0));
end acceleration_module;

