library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

architecture behaviour of vel_calc_y is
			signal	a_y_signed		:	signed(10 downto 0);
			signal	v_y				:	signed(11 downto 0);
			signal	v_y_stored		:	signed(11 downto 0);
begin
	a_y_signed	<= signed(a_y);
  
	process (clk, rst, enable_vel)
        begin

	    if  (rst = '1')       then --asynchronous reset (derrived clock)
		v_y_stored  <= (others => '0');
            elsif  (clk'event and clk = '1' and enable_vel='1') then
				
		if ((collision(3) = '1' and v_y_stored(11)= '1') or (collision(1) = '1' and v_y_stored(11)= '0' and v_y_stored /= 0)) then
			v_y_stored <= (others => '0');
		else 	
			if(to_signed(1020, 12) < (v_y_stored + a_y_signed))then
				v_y_stored <= to_signed(1020, 12);
			else
				v_y_stored  <= v_y_stored+ a_y_signed;
			end if;
						 
		end if;
	    end if;
				
    end process;

	v_y_out <= std_logic_vector(v_y_stored);
end behaviour;

