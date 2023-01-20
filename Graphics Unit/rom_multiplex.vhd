library IEEE;
use IEEE.std_logic_1164.ALL;

entity rom_multiplex is
   port(rom_sel    : in  std_logic;
        map_output : in  std_logic_vector(11 downto 0);
        vga_output : in  std_logic_vector(11 downto 0);
        rom_input  : out  std_logic_vector(11 downto 0));
end rom_multiplex;

architecture behaviour of rom_multiplex is
begin
	
	rom_input <= vga_output when rom_sel ='1' else
		     map_output when rom_sel ='0' else
		     (others => '0');
	

end behaviour;



