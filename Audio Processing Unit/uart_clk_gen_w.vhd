library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity uart_clk_gen_w is
   port(clk      : in  std_logic;
        reset    : in  std_logic;
        uart_clk_w : out std_logic);
end uart_clk_gen_w;

architecture behaviour of uart_clk_gen_w is
	signal clk_cnt, new_clk_cnt : unsigned (9 downto 0);
	--signal clk_cnt, new_clk_cnt : integer;
begin

reg: process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				clk_cnt <= to_unsigned(0, clk_cnt'length);
				--clk_cnt <= 0;
			else
				clk_cnt <= new_clk_cnt;
			end if;
		end if;
	end process;

comb: process(clk_cnt)
	begin 
		if clk_cnt = to_unsigned(800, clk_cnt'length) then  --25000000 / 31250 = 800
		--if clk_cnt = 800 then  --25000000 / 31250 = 800
			new_clk_cnt <= to_unsigned(0, clk_cnt'length);
			--new_clk_cnt <= 0;
			uart_clk_w <= '1';
		else
			uart_clk_w <= '0';
			new_clk_cnt <= clk_cnt + 1;
		end if;
	end process;
end behaviour;

