
library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity Mario_fsm is
	port(
	clk          : in  std_logic;
    reset        : in  std_logic;
	mario_lut_data	: in std_logic_vector(1 downto 0);			
	red          : out std_logic_vector(3 downto 0);
    green        : out std_logic_vector(3 downto 0);
    blue         : out std_logic_vector(3 downto 0);
	mario_select_bit	 : out std_logic);
end Mario_fsm;

architecture behavioural of Mario_fsm is

type mario_state is (transparentstate, redstate, darkstate, skinstate);
signal state, newstate : mario_state;

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
	
--1= red and 0= transparent------------------

combinatorial: process(mario_lut_data, state)
begin
	case state is
		when redstate =>
			red <= X"F"; -- FF0000
			green <= X"0";
			blue <= X"0";
			mario_select_bit <= '1';
			
			if (mario_lut_data = "01") then
				newstate <= redstate;
			elsif (mario_lut_data = "11") then
				newstate <= skinstate;
			elsif (mario_lut_data = "10") then
				newstate <= darkstate;
			else 
				newstate <= transparentstate;
			end if;
			
		when transparentstate =>				-- transparentstate--
			red <= (others => '0');
			green <= (others => '0');
			blue <= (others => '0');
			mario_select_bit <= '0';
			
			if (mario_lut_data = "01") then
				newstate <= redstate;
			elsif (mario_lut_data = "11") then
				newstate <= skinstate;
			elsif (mario_lut_data = "10") then
				newstate <= darkstate;
			else 
				newstate <= transparentstate;
			end if;
		
		when darkstate =>
			red <= x"0";
			green <= X"0";
			blue <= X"0";
			mario_select_bit <= '1';
			
			if (mario_lut_data = "01") then
				newstate <= redstate;
			elsif (mario_lut_data = "11") then
				newstate <= skinstate;
			elsif (mario_lut_data = "10") then
				newstate <= darkstate;
			else 
				newstate <= transparentstate;
			end if;

		when others =>  --skinstate--
			red <= X"F";
			green <= X"C";
			blue <= X"9";
			mario_select_bit <= '1';
			
			if (mario_lut_data = "01") then
				newstate <= redstate;
			elsif (mario_lut_data = "11") then
				newstate <= skinstate;
			elsif (mario_lut_data = "10") then
				newstate <= darkstate;
			else 
				newstate <= transparentstate;
			end if;

	end case;
end process;
end behavioural;
