library IEEE;
use IEEE.std_logic_1164.ALL;

entity vga_colors_mux is
   port(game_select_bit : in  std_logic;
   
        red_screen : in  std_logic_vector(3 downto 0);
        green_screen : in  std_logic_vector(3 downto 0);
        blue_screen : in  std_logic_vector(3 downto 0);
		
        red_game : in  std_logic_vector(3 downto 0);
        green_game : in  std_logic_vector(3 downto 0);
        blue_game : in  std_logic_vector(3 downto 0);
		
        red : out  std_logic_vector(3 downto 0);
        green : out  std_logic_vector(3 downto 0);
        blue : out  std_logic_vector(3 downto 0));
end vga_colors_mux ;

architecture behaviour of vga_colors_mux is
begin
	
	red <=	red_screen when game_select_bit = '0' else
		red_game when game_select_bit = '1' else 
		     (others => '0'); 

	green <=	green_screen when game_select_bit = '0' else
		green_game when game_select_bit = '1' else 
		     (others => '0'); 

	blue <=	blue_screen when game_select_bit = '0' else
		blue_game when game_select_bit = '1' else 
		     (others => '0'); 


end behaviour;
