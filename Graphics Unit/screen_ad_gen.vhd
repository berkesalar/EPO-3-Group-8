library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity screen_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        lose             : in  std_logic;
        win             : in  std_logic;
	restart		: in std_logic;
        mario_address : out std_logic_vector(7 downto 0));
end screen_address_gen;

architecture behavioural of screen_address_gen is

	signal h_n: std_logic_vector (7 downto 0);
	signal v_n: std_logic_vector (7 downto 0);


	signal multiplier: std_logic_vector (13 downto 0):= "00000000000000";
	signal temp: std_logic_vector (13 downto 0):= "00000000000000";

	signal y_d, x_d: std_logic_vector(7 downto 0);
	signal width: std_logic_vector(5 downto 0);



begin

	
	process(lose,win,restart)
	begin
		if(lose = '1') then
			x_d <= "00111100"; 
			width <= "101110"; -- 46
		elsif(win = '1') then
			x_d <= "01001000"; --
			width <= "010001"; -- 17
		else --when restart is 1
			x_d <= "01000100"; -- 
			width <= "011100"; -- 28
		end if;
	end process;
	
	y_d <= "00111000";
	h_n <= h(9 downto 2);
	v_n <= v(9 downto 2);
	multiplier <= std_logic_vector((unsigned(v_n) - (unsigned(y_d)))* unsigned(width));
	temp <= std_logic_vector( ((unsigned(h_n) - (unsigned(x_d)))) + unsigned(multiplier));
	

	process(h_n,v_n,x_d,width,y_d, temp(7 downto 0))
	begin
		if ( (h_n >= (x_d) and h_n < std_logic_vector(unsigned(x_d)+ unsigned(width))) and(v_n >= (y_d) and v_n < std_logic_vector(unsigned(y_d)+5 ))) then
			
			mario_address <= temp(7 downto 0);
		else
			mario_address <= "11111111";
		end if;
				
	end process;
end architecture;
