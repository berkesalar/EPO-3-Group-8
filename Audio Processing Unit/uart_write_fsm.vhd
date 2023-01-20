library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity uart_write_fsm is
   port(clk            : in  std_logic;
        reset          : in  std_logic;
        uart_clk       : in  std_logic;
        sfx            : in  std_logic_vector(1 downto 0);
        music_id       : in  std_logic_vector(2 downto 0);
        sfx_change     : in  std_logic;
        music_change   : in  std_logic;
        serial         : out std_logic;
        uart_clk_reset : out std_logic;
        write_done     : out std_logic);
end uart_write_fsm;

architecture behaviour of uart_write_fsm is
	type write_state is (idle, start, next_bit, write, stop_bit);
	signal new_state, state : write_state;
	signal w_serial, s_serial : std_logic;
	signal bitcount, new_bitcount : unsigned(3 downto 0);
	signal parallel : std_logic_vector(3 downto 0);
begin
process(clk)
begin
	if rising_edge(clk) then
		if reset = '1' then
			state <= idle;
			bitcount <= to_unsigned(0, bitcount'length);
			w_serial <= '1';
			parallel <= "0000";
		else
			state <= new_state;
			bitcount <= new_bitcount;
			w_serial <= s_serial;
			if music_change = '1' then
				parallel <= '0' & music_id;
			elsif sfx_change = '1' then
				parallel <= "11" & sfx;
			else 
				parallel <= parallel;
			end if;
		end if;
	end if;
end process;

process(parallel, music_change, sfx_change, uart_clk, state, bitcount, w_serial)
begin
	case state is
		when idle => 
			if (sfx_change = '1' or music_change = '1') then
				new_state <= start;
			else
				new_state <= idle;
			end if;
			new_bitcount <= to_unsigned(8, new_bitcount'length);
			uart_clk_reset <= '1';
			s_serial <= '1';
			write_done <= '1';

		when start => 
			if uart_clk = '1' then
				new_state <= next_bit;
			else
				new_state <= start;
			end if;
			new_bitcount <= to_unsigned(8, new_bitcount'length);
			uart_clk_reset <= '0';
			s_serial <= '0';
			write_done <= '0';

		when next_bit => 
			new_state <= write;
			new_bitcount <= bitcount-1;
			uart_clk_reset <= '0';
			s_serial <= w_serial;
			write_done <= '0';

		when write => 
			if uart_clk = '1' then
				if bitcount = to_unsigned(0, bitcount'length) then
					new_state <= stop_bit;
				else
					new_state <= next_bit;
				end if;
			else
				new_state <= write;
			end if;
			new_bitcount <= bitcount;
			uart_clk_reset <= '0';
			if bitcount <= to_unsigned(3, bitcount'length) then
				s_serial <= parallel(to_integer(bitcount));
			else
				s_serial <= '1';
			end if;
			write_done <= '0';
		
		when stop_bit =>
			if uart_clk = '1' then
				new_state <= idle;
			else 
				new_state <= stop_bit;
			end if;
			new_bitcount <= to_unsigned(8, bitcount'length);
			uart_clk_reset <= '0';
			s_serial <= '1';
			write_done <= '0';
	end case;
end process;
serial <= s_serial;
end behaviour;
