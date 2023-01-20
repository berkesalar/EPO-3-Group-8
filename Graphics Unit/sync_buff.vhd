library IEEE;
use IEEE.std_logic_1164.ALL;

entity sync_buff is
   port(clk       : in  std_logic;
        reset     : in  std_logic;
        hsync_in  : in  std_logic;
        vsync_in  : in  std_logic;
        hsync_out : out std_logic;
        vsync_out : out std_logic);
end sync_buff;


architecture behaviour of sync_buff is

signal h,v  : std_logic;
begin
	process(clk,reset)
	begin
		if(rising_edge(clk)) then
			if (reset = '1') then
				hsync_out <= '0';
				hsync_out <= '0';
			else 
				hsync_out <= hsync_in;
				vsync_out <= vsync_in;
			end if;
		end if;
	end process;
end architecture;

