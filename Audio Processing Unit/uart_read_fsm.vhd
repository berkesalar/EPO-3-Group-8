library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity uart_read_fsm is
   port(reset          : in  std_logic;
        clk            : in  std_logic;
        serial         : in  std_logic;
		uart_clk			   : in  std_logic;
        sample_clk     : in  std_logic;
		  note_reset : in std_logic;
        parallel       : out std_logic_vector(7 downto 0);
        uart_clk_reset : out std_logic;
        data_ready     : out std_logic);
end uart_read_fsm;

architecture behaviour of uart_read_fsm is
	type read_state is  (idle, start1, start2, next_bit, waiting, sample, store, done);
	signal state, new_state : read_state;
	signal	bitcount, new_bitcount : unsigned(2 downto 0);
	signal s_parallel, w_parallel : std_logic_vector(7 downto 0);
begin

process(clk)
begin
	if rising_edge(clk) then
		if reset = '1' or note_reset = '1' then
			state <= idle;
			bitcount <= to_unsigned(7,bitcount'length);
			w_parallel <= "00000000";
		else
			state <= new_state;
			bitcount <= new_bitcount;
			w_parallel <= s_parallel;
		end if;
	end if;
end process;

process(serial, sample_clk, uart_clk, state, bitcount, w_parallel)
begin
	case state is 
		when idle => 
			if serial = '0' then
				new_state <= start1;
			else
				new_state <= idle;
			end if;
			new_bitcount <= to_unsigned(0,new_bitcount'length);
			s_parallel <= "00000000";
			uart_clk_reset <= '1';
			data_ready <= '0';

		 when start1 => 
			new_state <= start2;
			new_bitcount <= to_unsigned(0,new_bitcount'length);
			s_parallel <= "00000000";
			uart_clk_reset <= '1';
			data_ready <= '0';

		when start2 => 
			if uart_clk = '1' then
				new_state <= waiting;
			else
				new_state <= start2;
			end if;
			new_bitcount <= to_unsigned(0,new_bitcount'length);
			s_parallel <= "00000000";
			uart_clk_reset <= '0';
			data_ready <= '0';

		when next_bit => 
			new_state <= waiting;
			new_bitcount <= bitcount + 1;
			s_parallel <= w_parallel;
			uart_clk_reset <= '0';
			data_ready <= '0';

		when waiting => 
			if sample_clk = '1' then
				new_state <= sample;
			else
				new_state <= waiting;
			end if;
			new_bitcount <= bitcount;
			s_parallel <= w_parallel;
			uart_clk_reset <= '0';
			data_ready <= '0';
	
		when sample => 
			new_state <= store;
			new_bitcount <= bitcount;
			s_parallel <= w_parallel;
			s_parallel(to_integer(bitcount)) <= serial;
			uart_clk_reset <= '0';
			data_ready <= '0';

		when store => 
			if uart_clk = '1' then
				if bitcount = to_unsigned(7,bitcount'length) then
					new_state <= done;
				else
					new_state <= next_bit;
				end if;
			else 
				new_state <= store;
			end if;
			new_bitcount <= bitcount;
			s_parallel <= w_parallel;
			uart_clk_reset <= '0';
			data_ready <= '0';

		when done =>
			new_state <= idle;
			new_bitcount <= to_unsigned(0,new_bitcount'length);
			s_parallel <= w_parallel;
			uart_clk_reset <= '0';
			data_ready <= '1';

	end case;
end process;	
parallel <= s_parallel;			
		
end behaviour;
