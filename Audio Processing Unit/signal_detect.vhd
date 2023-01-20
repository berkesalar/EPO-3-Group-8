library IEEE;
use IEEE.std_logic_1164.ALL;

entity signal_detect is
   port(clk    : in  std_logic;
        reset  : in  std_logic;
        input  : in  std_logic;
        output : out std_logic);
end signal_detect;

architecture behaviour of signal_detect is
	signal intermediate : std_logic;
begin
	process(clk)
	begin
	if rising_edge(clk)	then
		if reset = '1' then
			intermediate <= '0';
		elsif input = '1' then
			intermediate <= '1';
		else 
			intermediate <= intermediate;
		end if;
	end if;
	end process;
output <= intermediate;
end behaviour;

