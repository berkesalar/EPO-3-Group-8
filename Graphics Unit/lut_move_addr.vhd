library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity lut_move_addr is
   port(h       : in  std_logic_vector(9 downto 0);
        v       : in  std_logic_vector(9 downto 0);
	x_shift : in std_logic_vector(11 downto 0);
        address : out std_logic_vector(11 downto 0));
end lut_move_addr;


architecture behavioural of lut_move_addr is

	signal h_out_temp: std_logic_vector(9 downto 0);
	signal h_out: std_logic_vector (4 downto 0):= (others => '0');
	signal v_out: std_logic_vector (4 downto 0):= (others => '0');
	signal start_address : std_logic_vector(11 downto 0);
	signal multiplier: std_logic_vector(12 downto 0);
	signal temp: std_logic_vector (12 downto 0);
	--signal x_shift_blocks: std_logic_vector(12 downto 0);
	signal x_shift_interval: std_logic_vector(4 downto 0);
	constant a: unsigned := "11010010"; --210 (length of map + 1)
begin
	start_address <= "0000" & x_shift(11 downto 4);
	--x_shift_blocks <= x_shift & '0';
	x_shift_interval <= x_shift(3 downto 0) & '0';
	-- x_shift_interval <= std_logic_vector(unsigned(x_shift_blocks) - unsigned("100000" * unsigned(x_shift(9 downto 4))));
	h_out_temp <= std_logic_vector( unsigned(x_shift_interval)+ unsigned(h));
	h_out <= h_out_temp(9 downto 5);
	v_out <= v(9 downto 5);
	multiplier <= std_logic_vector(unsigned(v_out) * a);
	temp <= (std_logic_vector(unsigned(multiplier)+unsigned(h_out)+ unsigned(start_address) + 1));
	address <= temp(11 downto 0);
	


end architecture;
