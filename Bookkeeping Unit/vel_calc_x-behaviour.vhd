library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of vel_calc_x is
            signal      v_x             :   signed(10 downto 0);
            signal      v_x_stored      :   signed(10 downto 0);
            signal      a_x_signed      :   signed(5 downto 0);
            constant    v_x_max_walk    :   signed(10 downto 0) := B"00110010000";
            constant    v_x_min_walk    :   signed(10 downto 0) := B"11001110000";
            constant    v_x_max_run     :   signed(10 downto 0) := B"01010010000";
            constant    v_x_min_run     :   signed(10 downto 0) := B"10101110000";
            
begin
    a_x_signed      <= signed(a_x);
    
    process (clk, rst, enable_vel)
        begin
	    if  (rst = '1')       then --asynchronous reset (derrived clock)
			v_x_stored  <= (others => '0');
	    elsif  (rising_edge (clk) and enable_vel='1') then
				
					 
		if( ( to_signed(19, 11) > (v_x_stored+a_x_signed) and (v_x_stored+a_x_signed) > to_signed(-19, 11) ) or (collision(0) = '1' and v_x_stored(10)='1') or (collision(2) = '1'  and v_x_stored(10)='0' and v_x_stored /= 0)) then		
			v_x_stored <= (others => '0');			 
		else
			if(v_x_max_run < (v_x_stored+a_x_signed) and b='1') then
				v_x_stored <= v_x_max_run;
			elsif(v_x_max_walk < (v_x_stored+a_x_signed) and b='0') then
				v_x_stored <= v_x_max_walk;
			elsif(v_x_min_run > (v_x_stored+a_x_signed) and b='1') then
				v_x_stored <= v_x_min_run;
			elsif(v_x_min_walk > (v_x_stored+a_x_signed) and b='0') then
				v_x_stored <= v_x_min_walk;
			else
				v_x_stored <= v_x_stored+a_x_signed;
			end if;
							
		end if;
	    end if;
					
    end process;
		
        v_x_out <= std_logic_vector(v_x_stored);
        
end behaviour;

