library ieee;
use ieee.std_logic_1164.all;

entity double_dabbler is
	port(       bin_in     : in std_logic_vector(8 downto 0);
                bcd_hun    : out std_logic_vector(3 downto 0);
                bcd_ten    : out std_logic_vector(3 downto 0);
                bcd_one    : out std_logic_vector(3 downto 0)
                );
end double_dabbler;