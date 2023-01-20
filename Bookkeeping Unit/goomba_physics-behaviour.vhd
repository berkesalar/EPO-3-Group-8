library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

architecture behaviour of goomba_physics is
	type goombax_state is (LEFT, RIGHT, RESET_STATE, KILL_STATE);
	signal stateXG1, stateXG2, new_stateXG1, new_stateXG2, input_statex, output_statex: goombax_state;
	type goombay_state is (GROUND, AIR, RESET_STATE, KILL_STATE);
	signal stateYG1, stateYG2, new_stateYG1, new_stateYG2, input_statey, output_statey: goombay_state;

	type goomba_state is (G1, G2, hold1, hold2);
	signal state, new_state: goomba_state;


	signal XG1, XG2, new_XG1, new_XG2, input_x, output_x: unsigned(12 downto 0);
	signal YG1, YG2, new_YG1, new_YG2, input_y, output_y: unsigned(6 downto 0);
	signal x_translation: unsigned(10 downto 0);
	signal input_collision: std_logic_vector(2 downto 0);
	signal output_kill, killG1, killG2, new_killG1, new_killG2, new_ready_signal, new_lose, lose_temp, dead_goomba_done: std_logic;
	signal XG1_temp, XG2_temp: std_logic_vector(12 downto 0);
