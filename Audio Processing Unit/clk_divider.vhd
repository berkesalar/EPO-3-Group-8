library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--a 10-bit counter for creating a slower clock
entity clk_divider is
    port(
        clk: in std_logic;
        reset: in std_logic;
        clk_divided: out std_logic);
end entity;

architecture behavioural of clk_divider is
	signal count_0: unsigned(9 downto 0);
begin
	
	--10-bit counter
	process(clk, reset)
	begin
		if(reset = '1') then
			count_0 <= (others => '0');
		elsif(rising_edge(clk)) then
			if(count_0 = to_unsigned(993,10)) then
				count_0 <= (others => '0');
			else 
			count_0 <= count_0 + 1;
			end if;
		end if;
	end process;

	--creating the slower clock every 993 clock cycles
	process(count_0)
	begin
		if(count_0 = to_unsigned(993,10)) then
			clk_divided <= '1';
		else
			clk_divided <= '0';
		end if;
	end process;
	
end architecture behavioural;
