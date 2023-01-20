library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

architecture behavioural of en_address_gen is

	signal h_n: std_logic_vector (8 downto 0);
	signal v_n: std_logic_vector (8 downto 0);

	signal x_range: std_logic_vector (9 downto 0);
	signal y_range: std_logic_vector (9 downto 0);

	signal multiplier1: std_logic_vector (13 downto 0):= "00000000000000";
	signal temp1: std_logic_vector (13 downto 0):= "00000000000000";
	
	signal multiplier2: std_logic_vector (13 downto 0):= "00000000000000";
	signal temp2: std_logic_vector (13 downto 0):= "00000000000000";
	constant a: unsigned := "10000";

begin

	h_n <= h(9 downto 1);
	v_n <= v(9 downto 1);
	
	multiplier1 <= std_logic_vector((unsigned(v_n) - unsigned(y1))* a);
	temp1 <= std_logic_vector(unsigned(h_n) - unsigned(x1)+unsigned(multiplier1));
	
	multiplier2 <= std_logic_vector((unsigned(v_n) - unsigned(y2))* a);
	temp2 <= std_logic_vector(unsigned(h_n) - unsigned(x2)+unsigned(multiplier2));
			
	process(h_n,v_n, x1, y1, x2, y2, temp2(7 downto 0), temp1(7 downto 0))
	begin
		if ( (h_n >= x1 and h_n < std_logic_vector(unsigned(x1)+16)) and(v_n >= ('0' & y1) and v_n < std_logic_vector(unsigned('0' & y1)+16 ))) then
			
			enemies_address <= temp1(7 downto 0);
			s <= '1';
			
		elsif ( (h_n >= x2 and h_n < std_logic_vector(unsigned(x2)+16)) and(v_n >= ('0' & y2) and v_n < std_logic_vector(unsigned('0' & y2)+16 ))) then
		
			enemies_address <= temp2(7 downto 0);
			s <= '0';
		else
			enemies_address <= "00001100";
			s <= '1';
		end if;
				
	end process;
end architecture;
