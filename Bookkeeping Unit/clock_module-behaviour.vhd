library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


architecture behaviour of clock_module is
	type clk_state is (RESET_STATE, ACC, VEL, XY, GOOMBA, ANI, HOLD);
	signal state, new_state: clk_state;
	signal enable_xy_temp, enable_vel_temp, enable_acc_temp, enable_goomba_temp, enable_ani_temp: std_logic;
begin
	lbl1: process(clk, reset)
	begin
		if (reset = '1') then
				enable_acc <= '0';
				enable_vel <= '0';
				enable_xy <= '0';
				enable_goomba <= '0';
				enable_ani <= '0';
				state <= RESET_STATE;
				
		elsif(clk'event and clk = '1') then
				enable_acc <= enable_acc_temp;
				enable_vel <= enable_vel_temp;
				enable_xy <= enable_xy_temp;
				enable_goomba <= enable_goomba_temp;
				enable_ani <= enable_ani_temp;
				state <= new_state;	
		end if;
	end process;
	

	lbl2: process(state, clk_from_map)
	begin
		case state is	
			when RESET_STATE =>
				enable_acc_temp <= '0';
				enable_vel_temp <= '0';
				enable_xy_temp <= '0';
				enable_goomba_temp <= '0';
				enable_ani_temp <= '0';
				if(clk_from_map = '0') then
					new_state <= ACC;	
				else 
					new_state <= RESET_STATE;
				end if;

			when ACC =>
				enable_acc_temp <= '1';
				enable_vel_temp <= '0';
				enable_xy_temp <= '0';
				enable_goomba_temp <= '0';
				enable_ani_temp <= '0';
				new_state <= VEL;	

			when VEL =>
				enable_vel_temp <= '1';
				enable_acc_temp <= '0';
				enable_xy_temp <= '0';
				enable_goomba_temp <= '0';
				enable_ani_temp <= '0';
				new_state <= XY;	

			when XY =>
				enable_xy_temp <= '1';
				enable_acc_temp <= '0';
				enable_vel_temp <= '0';
				enable_goomba_temp <= '0';
				enable_ani_temp <= '0';
				new_state <= GOOMBA;

			when GOOMBA =>
				enable_xy_temp <= '0';
				enable_acc_temp <= '0';
				enable_vel_temp <= '0';
				enable_goomba_temp <= '1';
				enable_ani_temp <= '0';
				new_state <= ANI;
				
			when ANI =>
				enable_xy_temp <= '0';
				enable_acc_temp <= '0';
				enable_vel_temp <= '0';
				enable_goomba_temp <= '0';
				enable_ani_temp <= '1';
				new_state <= HOLD;


			when HOLD =>
				enable_xy_temp <= '0';
				enable_acc_temp <= '0';
				enable_vel_temp <= '0';
				enable_goomba_temp <= '0';
				enable_ani_temp <= '0';
				if(clk_from_map = '1') then
					new_state <= RESET_STATE;
				else
					new_state <= HOLD;
				end if;
		end case;
	end process;
end behaviour;

