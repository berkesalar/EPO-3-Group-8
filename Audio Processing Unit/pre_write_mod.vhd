library IEEE;
use IEEE.std_logic_1164.ALL;

entity pre_write_mod is
   port(clk          : in  std_logic;
        reset        : in  std_logic;
        music_id     : in  std_logic_vector(2 downto 0);
        sfx          : in  std_logic_vector(1 downto 0);
        enable       : in  std_logic;
        music_change : out std_logic;
        sfx_change   : out std_logic;
        music_out    : out std_logic_vector(2 downto 0);
        sfx_out      : out std_logic_vector(1 downto 0));
end pre_write_mod;
  
architecture behaviour of pre_write_mod is


signal s1, s2 : std_logic_vector(2 downto 0);
signal s3, s4 : std_logic_vector(1 downto 0);

begin

process(clk)
begin
	if rising_edge(clk) then
		if enable = '1' then 
			s1 <= music_id;
			s2 <= s1;
			s3 <= sfx;
			s4 <= s3;
		else
			s1 <= s1;
			s2 <= s2;
			s3 <= s3;
			s4 <= s4;
		end if;
	end if;
end process;
process(s1, s2, s3, s4)
begin
	if s1 /= s2 then
		music_change <= '1';
	else
		music_change <= '0';
	end if;
	if s3 /= s4 then
		sfx_change <= '1';
	else	
		sfx_change <= '0';
	end if;
end process;
music_out <= s1;
sfx_out <= s3;
end behaviour;
