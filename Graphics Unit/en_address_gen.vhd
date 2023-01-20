library IEEE;
use IEEE.std_logic_1164.ALL;

entity en_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        x1             : in  std_logic_vector(8 downto 0);
        y1             : in  std_logic_vector(7 downto 0);
		x2             : in  std_logic_vector(8 downto 0);
        y2             : in  std_logic_vector(7 downto 0);
        enemies_address : out std_logic_vector(7 downto 0);
	s		: out std_logic);
end en_address_gen;
