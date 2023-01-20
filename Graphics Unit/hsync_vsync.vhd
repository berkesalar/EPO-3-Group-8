library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity hsync_vsync is
   port(h     : in  std_logic_vector(9 downto 0);
        hsync : out std_logic;
        v     : in  std_logic_vector(9 downto 0);
        vsync : out std_logic);
end hsync_vsync;


architecture behavioural of hsync_vsync is
begin

hsync_low: process(h,v)
begin
	if (to_integer(unsigned(h)) > 655 and to_integer(unsigned(h)) < 752) then
		hsync <= '0';
	else
		hsync <= '1';
	end if;

	if (to_integer(unsigned(v)) > 489 and to_integer(unsigned(v)) < 492) then
		vsync <= '0';
	else
		vsync <= '1';
	end if;
end process;
end behavioural;
