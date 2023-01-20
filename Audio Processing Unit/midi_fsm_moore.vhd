library IEEE;
use IEEE.std_logic_1164.ALL;

entity midi_fsm_m is
   port(clk         : in  std_logic;
        reset       : in  std_logic;
        read_done   : in  std_logic;
        midi_signal : in  std_logic_vector(7 downto 0);
		  note_reset : in std_logic;
        wavechannel : out std_logic_vector(1 downto 0);
        dutycycle   : out std_logic_vector(1 downto 0);
        volume      : out std_logic_vector(3 downto 0);
        note        : out std_logic_vector(6 downto 0));
end midi_fsm_m;

architecture behaviour of midi_fsm_m is
	type interpret_state is (idle, note_on, note_off, key, waiting, velocity);
	signal state, new_state : interpret_state;
	signal buff_signal : std_logic_vector(7 downto 0);
	signal w_wavechannel, s_wavechannel : std_logic_vector(1 downto 0);
	signal w_note, s_note : std_logic_vector(6 downto 0);
	signal w_dutycycle, s_dutycycle : std_logic_vector(1 downto 0);
	signal w_volume, s_volume : std_logic_vector(3 downto 0);
begin
	reg: process(clk)
	begin
		if rising_edge(clk) then
			if reset = '1' or note_reset = '1' then
				state <= idle;
				buff_signal <= "00000000";
				w_wavechannel <= "00";
				w_note <= "0000000";
				w_dutycycle <= "00";
				w_volume <= "0000";
			else 
				state <= new_state;
				w_wavechannel <= s_wavechannel;
				w_note <= s_note;
				w_dutycycle <= s_dutycycle;
				w_volume <= s_volume;
				if read_done = '1' then
					buff_signal <= midi_signal;
				else
					buff_signal <= buff_signal;
				end if;
			end if;
		end if;
	end process;

	comb: process(state, buff_signal, w_wavechannel, w_note, w_volume, w_dutycycle, read_done)
	begin
		case state is
				
			when idle => 
				if buff_signal(7 downto 4) = "1001" then
					new_state <= note_on;
				elsif buff_signal(7 downto 4) = "1000" then
					new_state <= note_off;
				else
					new_state <= idle;
				end if;
				s_wavechannel <= w_wavechannel;
				s_note <= w_note;
				s_dutycycle <= w_dutycycle;
				s_volume <= w_volume;

			when note_on =>
				if read_done = '1' then
					new_state <= key;
				else
					new_state <= note_on;
				end if;
				s_wavechannel <= buff_signal(1 downto 0);
				s_note <= w_note;
				s_dutycycle <= w_dutycycle;
				s_volume <= w_volume;
				
			when note_off =>	
				if read_done = '1' then
					new_state <= idle;
				else
					new_state <= note_off;
				end if;
				s_wavechannel <= buff_signal(1 downto 0); -- 00 pulse wave 1. 01 pulse wave 2, 10 triangle wave, 11 noise wave
				s_note <= "0000000";
				s_dutycycle <= w_dutycycle;
				s_volume <= w_volume;
		
			when key =>
				if w_wavechannel = "00" then
					new_state <= waiting;
				else
					new_state <= idle;
				end if;
				s_wavechannel <= w_wavechannel;
				s_note <= buff_signal(6 downto 0);
				s_dutycycle <= w_dutycycle;
				s_volume <= w_volume;
		
			when waiting =>
				if read_done = '1' then
					new_state <= velocity;
				else
					new_state <= waiting;
				end if;
				s_wavechannel <= w_wavechannel;
				s_note <= w_note;
				s_dutycycle <= w_dutycycle;
				s_volume <= w_volume;

			when velocity =>
				new_state <= idle;
				s_note <= w_note;
				s_wavechannel <= w_wavechannel;
				s_dutycycle <= buff_signal(5 downto 4);
				s_volume <= buff_signal(3 downto 0);

		end case;
	end process;
wavechannel <= s_wavechannel;
note <= s_note;
dutycycle <= s_dutycycle;
volume <= s_volume;
end behaviour;
