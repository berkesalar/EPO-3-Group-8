library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--5-bit counter with increment signal for creating the phase signal for the triangle module
entity counter_5 is
    port(
        clk: in std_logic;
        reset: in std_logic;
		increment: in std_logic;
		clk_divided: in std_logic;
        count: out std_logic_vector(4 downto 0));
end entity;

architecture behavioural of counter_5 is
	signal count_0: unsigned(4 downto 0);
begin
	
	--5-bit counter with increment
	process(clk, reset, increment)
	begin
		if(reset = '1') then
			count_0 <= (others => '0');
		elsif(rising_edge(clk)) then
			if(increment = '1') then
				count_0 <= count_0 + 1;
			else
				count_0 <= count_0;
			end if;
		end if;
	end process;
	
	count <= std_logic_vector(count_0);
	
end architecture behavioural;