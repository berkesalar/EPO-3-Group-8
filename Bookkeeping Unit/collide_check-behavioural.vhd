library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity collide_check is
    port (
        clk         : in std_logic;
        reset       : in std_logic;
        x_m     	: in std_logic_vector(11 downto 0); -- 0 <= x_m <= 319 < 2^9
        y_m	        : in std_logic_vector(7 downto 0); -- 0 <= y_m <= 239 < 2^8
        blk_data	: in std_logic_vector(3 downto 0);
        ready       : in std_logic;
		  collide_south: in std_logic;
	     x_cam		: in std_logic_vector (11 downto 0);
        addr    	: out std_logic_vector(11 downto 0);
        NESW    	: out std_logic_vector(3 downto 0);
        victory 	: out std_logic;
        lose    	: out std_logic;
        goomba_x_1  : in std_logic_vector(11 downto 0);
        goomba_y_1  : in std_logic_vector(7 downto 0);
        goomba_x_2  : in std_logic_vector(11 downto 0);
        goomba_y_2  : in std_logic_vector(7 downto 0);
	     ESW_G1	: out std_logic_vector(2 downto 0);
	     ESW_G2	: out std_logic_vector(2 downto 0)
    );
end entity collide_check;

architecture behavioural of collide_check is
    type check_state is (off, north1, north1_north2, north2_east1, east1_east2, east2_south1, south1_south2, south2_west1, west1_west2, west2_eastG1, eastG1_south1G1, south1G1_south2G1, south2G1_westG1, westG1_eastG2, eastG2_south1G2, south1G2_south2G2, south2G2_westG2, westG2, hold_0, hold_1);
    signal state, new_state: check_state;


    
    -- signal x_mp:               std_logic_vector(8 downto 0); -- add 16 to change the 
    signal NOZW:		             std_logic_vector(3 downto 0);
    signal addr_temp:		        std_logic_vector(11 downto 0);
    signal nesw_temp:          std_logic_vector(3 downto 0);
    signal ESWG1_temp, ESWG2_temp:		        std_logic_vector(2 downto 0);
    signal OZWG1, OZWG2:				std_logic_vector(2 downto 0);
    constant lut_screen_width: integer := 210;  -- number of columns in level LUT (max x coordinate); used to compute address (= [x + y * 21] / 16)
    --constant addr_length:      integer := 11;   -- number of bits in address to level LUT.

    signal x_input:             std_logic_vector(11 downto 0);
    signal y_input:             std_logic_vector(7 downto 0);
    signal translation_x: unsigned(4 downto 0);
    signal translation_y: unsigned(4 downto 0);
    signal new_lose, new_victory, lose_temp, victory_temp: std_logic;

