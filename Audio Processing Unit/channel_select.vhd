library IEEE;
use IEEE.std_logic_1164.ALL;

entity channel_select is
   port(clk       : in  std_logic;
        reset     : in  std_logic;
        channel   : in  std_logic_vector(1 downto 0);
        note_in   : in  std_logic_vector(7 downto 0);
		  note_reset: in std_logic;
        note_out1 : out std_logic_vector(7 downto 0);
        note_out2 : out std_logic_vector(7 downto 0);
        note_out3 : out std_logic_vector(7 downto 0);
        note_out4 : out std_logic_vector(7 downto 0));
end channel_select;

architecture behaviour of channel_select is
	signal note1, note2, note3, note4, s_note1, s_note2, s_note3, s_note4 : std_logic_vector(7 downto 0);
begin

	process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' or note_reset = '1' then
				note1 <= "00000000";
				note2 <= "00000000";
				note3 <= "00000000";
				note4 <= "00000000";
			else
				note1 <= s_note1;
				note2 <= s_note2;
				note3 <= s_note3;
				note4 <= s_note4;
			end if;
		end if;
	end process;
			
	process(note_in, reset, note1, note2, note3, note4, channel) 
	begin	
		if channel = "00" then
			s_note1 <= note_in;
		else
			s_note1 <= note1;
		end if;
		if channel = "01" then
			s_note2 <= note_in;
		else
			s_note2 <= note2;
		end if;
		if channel = "10" then
			s_note3 <= note_in;
		else
			s_note3 <= note3;
		end if;
		if channel = "11" then
			s_note4 <= note_in;
		else
			s_note4 <= note4;
		end if;
end process;
note_out1	<= s_note1;
note_out2	<= s_note2;
note_out3	<= s_note3;
note_out4	<= s_note4;

end behaviour;
