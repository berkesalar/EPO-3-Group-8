library IEEE;
use IEEE.std_logic_1164.ALL;

entity rgb_multiplex is
   port(mario_sel_bit : in  std_logic;
        mario_red     : in  std_logic_vector(3 downto 0);
        mario_green   : in  std_logic_vector(3 downto 0);
        mario_blue    : in  std_logic_vector(3 downto 0);
        map_red       : in  std_logic_vector(3 downto 0);
        map_green     : in  std_logic_vector(3 downto 0);
        map_blue      : in  std_logic_vector(3 downto 0);
        red           : out std_logic_vector(3 downto 0);
        green         : out std_logic_vector(3 downto 0);
        blue          : out std_logic_vector(3 downto 0));
end rgb_multiplex;

architecture behaviour of rgb_multiplex is
begin
	
	red <= map_red when mario_sel_bit ='0' else 		--1 = mario fsm and 0 = rgb fsm--
		   mario_red when mario_sel_bit ='1' else
		     (others => '0');
			 
	green <= map_green when mario_sel_bit ='0' else 		--1 = mario fsm and 0 = rgb fsm--
		    mario_green when mario_sel_bit ='1' else
		     (others => '0');
			 
	blue <= map_blue when mario_sel_bit ='0' else 		--1 = mario fsm and 0 = rgb fsm--
		    mario_blue when mario_sel_bit ='1' else
		     (others => '0');
	

end behaviour;
