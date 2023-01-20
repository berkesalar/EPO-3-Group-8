library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--6-bit counter for the sampling period of the PWM generator
entity counter_6 is
    port(
        clk: in std_logic;
        reset: in std_logic;
        count: out std_logic_vector(5 downto 0));
end entity;

architecture behavioural of counter_6 is
	signal count_0: unsigned(5 downto 0);
begin
	
	--6-bit counter with increment
	process(clk, reset)
	begin
		if(reset = '1') then
			count_0 <= (others => '0');
		elsif(rising_edge(clk)) then
				count_0 <= count_0 + 1;
		end if;
	end process;
	
	count <= std_logic_vector(count_0);
	
end architecture behavioural;