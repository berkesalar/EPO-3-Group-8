library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;


entity timer_mux is
   port(timer_select_bit : in  std_logic;
   
        total_red : in  std_logic_vector(3 downto 0);
        total_green : in  std_logic_vector(3 downto 0);
        total_blue : in  std_logic_vector(3 downto 0);
		
        red : out  std_logic_vector(3 downto 0);
        green : out  std_logic_vector(3 downto 0);
        blue : out  std_logic_vector(3 downto 0));
end timer_mux;

architecture behaviour of timer_mux is
begin
	
	red <=	total_red when timer_select_bit = '0' else
			X"F" when timer_select_bit = '1' else 
		     (others => '0'); 
			 
	green <= total_green when timer_select_bit = '0' else 		
		    X"F" when timer_select_bit = '1' else
		     (others => '0');
			 
	blue <= total_blue when timer_select_bit = '0' else 		
		    X"F" when timer_select_bit = '1' else
		     (others => '0');
	

end behaviour;
