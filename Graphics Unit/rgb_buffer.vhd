library IEEE;
use IEEE.std_logic_1164.ALL;

entity rgb_buffer is
   port(clk   : in  std_logic;
        reset : in  std_logic;
        red_in  : in  std_logic_vector(3 downto 0);
        green_in  : in  std_logic_vector(3 downto 0);
	blue_in  : in  std_logic_vector(3 downto 0);
        red_out : out std_logic_vector(3 downto 0);
        green_out : out std_logic_vector(3 downto 0);
	blue_out  : out  std_logic_vector(3 downto 0));
end rgb_buffer;

architecture behaviour of rgb_buffer is

signal red,green,blue : std_logic_vector(3 downto 0);
begin
	process(clk,reset)
	begin
		if(rising_edge(clk)) then
			if (reset = '1') then
				red_out <= (others => '0');
				green_out <= (others => '0');
				blue_out <= (others => '0');
			else 		

				red_out <= red_in;
				green_out <= green_in;
				blue_out <= blue_in;
			end if;
		end if;
	end process;
end architecture;

