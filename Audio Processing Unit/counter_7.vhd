library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--8-bit counter with increment signal for counting the period of the notes
entity counter_8 is
    port(
        clk: in std_logic;
        reset: in std_logic;
        count_reset: in std_logic;
        increment: in std_logic;
        count: out std_logic_vector(7 downto 0));
end entity;

architecture behavioural of counter_8 is
	signal count_0: unsigned(7 downto 0);
begin
	
	--8-bit counter with increment
	process(clk, reset)
	begin
		if(rising_edge(clk)) then
			if(reset = '1' or count_reset = '1') then
				count_0 <= (others => '0');
			elsif(increment = '1') then
				count_0 <= count_0 + 1;
			else
				count_0 <= count_0;
			end if;
		end if;
	end process;
	
	count <= std_logic_vector(count_0);
	
end architecture behavioural;
