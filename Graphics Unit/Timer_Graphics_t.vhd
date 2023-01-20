library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity timer_graphics_t is
   port(clk      : in  std_logic;
        reset    : in  std_logic;
		h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
		timer_data : in std_logic_vector ( 6 downto 0);
		timer_select    : out std_logic);
end timer_graphics_t;

architecture behavioural of timer_graphics_t is

begin

	
--1= white and 0= rest of the game------------------

combinatorial: process(timer_data, h , v )
begin


		if (timer_data(6) = '1' and ((to_integer(unsigned(h)) > 507) and (to_integer(unsigned(h)) < 532)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 34))) then
				timer_select <= '1';

		elsif (timer_data(1) = '1' and ((to_integer(unsigned(h)) > 507) and (to_integer(unsigned(h)) < 512)) and ((to_integer(unsigned(v)) > 33) and (to_integer(unsigned(v)) < 52))) then
				timer_select <= '1';
		
		elsif (timer_data(5) = '1' and ((to_integer(unsigned(h)) > 527 ) and (to_integer(unsigned(h)) < 532)) and ((to_integer(unsigned(v)) > 33) and (to_integer(unsigned(v)) < 52))) then
				timer_select <= '1';
				
		elsif (timer_data(0) = '1' and ((to_integer(unsigned(h)) > 507) and (to_integer(unsigned(h)) < 532)) and ((to_integer(unsigned(v)) > 51) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
				
		elsif (timer_data(2) = '1' and ((to_integer(unsigned(h)) > 507) and (to_integer(unsigned(h)) < 512)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 74))) then
				timer_select <= '1';
				
		elsif (timer_data(4) = '1' and ((to_integer(unsigned(h)) > 527) and (to_integer(unsigned(h)) < 532)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 74))) then
				timer_select <= '1';
		
		elsif (timer_data(3) = '1' and ((to_integer(unsigned(h)) > 507) and (to_integer(unsigned(h)) < 532)) and ((to_integer(unsigned(v)) > 73) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
		
		else
				timer_select <= '0';
		
		end if;
				
end process;
end behavioural;