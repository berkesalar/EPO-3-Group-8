library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity goomba_anim is
    port (
		clk				 : in std_logic;
        reset        	 : in std_logic;
		killed		 	 : in std_logic;
		enable:			   in std_logic;
		dead_goomba_done : out std_logic;
        sel_goomba   	 : out std_logic_vector(1 downto 0)
    );
end entity goomba_anim;

architecture controller of goomba_anim is
type anim_state is (check_anim, forw_anim_reset, forw_anim, forw_anim_cnt, forw_2, forw_2_reset, forw_2_cnt, death_anim, death_int, death_cnt, alert_goomba_unit);
signal state, new_state : anim_state;
signal cnt, resetloop: std_logic;
signal loopcount, new_loopcount: std_logic_vector(2 downto 0);

begin
    process(reset, clk, resetloop, enable)
    begin
	   if(reset = '1') then
				loopcount <= "000";
				state <= forw_2_reset;
		elsif(rising_edge(clk) and enable = '1') then
					if(resetloop = '1') then
						loopcount <= "000";
					else
						loopcount <= new_loopcount;
					end if;
					
					if(killed = '1' and state /= death_anim and state /= alert_goomba_unit and state /= death_cnt and state /= death_int ) then
						state <= death_anim;
					else 
						state <= new_state;
					end if;
		end if;
	end process;
				

	process(cnt, loopcount)
	begin
		if(cnt = '1') then
			new_loopcount <= std_logic_vector(unsigned(loopcount) + 1);
		else
			new_loopcount <= loopcount;
		end if;
	end process;
	
	---- sel_move "10"and "11" are the animations when mario walks to the right
	---- sel_move "01" is when mario jumps
    animation: process(state, loopcount, killed)  --fsm to choose the animation
    begin
				case state is 
						when check_anim =>
							sel_goomba <= "00";
							dead_goomba_done <= '0';
							resetloop <= '1';
							cnt <= '0';
								new_state <= forw_anim_reset;
								

						when forw_anim_reset =>
							sel_goomba <= "00";
							dead_goomba_done <= '0';
							resetloop <= '1';
							cnt <= '0';
							new_state <= forw_anim;

						when forw_anim =>
							sel_goomba <= "00";
							dead_goomba_done <= '0';
							cnt <= '0';
							resetloop <= '0'; 
							if (loopcount = "110") then
								new_state <= forw_2_reset;
							else
								new_state <= forw_anim_cnt;			
							end if;
							
						when forw_anim_cnt =>
							sel_goomba <= "00";
							dead_goomba_done <= '0';
							cnt <= '1';
							resetloop <= '0';
							new_state <= forw_anim;

						when forw_2_reset => 
							sel_goomba <= "01";
							dead_goomba_done <= '0';
							cnt <= '0';
							resetloop <= '1'; 
							new_state <= forw_2;
							
						when forw_2 =>
							sel_goomba <= "01";
							dead_goomba_done <= '0';
							cnt <= '0';
							resetloop <= '0';
							if (loopcount = "110") then
								new_state <= forw_anim_reset;
							else
								new_state <= forw_2_cnt;
							end if;			
						
							when forw_2_cnt =>
								sel_goomba <= "01";
								dead_goomba_done <= '0';
								cnt <= '1';
								resetloop <= '0';
								new_state <= forw_2;
							
							when death_anim =>
								sel_goomba <= "10";
								dead_goomba_done <= '0';
								cnt <= '0';
								resetloop <= '1';
								new_state <= death_int;
							
							when death_int =>
								sel_goomba <= "10";
								dead_goomba_done <= '0';
								cnt <= '0';
								resetloop <= '0';
								if (loopcount = "110") then
									new_state <= alert_goomba_unit;
								else
									new_state <= death_cnt;
								end if;
							
							when death_cnt =>
								sel_goomba <= "10";
								dead_goomba_done <= '0';
								resetloop <= '0';
								cnt <= '1';
								new_state <= death_int;
							
							when alert_goomba_unit => 
								sel_goomba <= "10";
								resetloop <= '1';
								cnt <= '0';
								dead_goomba_done <= '1';
								new_state <= check_anim;
					end case;
			
    end process;
end controller;
