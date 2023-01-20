library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of acceleration_y is
	type acc_y_state is (GROUND,START_JUMP, AIR);
	signal state, new_state: acc_y_state;
	--signal Acceleration_y_temp: std_logic_vector(10 downto 0);

begin
	lbl1: process(clk, reset, enable_acc)
	begin
		if reset = '1' then
			state <= GROUND;
		elsif(clk'event and clk= '1' and enable_acc='1') then
			state <= new_state;
		end if;
	end process;

	lbl2: process(state, A, Collision_Down, kill)
	begin
		Acceleration_y <= "00000000000";
		case state is
			when GROUND =>
				Acceleration_y <= "00000000000";
				jump <= '0';
				airborne <= '0';
				if(Collision_Down = '1') then
					if(A='1') then
						new_state <= START_JUMP;
					else
						new_state <= GROUND;
					end if;
				else 
					new_state <= AIR;
				end if;

			when START_JUMP =>
				Acceleration_y <= "10000000001";
				airborne <= '1';
				jump <= '1';
				new_state <= AIR;
				
		
			when AIR =>
				jump <= '0';
				airborne <= '1';
				if(kill='1') then
					Acceleration_y <= "11000000001";
				else
					if(A= '1') then
						Acceleration_y <= "00000011110";
					else
						Acceleration_y <= "00001100000";
					end if;
				end if;

				if(collision_Down = '1') then
					new_state <= GROUND;
				else
					new_state <= AIR;
				end if;
		end case;
	end process;
end behaviour;

