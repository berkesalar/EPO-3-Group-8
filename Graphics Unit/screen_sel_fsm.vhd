library IEEE;
use IEEE.std_logic_1164.ALL;

entity screen_sel_fsm is
   port(clk		: in std_logic;
	dead    : in  std_logic;
        victory : in  std_logic;
        reset   : in  std_logic;
        lose    : out std_logic;
        win     : out std_logic;
        restart : out std_logic);
end screen_sel_fsm;

architecture behavioural of screen_sel_fsm is

type screen_state is (resetstate, win_state, lose_state);
signal state, new_state : screen_state;

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
	
combinatorial: process(dead, victory, reset, state)
begin
	case state is
		when resetstate =>	
			restart <= '1';
			lose <= '0';
			win <= '0';
			
			if(dead = '1') then
				new_state <= lose_state;
			elsif(victory = '1') then
				new_state <= win_state;
			else
				new_state <= state;
			end if;

		when lose_state =>	
			restart <= '0';
			lose <= '1';
			win <= '0';
			
			if(reset = '1') then
				new_state <= resetstate;
			else
				new_state <= state;
			end if;

		when win_state =>	
			restart <= '0';
			lose <= '0';
			win <= '1';
			
			if(dead = '1') then
				new_state <= lose_state;
			elsif(reset = '1') then
				new_state <= resetstate;
			else
				new_state <= state;
			end if;
			
	end case;
end process;

end behavioural;

