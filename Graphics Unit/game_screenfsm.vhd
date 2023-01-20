library IEEE;
use IEEE.std_logic_1164.ALL;

entity game_screenfsm is
   port(clk		: in std_logic;
	reset	: in std_logic;
	forw     : in  std_logic;
        lose     : in  std_logic;
        win      : in  std_logic;
        game_sel : out std_logic);
end game_screenfsm;

architecture behavioural of game_screenfsm is

type screens_state is (resetstate, screen_state, game_state);
signal state, new_state : screens_state;

begin

sequential: process (clk)
	begin
		if (rising_edge (clk)) then
			if (reset = '1') then
				state <= resetstate;
			else
				state <= new_state;
			end if;
		end if;
	end process;
	
combinatorial: process(forw,lose,win, reset, state)
begin
	case state is
		when resetstate =>	
			game_sel <= '0';
			
			if(forw = '0') then
				new_state <= game_state;
			else
				new_state <= state;
			end if;

		when game_state =>	
			game_sel <= '1';
			
			if(reset = '1') then
				new_state <= resetstate;
			elsif(win = '1' OR lose = '1') then
				new_state <= screen_state;
			else
				new_state <= state;
			end if;

		when screen_state =>	
			game_sel <= '0';
			
			if(reset = '1') then
				new_state <= resetstate;
			else
				new_state <= state;
			end if;
			
	end case;
end process;

end behavioural;