begin
    process(reset, clk)
    begin
        if(rising_edge(clk)) then
		  
				if(reset = '1') then
					state <= off;
					addr <= (others => '0');
					nesw_temp <= "0000";
					ESWG1_temp <= "000";
					ESWG2_temp <= "000";
					lose_temp <= '0';
					victory_temp <= '0';
				else 
					state <= new_state;
					addr <= addr_temp;
					nesw_temp <= NOZW;
					ESWG1_temp <= OZWG1;
					ESWG2_temp <= OZWG2;
					lose_temp <= new_lose;
					victory_temp <= new_victory;
				end if;
        end if;
    end process;
    

    coll_checker: process(x_m, y_m, blk_data, state, ready, nesw_temp, lose_temp, victory_temp, ESWG1_temp, ESWG2_temp, x_cam, goomba_x_1, goomba_x_2, goomba_y_1, goomba_y_2, collide_south)


    begin
        --x_mp <= std_logic_vector(to_unsigned(to_integer(unsigned(x_m)) + 16, 9));
	
	OZWG1 <= ESWG1_temp;
	OZWG2 <= ESWG2_temp;
        NOZW <= nesw_temp;

	new_lose <= lose_temp;
	new_victory <= victory_temp;
		  
        case state is
            when off =>
		 new_lose <= '0';
		 new_victory <= '0';
		 OZWG1 <= "000";
		 OZWG2 <= "000";
        		 NOZW <= "0000";
                     x_input <=(others => '0');
                     y_input <=(others => '0');
                     translation_x <= to_unsigned(0, 5);
                     translation_y <= to_unsigned(0,5);
                	if(ready = '1') then
                		new_state <= north1;
                	else
                    		new_state <= off;
                	end if;

            when north1 =>

                x_input <=X_m;
                y_input <=y_m;
                translation_x <= to_unsigned(3,5);
                translation_y <= to_unsigned(0,5);

					 
		new_lose <= '0';
		new_victory <= '0';
		OZWG1 <= "000";
		OZWG2 <= "000";
        		NOZW <= "0000";
                new_state <= north1_north2;

            when north1_north2 =>
                if(blk_data(1 downto 0) = "01" or y_m < "00000010")then
                    NOZW(3) <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
					 
                x_input <=X_m;
                y_input <=y_m;
                translation_x <= to_unsigned(9,5);
                translation_y <= to_unsigned(0,5);

                new_state <= north2_east1;

            when north2_east1 =>
                if(blk_data(1 downto 0) = "01" or y_m < "00000011") then
                    NOZW(3) <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
					 
                x_input <=X_m;
                y_input <=y_m;
                translation_x <= to_unsigned(12,5);
                translation_y <= to_unsigned(3,5);

                new_state <= east1_east2;

            when east1_east2 => 
                if(blk_data(1 downto 0) = "01") then
                    NOZW(2) <= '1';	
                end if;
					 
		if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
                
                x_input <=X_m;
                y_input <=y_m;
                translation_x <= to_unsigned(12,5);
                translation_y <= to_unsigned(12,5);
                new_state <= east2_south1;

            when east2_south1 => 
                if(blk_data(1 downto 0) = "01") then
                    NOZW(2) <= '1';	
                end if;
					 
					if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
                
                x_input <=X_m;
                y_input <=y_m;
                translation_x <= to_unsigned(9,5);
                translation_y <= to_unsigned(16,5);
                new_state <= south1_south2;

            when south1_south2 => 
                if(blk_data(1 downto 0) = "01") then
                    NOZW(1) <= '1';	
                end if;
					 
		if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
                
                x_input <=X_m;
                y_input <=y_m;
                translation_x <= to_unsigned(3,5);
                translation_y <= to_unsigned(16,5);
                new_state <= south2_west1;
            
            when south2_west1 =>
                if(blk_data(1 downto 0) = "01") then
                    NOZW(1) <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
                
                x_input <=X_m;
                y_input <=y_m;
                translation_x <= to_unsigned(0,5);
                translation_y <= to_unsigned(12,5);
                new_state <= west1_west2;

            when west1_west2 =>
                if(blk_data(1 downto 0) = "01" or (unsigned(x_m) <= to_unsigned((to_integer(unsigned(x_cam)) + 2), 12))) then
                    NOZW(0) <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
					 
                x_input <= x_m;
                y_input <= y_m;
                translation_x <= to_unsigned(0,5);
                translation_y <= to_unsigned(3,5);
                new_state <= west2_eastG1;   

            when west2_eastG1 =>
                if(blk_data(1 downto 0) = "01") then
                    NOZW(0) <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "10") then
                    new_lose <= '1';
                end if;
					 
		if(blk_data(1 downto 0) = "11") then
                    new_victory <= '1';
                end if;
					 
                x_input <= goomba_x_1;
                y_input <= goomba_y_1;
                translation_x <= to_unsigned(16,5);
                translation_y <= to_unsigned(8,5);
                new_state <= eastG1_south1G1;   


            when eastG1_south1G1 =>
                if(blk_data(1 downto 0) = "01") then
                    OZWG1(2) <= '1';
                end if;
					 
                x_input <= goomba_x_1;
                y_input <= goomba_y_1;
                translation_x <= to_unsigned(14,5);
                translation_y <= to_unsigned(16,5);
                new_state <= south1G1_south2G1;

            when south1G1_south2G1 =>
                if(blk_data(1 downto 0) = "01") then
                    OZWG1(1) <= '1';
                end if;
					 
                x_input <= goomba_x_1;
                y_input <= goomba_y_1;
                translation_x <= to_unsigned(2,5);
                translation_y <= to_unsigned(16,5);
                new_state <= south2G1_westG1;  

            when south2G1_westG1 =>
                if(blk_data(1 downto 0) = "01") then
                    OZWG1(1) <= '1';
                end if;
					 
                x_input <= goomba_x_1;
                y_input <= goomba_y_1;
                translation_x <= to_unsigned(0,5);
                translation_y <= to_unsigned(8,5);
                new_state <= westG1_eastG2;  

            when westG1_eastG2 =>
                if(blk_data(1 downto 0) = "01" or std_logic_vector(unsigned(goomba_x_1)) <= std_logic_vector( 3 + unsigned(x_cam))) then
                    OZWG1(0) <= '1';
                end if;
					 
                x_input <= goomba_x_2;
                y_input <= goomba_y_2;
                translation_x <= to_unsigned(16,5);
                translation_y <= to_unsigned(8,5);
                new_state <= eastG2_south1G2;

            when eastG2_south1G2 =>
                if(blk_data(1 downto 0) = "01") then
                    OZWG2(2) <= '1';
                end if;
					 
                x_input <= goomba_x_2;
                y_input <= goomba_y_2;
                translation_x <= to_unsigned(14,5);
                translation_y <= to_unsigned(16,5);
                new_state <= south1G2_south2G2;

            when south1G2_south2G2 =>
                if(blk_data(1 downto 0) = "01") then
                    OZWG2(1) <= '1';
                end if;
					 
                x_input <= goomba_x_2;
                y_input <= goomba_y_2;
                translation_x <= to_unsigned(2,5);
                translation_y <= to_unsigned(16,5);
                new_state <= south2G2_westG2;  

            when south2G2_westG2 =>
                if(blk_data(1 downto 0) = "01") then
                    OZWG2(1) <= '1';
                end if;
					 
                x_input <= goomba_x_2;
                y_input <= goomba_y_2;
                translation_x <= to_unsigned(0,5);
                translation_y <= to_unsigned(8,5);
                new_state <= westG2;  


	   when westG2 =>
                if(blk_data(1 downto 0) = "01" or std_logic_vector(unsigned(goomba_x_2)) <= std_logic_vector( 3 + unsigned(x_cam))) then
                    OZWG2(0) <= '1';
                end if;
					 
                x_input <= (others => '0');
                y_input <= (others => '0');
                translation_x <= to_unsigned(0,5);
                translation_y <= to_unsigned(0,5);
                new_state <= hold_0;

           

            when hold_0 =>		 
                x_input <=(others => '0');
                y_input <=(others => '0');
                translation_x <= to_unsigned(0,5);
                translation_y <= to_unsigned(0,5);

                if(ready = '0') then
                    new_state <= hold_1;
                else
                    new_state <= hold_0;
                end if;
            
            when hold_1 =>
                x_input <=(others => '0');
                y_input <=(others => '0');
                translation_x <= to_unsigned(0,5);
                translation_y <= to_unsigned(0,5);

                if(ready = '1') then
                    new_state <= north1;
                else
                    new_state <= hold_1;
                end if;
        end case;
		  
		  if(collide_south = '1') then
				NOZW(1) <= '1';
		  end if;
    end process; 
	 
	 
	 
process(x_input, y_input, translation_x, translation_y)
variable x_temp:             std_logic_vector(11 downto 0) := "000000000000"; -- Placeholder x value for collision checkpoint
variable y_temp:	            std_logic_vector(7 downto 0) := "00000000"; -- Placeholder y value for collision checkpoint
variable x_shifted:          std_logic_vector(8 downto 0) := "000000000";
variable y_shifted:          std_logic_vector(8 downto 0) := "000000000";
begin
            x_temp := std_logic_vector(unsigned(x_input) + translation_x);
            y_temp := std_logic_vector(unsigned(y_input) + translation_y);
            x_shifted := '0'&x_temp(11 downto 4);
            y_shifted := "00000"&y_temp(7 downto 4);
            addr_temp <= std_logic_vector(unsigned(x_shifted) +1+ resize(unsigned(y_shifted) * to_unsigned(lut_screen_width,12), 12));
end process;
 
 
 ESW_G1 <= eswG1_temp;
 ESW_G2 <= eswG2_temp;
 NESW <= nesw_temp; 
 lose <= lose_temp;
 victory <= victory_temp;
end architecture;
