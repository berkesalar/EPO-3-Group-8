library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

architecture behavioural of enemies_fsm is

type enemies_state is (transparentstate, brownstate, blackstate, yellowstate);
signal state, newstate : enemies_state;


begin

sequential: process (clk)
	begin
		if (rising_edge (clk)) then
			if (reset = '1') then
				state <= transparentstate;
			else
				state <= newstate;
			end if;
		end if;
	end process;
	
--1= colour and 0= transparent------------------
-- 00 = transparent 01 = brown (630) 10 = yellow (FF9) 11 = black (000)
combinatorial: process(enemies_lut_data, state)
begin
	case state is
		when brownstate =>
			red <= X"6"; 
			green <= X"3";
			blue <= X"0";
			enemies_sel_bit <= '1';
			
			if (enemies_lut_data = "00") then
				newstate <= transparentstate;
			elsif (enemies_lut_data = "10") then
				newstate <= yellowstate;
			elsif (enemies_lut_data = "11") then
				newstate <= blackstate;
			else 
				newstate <= brownstate;
			end if;
			
		when transparentstate =>				-- transparentstate--
			red <= (others => '0');
			green <= (others => '0');
			blue <= (others => '0');
			enemies_sel_bit <= '0';
			
			if (enemies_lut_data = "01") then
				newstate <= brownstate;
			elsif (enemies_lut_data = "11") then
				newstate <= blackstate;
			elsif (enemies_lut_data = "10") then
				newstate <= yellowstate;
			else 
				newstate <= transparentstate;
			end if;
		
		when blackstate =>
			red <= x"0";
			green <= X"0";
			blue <= X"0";
			enemies_sel_bit <= '1';
			
			if (enemies_lut_data = "01") then
				newstate <= brownstate;
			elsif (enemies_lut_data = "00") then
				newstate <= transparentstate;
			elsif (enemies_lut_data = "10") then
				newstate <= yellowstate;
			else 
				newstate <= blackstate;
			end if;

		when others =>  --yellowstate
			red <= X"F";
			green <= X"F";
			blue <= X"9";
			enemies_sel_bit <= '1';
			
			if (enemies_lut_data = "01") then
				newstate <= brownstate;
			elsif (enemies_lut_data = "11") then
				newstate <= blackstate;
			elsif (enemies_lut_data = "00") then
				newstate <= transparentstate;
			else 
				newstate <= yellowstate;
			end if;

	end case;
end process;
end behavioural;
