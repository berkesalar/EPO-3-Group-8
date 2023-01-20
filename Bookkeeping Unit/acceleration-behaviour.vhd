library IEEE;
use ieee.numeric_std.all;
use IEEE.std_logic_1164.ALL;

architecture behaviour of acceleration_module is
	type acc_state is (STOP,START_LEFT, LEFT,START_RIGHT, RIGHT);
	signal state, new_state: acc_state;
	--signal Acceleration_temp: std_logic_vector(5 downto 0);
begin
	lbl1: process(clk, reset, enable_acc)
	begin
		
		if reset = '1' then
			state <= STOP;
		elsif(clk'event and clk = '1' and enable_acc='1') then
			state <= new_state;
		end if;
	end process;
	

	lbl2: process(state, L, R, B, airborne, Velocity, Collision_R, Collision_L)
	begin
		Acceleration <= "000000";
		case state is

			when STOP =>
				Acceleration <= "000000";
				if(L = '1' and Collision_L='0') then
					new_state <= START_LEFT;
				else if (R = '1' and collision_R = '0') then
					new_state <= START_RIGHT;
				else
					new_state <= STOP;
				end if;
				end if;
		
			when START_LEFT =>
				Acceleration <=  "101101";
				new_state <= LEFT;
				

			when LEFT =>
				if( signed(Velocity) > to_signed(-19,11) or Collision_L ='1') then
					new_state <= STOP;
				else
					new_state <= LEFT;
				end if;

				if(airborne='0') then
					if( L = '0' and R = '0') then
						Acceleration <= "001101";
					end if;
					if( L = '0' and R = '1') then
						Acceleration <= "011010";
					end if;
					if( L = '1' and R = '0' and B = '0') then
						Acceleration <= "110111";
					end if;
					if( L = '1' and R = '0' and B = '1') then
						Acceleration <= "110010";
					end if;
					if( L = '1' and R = '1') then
						Acceleration <= "110111";
					end if;
				else
					if(L='0' and R='1') then
						if(signed(Velocity) > to_signed(400,11))then
							Acceleration <= "001110";
						else
							Acceleration <= "001001";
						end if;
					else if(L='1' and R='0') then
						if(signed(Velocity) > to_signed(400,11))then
							Acceleration <= "110010";
						else
							Acceleration <= "110111";
						end if;
					else 
						Acceleration <= "000000";
					end if;
					end if;
				end if;

			when START_RIGHT =>
				Acceleration <=  "010011";
				new_state <= RIGHT;


			when RIGHT =>
				if(signed(Velocity) < to_signed(19, 11) or Collision_R ='1') then
					new_state <= STOP;
				else
					new_state <= RIGHT;
				end if;
			

				if (airborne ='0') then
					if( L = '0' and R = '0') then
						Acceleration <= "110011";
					end if;
					if( L = '1' and R = '0') then
						Acceleration <= "100110";
					end if;
					if( L = '0' and R = '1' and B = '0') then
						Acceleration <= "001001";
					end if;
					if( L = '0' and R = '1' and B = '1') then
						Acceleration <= "001110";
					end if;
					if( L = '1' and R = '1') then
						Acceleration <= "001001";
					end if;
				else
					if(L='0' and R='1') then
						if(signed(Velocity) > to_signed(400,11))then
							Acceleration <= "001110";
						else
							Acceleration <= "001001";
						end if;
					else if(L='1' and R='0') then
						if(signed(Velocity) > to_signed(400,11))then
							Acceleration <= "110010";
						else
							Acceleration <= "110111";
						end if;
					else 
						Acceleration <= "000000";
					end if;
					end if;
				end if;
		end case;

	end process;


end behaviour;

