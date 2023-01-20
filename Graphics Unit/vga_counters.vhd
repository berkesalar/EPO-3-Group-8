library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;


entity vga_counters is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        h     : out std_logic_vector(9 downto 0);
        v     : out std_logic_vector(9 downto 0));
end vga_counters;


architecture behavioural of vga_counters is
signal hcount: std_logic_vector (9 downto 0);
signal vcount: std_logic_vector (9 downto 0);

begin

hcounter: process(clk,reset)
begin
		if (rising_edge (clk)) then
			if ((reset = '1') OR to_integer(unsigned(hcount)) = 799) then
				hcount <= (others => '0');
				
			else
				hcount <= std_logic_vector(to_unsigned(to_integer(unsigned( hcount )) + 1, 10));
			end if;
		end if;
		
end process;
h <= hcount;

vcounter: process(clk,reset,hcount)
begin
		if (rising_edge (clk)) then
			if ((reset = '1') OR to_integer(unsigned(vcount)) = 524) then
				vcount <= (others => '0');
				
			else
				if (to_integer(unsigned(hcount)) = 799) then

					if (to_integer(unsigned(vcount)) < 523) then
						vcount <= std_logic_vector(to_unsigned(to_integer(unsigned( vcount )) + 1, 10));
					else
						vcount <= (others => '0');
					end if;
				end if;
			end if;
		end if;
		
end process;
v <= vcount;
end architecture;
