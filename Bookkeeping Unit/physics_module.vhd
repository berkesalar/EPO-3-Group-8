library IEEE;
use IEEE.std_logic_1164.ALL;

entity physics_module is
   port(clk       : in  std_logic;
        reset     : in  std_logic;
        L         : in  std_logic;
        R         : in  std_logic;
	B	  : in  std_logic;
	A	  : in  std_logic;
        Collision : in  std_logic_vector(3 downto 0);
	clk_from_map : in std_logic;
	kill	  : in std_logic;
	jump  : out std_logic;
        X  : out std_logic_vector(11 downto 0);
	Y : out std_logic_vector(7 downto 0);
	Ani : out std_logic;
	enable_ani: out std_logic;
	enable_goomba: out std_logic);
end physics_module; 

