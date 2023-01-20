library IEEE;
use IEEE.std_logic_1164.ALL;

entity acceleration_y is
   port(clk        : in  std_logic;
	enable_acc		: in std_logic;
        reset          : in  std_logic;
        A              : in  std_logic;
	Collision_Down   : in  std_logic;
	kill		: in std_logic;
        jump           : out std_logic;
	airborne		: out std_logic;
        Acceleration_y : out std_logic_vector(10 downto 0));
end acceleration_y;

