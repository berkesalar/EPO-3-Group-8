library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.all;

entity uart_clk_gen_r is
   port(clk        : in  std_logic;
        reset      : in  std_logic;
        uart_clk   : out std_logic;
        sample_clk : out std_logic);
end uart_clk_gen_r;

architecture behaviour of uart_clk_gen_r is
	signal clk_cnt, new_clk_cnt : unsigned (9 downto 0);
begin

reg: process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				clk_cnt <= to_unsigned(0, clk_cnt'length);
			else
				clk_cnt <= new_clk_cnt;
			end if;
		end if;
	end process;

comb: process(clk_cnt)
	begin 
		if clk_cnt = to_unsigned(800, clk_cnt'length) then  --25000000 / 31250 = 800
			new_clk_cnt <= to_unsigned(0, clk_cnt'length);
			uart_clk <= '1';
			sample_clk <= '0';
		else
			uart_clk <= '0';
			new_clk_cnt <= clk_cnt + 1;
			if clk_cnt = to_unsigned(400, clk_cnt'length) then
				sample_clk <= '1';
			else
				sample_clk <= '0';
			end if;
		end if;
	end process;
end behaviour;
