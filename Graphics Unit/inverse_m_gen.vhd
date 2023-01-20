library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity inverse_m_address_gen is
   port(h             : in  std_logic_vector(9 downto 0);
        v             : in  std_logic_vector(9 downto 0);
        x             : in  std_logic_vector(8 downto 0);
        y             : in  std_logic_vector(7 downto 0);
        mario_address : out std_logic_vector(7 downto 0));
end inverse_m_address_gen;

architecture behavioural of inverse_m_address_gen is

	signal h_n: std_logic_vector (8 downto 0);
	signal v_n: std_logic_vector (8 downto 0);

	signal x_range: std_logic_vector (9 downto 0);
	signal y_range: std_logic_vector (9 downto 0);

	signal multiplier: std_logic_vector (13 downto 0):= "00000000000000";
	signal temp: std_logic_vector (13 downto 0):= "00000000000000";
	constant a: unsigned := "10000";

	constant reflect: unsigned:= "1111";

begin

	h_n <= h(9 downto 1);
	v_n <= v(9 downto 1);
	multiplier <= std_logic_vector((unsigned(v_n) - unsigned(y))* a);
			temp <= std_logic_vector( (reflect - (unsigned(h_n) - unsigned(x))) +unsigned(multiplier));
	

	process(h_n,v_n, x, y, temp(7 downto 0))
	begin
		if ( (h_n >= x and h_n < std_logic_vector(unsigned(x)+16)) and(v_n >= ('0' & y) and v_n < std_logic_vector(unsigned('0' & y)+16 ))) then
			
			mario_address <= temp(7 downto 0);
		else
			mario_address <= "00001100";
		end if;
				
	end process;
end architecture;

