library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity blk_address_gen is
   port(clk			: in std_logic;
	reset				: in std_logic;
	h             : in  std_logic_vector(9 downto 0);
	v	     : in std_logic_vector(9 downto 0);
	x_shift		: in std_logic_vector(11 downto 0); --CHANGE TO CORRECT LENGTH
        blk_address : out std_logic_vector(7 downto 0));
	
end blk_address_gen;

architecture behavioural of blk_address_gen is

	signal h_out,v_out: std_logic_vector (8 downto 0):= (others => '0');
	signal h_multiplier, v_multiplier: std_logic_vector(10 downto 0);
	signal h_temp,v_temp, h_temp_shifted: std_logic_vector(10 downto 0);
	signal blk_temp: std_logic_vector(10 downto 0);
	signal blk_out: std_logic_vector(8 downto 0);
	signal h_cnt, new_h_cnt, v_cnt, new_v_cnt: std_logic_vector(5 downto 0);
	signal h_factor, v_factor,h_factor_start: std_logic_vector(3 downto 0);
	signal shift_factor: std_logic_vector(9 downto 0);
	signal shift_factor_temp: std_logic_vector(12 downto 0);

	signal x_shift_shifted: std_logic_vector(7 downto 0);
begin

	x_shift_shifted <= x_shift(11 downto 4);
	shift_factor_temp <= std_logic_vector(unsigned(x_shift) - ("10000" * unsigned(x_shift_shifted)));
	shift_factor <= shift_factor_temp(9 downto 0);
	
	counter_h: process(clk, reset, h_cnt, h)
	begin
	if(rising_edge(clk)) then
		if(reset = '1') then
			h_cnt <= (others => '0');
		elsif(h = "0000000000") then
			h_cnt <= "000001";
		else
			h_cnt <= new_h_cnt;
		end if;
	end if;
	end process;
	
	counter_v: process(clk, reset, v_cnt, v)
	begin
	if(rising_edge(clk)) then
		if(reset = '1') then
			v_cnt <= (others => '0');
		elsif(v = "0000000000") then
			v_cnt <= "000001";
		else
			v_cnt <= new_v_cnt;
		end if;
	end if;
	end process;
			
			
	


	generator: process(h,v, h_cnt, shift_factor, h_out, h_multiplier, h_temp, h_temp_shifted, v_cnt, v_out, v_multiplier, v_temp, h_factor, v_factor, blk_out(7 downto 0))
	begin
	
		

		h_out <= h(9 downto 1);
		h_multiplier <= std_logic_vector((unsigned(h_cnt)-1)* "10000"); --32

		
		h_temp <= std_logic_vector(unsigned(shift_factor) + unsigned(h_out) - (unsigned(h_multiplier)));

		h_temp_shifted <= h_temp;

		
		
		if(h_cnt = "010100") then
			if(h_temp_shifted = std_logic_vector("00000010000" - unsigned(shift_factor))) then
				new_h_cnt <= std_logic_vector(unsigned(h_cnt)+1);
			else
				new_h_cnt <= h_cnt;
			end if;
		elsif(h_temp_shifted = "00000010000") then
			new_h_cnt <= std_logic_vector(unsigned(h_cnt)+1);
		else	
			new_h_cnt <= h_cnt;
		end if;

		-- h_temp increments from 0 to 15 every 31 h pixels 2 by 2


		if (v = "0000000000") then
			new_v_cnt <= "000001";
		else
			v_cnt <= v_cnt;
		end if;

		v_out <= v(9 downto 1);
		v_multiplier <= std_logic_vector((unsigned(v_cnt)-1)* "10000");
		v_temp <= std_logic_vector(unsigned(v_out) - (unsigned(v_multiplier)));
		
		if(v_temp = "00000010000") then
			new_v_cnt <= std_logic_vector(unsigned(v_cnt)+1);
		else
			new_v_cnt <= v_cnt;
		end if;

		-- v_temp increments from 0 to 15 every 31 v pixels 2 by 2

		h_factor <= h_temp_shifted(3 downto 0);
		v_factor <= v_temp(3 downto 0);
		
		blk_out <= std_logic_vector(unsigned(h_factor)+(unsigned(v_factor) * "10000"));

		

		blk_address <= blk_out(7 downto 0);


		


	end process;

	

end architecture;


