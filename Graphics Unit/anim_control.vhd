library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity anim_controller is
    port (
		clk			 : in std_logic;
        reset        : in std_logic;
        forw         : in std_logic;
        back         : in std_logic;
        enable	     : in std_logic;
        sel_anim     : out std_logic;
        sel_move     : out std_logic);
end entity anim_controller;

architecture controller of anim_controller is
type anim_state is (check_anim, forw_anim_reset, forw_anim, forw_anim_cnt, forw_2_reset, forw_2,  forw_2_cnt);
signal state, new_state : anim_state;

signal cnt, resetloop: std_logic;
signal loopcount, new_loopcount: std_logic_vector(2 downto 0);

begin
    process(reset, clk, resetloop, enable)
    begin
	   if(reset = '1') then
			loopcount <= "000";
			state <= check_anim;
		elsif(rising_edge(clk) and enable = '1') then
			if(resetloop = '1') then
				loopcount <= "000";
			else
				loopcount <= new_loopcount;
			end if;
			state <= new_state;
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
    animation: process(state, forw, back, loopcount)  --fsm to choose the animation
    begin
        case state is 
            when check_anim =>
                sel_anim <= '0';
                sel_move <= '0';
					 cnt <= '0'; 
					 resetloop <= '1';
                if ((forw = '0') OR (back = '0')) then
                    new_state <= forw_anim;
           
					 else
                    new_state <= check_anim;
                end if;

			when forw_anim_reset =>
				sel_anim <= '1';
				sel_move <= '0';
				cnt <= '0';
				resetloop <= '1';
				new_state <= forw_anim;

				when forw_anim =>
                sel_anim <= '1';
                sel_move <= '0';
					cnt <= '0';
				resetloop <= '0';
                if ((forw = '0') OR (back = '0')) then  
					if (loopcount = "110") then
						new_state <= forw_2_reset;
					else
						new_state <= forw_anim_cnt;
					end if;					
            	else 
                    new_state <= check_anim; 
				end if;
				
				when forw_anim_cnt =>
					sel_anim <= '1';
					sel_move <= '0';
					cnt <= '1';
					resetloop <= '0';
					new_state <= forw_anim;


				when forw_2_reset =>
					sel_anim <= '1';
					sel_move <= '1';
					cnt <= '0';
					resetloop <= '1';
					new_state <= forw_2;
                
				when forw_2 =>
					sel_anim <= '1';
					sel_move <= '1';
					cnt <= '0';
					resetloop <= '0';
                    if ((forw = '0') OR (back = '0')) then
						if (loopcount = "110") then
							new_state <= forw_anim_reset;
						else
							new_state <= forw_2_cnt;
						end if;			
                    else 
                        new_state <= check_anim;
					end if;
				
					when forw_2_cnt =>
						sel_anim <= '1';
						sel_move <= '1';
						cnt <= '1';
						resetloop <= '0';
						new_state <= forw_2;
					
					
        end case;
    end process;
end controller;
