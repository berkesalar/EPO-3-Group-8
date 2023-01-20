library IEEE;
use IEEE.std_logic_1164.ALL;

entity music_select is
   port(clk,reset    : in  std_logic;
        start    : in  std_logic;
        win      : in  std_logic;
        death    : in  std_logic;
        music_id : out std_logic_vector(2 downto 0));
end music_select;

architecture behaviour of music_select is
signal music_id_int : std_logic_vector(2 downto 0);
begin
process(clk,win,death,start,reset, music_id_int)
begin
	if rising_edge(clk) then
	if reset = '1' then
		music_id_int <= "111";
	elsif win = '1' then
		music_id_int <= "100";  --win muziek
	elsif death = '1' then
		music_id_int <= "011";  --game over muziek
	
	elsif start = '1' then
		music_id_int <= "001";  --standard muziek
	elsif reset = '0' then 
		music_id_int <= "000";
	else
		music_id_int <= music_id_int; 
	end if;
	end if;
end process;
music_id <= music_id_int;
end behaviour;
