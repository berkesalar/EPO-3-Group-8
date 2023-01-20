library IEEE;
use IEEE.std_logic_1164.ALL;

entity goomba_anim_struct is
	port (  clk             : in    std_logic;
            		reset           : in    std_logic;
            		h		: in 	std_logic_vector(9 downto 0);
		v		: in 	std_logic_vector(9 downto 0);
		enable		: in std_logic;
		x1             	: in  std_logic_vector(11 downto 0);
        		y1             	: in  std_logic_vector(7 downto 0);
		x2             	: in  std_logic_vector(11 downto 0);
       		y2             	: in  std_logic_vector(7 downto 0);
		killed1		: in std_logic;
		killed2		: in std_logic;
		red_total		: in std_logic_vector(3 downto 0);
		green_total		: in std_logic_vector(3 downto 0);
		blue_total		: in std_logic_vector(3 downto 0);
		x_cam		: in std_logic_vector(11 downto 0);
		red_out		: out std_logic_vector(3 downto 0);
		green_out		: out std_logic_vector(3 downto 0);
		blue_out		: out std_logic_vector(3 downto 0);
		dgd1		: out std_logic;
		dgd2		: out std_logic);
end goomba_anim_struct;