begin


	lbl1: process(clk, reset)
	begin
		if(reset='1') then
			stateXG1 <= LEFT;
			stateXG2 <= LEFT;
			stateYG1 <= GROUND;
			stateYG2 <= GROUND;
			YG1 <="1100000";
			YG2 <="1100000";
			XG1 <="0010000000000";
			XG2 <="0001000000000";
			killG1 <= '0';
			killG2 <= '0';
			ready_signal <= '0';
			lose_temp <= '0';
			state <= hold2;
		elsif(clk'event and clk = '1') then
			XG1 <= new_XG1;
			XG2 <= new_XG2;
			YG1 <= new_YG1;
			YG2 <= new_YG2;
			stateXG1 <= new_stateXG1;
			stateXG2 <= new_stateXG2;
			stateYG1 <= new_stateYG1;
			stateYG2 <= new_stateYG2;
			killG1 <= new_killG1;
			killG2 <= new_killG2;
			ready_signal <= new_ready_signal;
			lose_temp <= new_lose;
			state <= new_state;
		end if;
	end process;

	lbl2: process(state, XG1, XG2, YG1, YG2, stateXG1, stateXG2, stateYG1, stateYG2, killG1, killG2, collisionG1, collisionG2, output_x, output_y, output_statex, output_statey, XG1_temp, XG2_temp, output_kill, enable)
	begin
		new_XG1 <= XG1;
		new_XG2 <= XG2;
		new_YG1 <= YG1;
		new_YG2 <= YG2;
		new_stateXG1 <= stateXG1;
		new_stateXG2 <= stateXG2;
		new_stateYG1 <= stateYG1;
		new_stateYG2 <= stateYG2;
		new_killG1 <= killG1;
		new_killG2 <= killG2;

		case state is
			when G1 =>
				input_statex <= stateXG1;
				input_statey <= stateYG1;
				input_x <= XG1;
				input_y <= YG1;
				x_translation <= to_unsigned(700,11);
				input_collision <= collisionG1;
				new_XG1 <= output_x;
				new_YG1 <= output_y;
				new_stateXG1 <= output_statex;
				new_stateYG1 <= output_statey;
				new_killG1 <= output_kill;

				new_ready_signal <= '0';

				new_state<= G2;

			when G2 =>
				input_statex <= stateXG2;
				input_statey <= stateYG2;
				input_x <= XG2;
				input_y <= YG2;
				x_translation <= to_unsigned(1100,11);
				input_collision <= collisionG2;
				new_XG2 <= output_x;
				new_YG2 <= output_y;
				new_stateXG2 <= output_statex;
				new_stateYG2 <= output_statey;
				new_killG2 <= output_kill;
				new_ready_signal <= '0';
				
				new_state<= hold1;

			when hold1 =>
				input_statex <= LEFT;
				input_statey <= GROUND;
				input_x <= (others => '0');
				input_y <= (others => '0');
				x_translation <= to_unsigned(0,11);
				input_collision <= "000";
				new_ready_signal <= '1';
		
				if(enable ='0') then
					new_state<= hold2;
				else
					new_state <= hold1;
				end if;

			when hold2 =>
				input_statex <= LEFT;
				input_statey <= GROUND;
				input_x <= (others => '0');
				input_y <= (others => '0');
				x_translation <= to_unsigned(0,11);
				input_collision <= "000";
				new_ready_signal <= '1';

				if(enable ='1') then
					new_state<= G1;
				else
					new_state <= hold2;
				end if;
			
		end case;

	end process;


	lbl3: process(input_statex, input_statey, input_x, input_y, input_collision, x_translation, mario_x, mario_y, lose_temp, dead_goomba_done, x_cam)
	variable input_y2: std_logic_vector(7 downto 0);
	variable input_x2: std_logic_vector(11 downto 0);
	begin
		new_lose <= lose_temp;
		output_statex <= input_statex;
		output_statey <= input_statey;
		output_y <= input_y;
		output_x <= input_x;
		input_x2 := std_logic_vector(input_x(12 downto 1));
		input_y2 := std_logic_vector(input_y)&'0';

		if ((input_x2-12 < mario_x and mario_x < input_x2+16 and input_y2-16 < mario_y and mario_y < input_y2+16)) then
			output_kill <= '1';
			output_statex<=KILL_STATE;
			output_statey<=KILL_STATE;
			if(mario_y > input_y2-10) then
				new_lose<= '1';
			end if;
				

		else	
			output_kill <= '0';
			case input_statex is
				when LEFT =>
					output_x <= input_x-1;
					if(input_collision(0)= '1') then
						output_statex <= RIGHT;
					end if;
	
				when RIGHT =>
					output_x <= input_x+1;
					if(input_collision(2)= '1') then
						output_statex <= LEFT;
					end if;

				when KILL_STATE =>
					if(dead_goomba_done ='1') then
						output_statex <= RESET_STATE;
					end if;

				when RESET_STATE =>
					output_x <= unsigned(mario_x&'0')+ x_translation;
					output_statex <= LEFT;
			end case;


			case input_statey is
				when GROUND =>
					if(input_collision(1)= '0') then
						output_statey <= AIR;
					end if;

				when AIR =>
					output_y <= input_y+1;
					if(input_collision(1)= '1') then
						output_statey <= GROUND;
					end if;

				when KILL_STATE =>
					if(dead_goomba_done ='1') then
						output_statey <= RESET_STATE;
					end if;

				when RESET_STATE =>
					output_y <= "0011000";
					output_statey <= GROUND;
			end case;
		end if;

		if(input_y > "1111000") then
			output_kill <= '0';
			output_statey <= RESET_STATE;
			output_statex <= RESET_STATE;
		end if;
		
		if(input_x2 < x_cam-32 and x_cam>32) then
			output_kill <= '0';
			output_statex<=RESET_STATE;
			output_statey<=RESET_STATE;
		end if;
	end process;

dead_goomba_done <= dead_goomba1_done or dead_goomba2_done;


kill <= killG1 or killG2;
kill_G1 <= killG1;
kill_G2 <= killG2;

XG1_temp<= std_logic_vector(XG1);
X_G1<= XG1_temp(12 downto 1);
Y_G1 <= std_logic_vector(YG1)&'0';

XG2_temp<= std_logic_vector(XG2);
X_G2<= XG2_temp(12 downto 1);
Y_G2 <= std_logic_vector(YG2)&'0';

lose <= lose_temp;

end behaviour;

