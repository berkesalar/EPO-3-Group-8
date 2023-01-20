library IEEE;
use IEEE.std_logic_1164.ALL;

entity megamux is
   port(g_lut_data_1 : in  std_logic_vector(1 downto 0);
        g_lut_data_2 : in  std_logic_vector(1 downto 0);
	s	     : in  std_logic;
        g_lut_data   : out std_logic_vector(1 downto 0));
end megamux;

architecture behaviour of megamux is

begin

	g_lut_data <= g_lut_data_2 when (s = '0') else
		      g_lut_data_1;

end behaviour;

