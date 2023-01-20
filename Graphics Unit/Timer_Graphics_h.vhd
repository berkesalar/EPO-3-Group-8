library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity timer_graphics_h is
   port(clk      : in  std_logic;
        reset    : in  std_logic;
		h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
		timer_data_h : in std_logic_vector ( 6 downto 0);
		timer_data_t : in std_logic_vector ( 6 downto 0);
		timer_data_o : in std_logic_vector ( 6 downto 0);
		timer_select    : out std_logic);
end timer_graphics_h;

architecture behavioural of timer_graphics_h is

begin

	
--1= white and 0= rest of the game------------------

combinatorial: process(timer_data_h, timer_data_o, timer_data_t, h , v )
begin

		---------timer h
		if (timer_data_h(6) = '1' and ((to_integer(unsigned(h)) > 499) and (to_integer(unsigned(h)) < 524)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 34))) then
				timer_select <= '1';

		elsif (timer_data_h(1) = '1' and ((to_integer(unsigned(h)) > 499) and (to_integer(unsigned(h)) < 504)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
		
		elsif (timer_data_h(5) = '1' and ((to_integer(unsigned(h)) > 519 ) and (to_integer(unsigned(h)) < 524)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
				
		elsif (timer_data_h(0) = '1' and ((to_integer(unsigned(h)) > 499) and (to_integer(unsigned(h)) < 524)) and ((to_integer(unsigned(v)) > 51) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
				
		elsif (timer_data_h(2) = '1' and ((to_integer(unsigned(h)) > 499) and (to_integer(unsigned(h)) < 504)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
				
		elsif (timer_data_h(4) = '1' and ((to_integer(unsigned(h)) > 519) and (to_integer(unsigned(h)) < 524)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
		
		elsif (timer_data_h(3) = '1' and ((to_integer(unsigned(h)) > 499) and (to_integer(unsigned(h)) < 524)) and ((to_integer(unsigned(v)) > 73) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
				
				
			-------------timer t	
		elsif (timer_data_t(6) = '1' and ((to_integer(unsigned(h)) > 531) and (to_integer(unsigned(h)) < 556)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 34))) then
				timer_select <= '1';

		elsif (timer_data_t(1) = '1' and ((to_integer(unsigned(h)) > 531) and (to_integer(unsigned(h)) < 536)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
		
		elsif (timer_data_t(5) = '1' and ((to_integer(unsigned(h)) > 551 ) and (to_integer(unsigned(h)) < 556)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
				
		elsif (timer_data_t(0) = '1' and ((to_integer(unsigned(h)) > 531) and (to_integer(unsigned(h)) < 556)) and ((to_integer(unsigned(v)) > 51) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
				
		elsif (timer_data_t(2) = '1' and ((to_integer(unsigned(h)) > 531) and (to_integer(unsigned(h)) < 536)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
				
		elsif (timer_data_t(4) = '1' and ((to_integer(unsigned(h)) > 551) and (to_integer(unsigned(h)) < 556)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
		
		elsif (timer_data_t(3) = '1' and ((to_integer(unsigned(h)) > 531) and (to_integer(unsigned(h)) < 556)) and ((to_integer(unsigned(v)) > 73) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
				
		--------timer o
		elsif (timer_data_o(6) = '1' and ((to_integer(unsigned(h)) > 563) and (to_integer(unsigned(h)) < 588)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 34))) then
				timer_select <= '1';

		elsif (timer_data_o(1) = '1' and ((to_integer(unsigned(h)) > 563) and (to_integer(unsigned(h)) < 568)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
		
		elsif (timer_data_o(5) = '1' and ((to_integer(unsigned(h)) > 583 ) and (to_integer(unsigned(h)) < 588)) and ((to_integer(unsigned(v)) > 29) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
				
		elsif (timer_data_o(0) = '1' and ((to_integer(unsigned(h)) > 563) and (to_integer(unsigned(h)) < 588)) and ((to_integer(unsigned(v)) > 51) and (to_integer(unsigned(v)) < 56))) then
				timer_select <= '1';
				
		elsif (timer_data_o(2) = '1' and ((to_integer(unsigned(h)) > 563) and (to_integer(unsigned(h)) < 568)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
				
		elsif (timer_data_o(4) = '1' and ((to_integer(unsigned(h)) > 583) and (to_integer(unsigned(h)) < 588)) and ((to_integer(unsigned(v)) > 55) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
		
		elsif (timer_data_o(3) = '1' and ((to_integer(unsigned(h)) > 563) and (to_integer(unsigned(h)) < 588)) and ((to_integer(unsigned(v)) > 73) and (to_integer(unsigned(v)) < 78))) then
				timer_select <= '1';
		
		else
				timer_select <= '0';
		
		end if;
				
end process;
end behavioural;