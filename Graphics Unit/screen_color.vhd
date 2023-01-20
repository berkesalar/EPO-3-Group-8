library IEEE;
use IEEE.std_logic_1164.ALL;

entity screen_color is
   port(lut_val : in  std_logic;
        red     : out std_logic_vector(3 downto 0);
        green   : out std_logic_vector(3 downto 0);
        blue    : out std_logic_vector(3 downto 0));
end screen_color;

architecture behaviour of screen_color is
begin
	
	red <= X"F" when lut_val = '1' else
		X"0" when lut_val = '0' else
		X"0";

	green <= X"F" when lut_val = '1' else
		X"0" when lut_val = '0' else
		X"0";
	
	blue <= X"F" when lut_val = '1' else
		X"0" when lut_val = '0' else
		X"0";	
	

end behaviour;
