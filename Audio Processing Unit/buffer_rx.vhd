library IEEE;
use IEEE.std_logic_1164.ALL;

entity buffer_rx is
   port(clk    : in  std_logic;
        input  : in  std_logic;
        output : out std_logic);
end buffer_rx;
  
architecture behaviour of buffer_rx is

signal intermediate : std_logic;

begin
process(clk)
begin
	if rising_edge(clk) then
		intermediate <= input;
		output <= intermediate;
	end if;
end process;

end behaviour;
