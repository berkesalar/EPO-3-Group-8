library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity block_rgb is
port(   clk		 :  in std_logic;
	block_lut_data : in  std_logic_vector(1 downto 0);
        red      : out std_logic_vector(3 downto 0);
        green    : out std_logic_vector(3 downto 0);
        blue     : out std_logic_vector(3 downto 0));
end block_rgb;

architecture behavioural of block_rgb is

begin
	
process(clk, block_lut_data)
begin
if(rising_edge(clk)) then
	if (block_lut_data = "00") then 			--00 = yellow(FF9)	01 = brown(630)	10 = black, 11 = blue
					red <= X"F";
					green <= X"F";
					blue <= X"C";
	elsif (block_lut_data = "01") then -- brown
					red <= X"6";
					green <= X"3";
					blue <= X"0";
	elsif (block_lut_data = "10") then -- black
					red <= X"0";
					green <= X"0";
					blue <= X"0";
	else -- blue
					red <= X"3";
					green <= X"9";
					blue <= X"F";

	end if;
end if;
	
end process;

end behavioural;
