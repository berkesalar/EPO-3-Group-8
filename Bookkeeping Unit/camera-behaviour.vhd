library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;


architecture behaviour of camera is

type cam_state is (init, reset_left, calc, wait_middle, right_end);
signal state, new_state : cam_state;
signal new_reg_x_cam_temp, reg_x_cam_temp: std_logic_vector(11 downto 0);

begin

    seq: process(reset, clk, new_reg_x_cam_temp)
    begin
        if (rising_edge(clk)) then
            if (reset = '1') then
                state <= init;
					 reg_x_cam_temp <= (others => '0');
            else
                	state <= new_state;
						reg_x_cam_temp <= new_reg_x_cam_temp;

		
            end if;
    end if;
    end process;
	
    
    cam: process(x_abs, ready, clk, disable_camera, state, reg_x_cam_temp)

    -- variable offset : std_logic_vector(9 downto 0);
	variable x_cam_temp: std_logic_vector(11 downto 0);
    variable x_rel_temp: std_logic_vector(8 downto 0);

    constant right_end_pixel: std_logic_vector(11 downto 0) := "110100011111";
	constant threshold_pixel: integer := 128;
    
	begin

    case state is
        when init =>
            x_cam_temp := (others => '0');
            x_rel_temp := (others => '0');
            new_state <= reset_left;

        when reset_left => 
            x_cam_temp := (others => '0');
            x_rel_temp := x_abs(8 downto 0);
            if (disable_camera = '1') then
                new_state <= reset_left;
            elsif (to_integer(unsigned(x_abs)) >= threshold_pixel) then
                new_state <= calc;
            else
                new_state <= reset_left;
            end if;

        when calc =>
            x_rel_temp := std_logic_vector(to_unsigned(threshold_pixel, 9));
            x_cam_temp := std_logic_vector(to_unsigned(to_integer(unsigned(x_abs)) - threshold_pixel, 12));
	        new_state <= wait_middle;
        
        when wait_middle =>
            x_rel_temp := std_logic_vector(to_unsigned(to_integer(unsigned(x_abs)) - to_integer(unsigned(x_cam_temp)), 9));
            x_cam_temp := reg_x_cam_temp;
			
			   if (to_integer(unsigned(x_abs)) < threshold_pixel) then
                new_state <= reset_left;
            elsif (ready = '1') then
                if ((to_integer(unsigned(x_abs)) >= (to_integer(unsigned(x_cam_temp)) + threshold_pixel))) then
                    new_state <= calc;
                else
                    new_state <= wait_middle;
                end if;
            elsif (to_integer(unsigned(x_cam_temp)) + 303 >= to_integer(unsigned(right_end_pixel))) then
                new_state <= right_end;  
            else
                new_state <= wait_middle;
            end if;

        when right_end =>
            x_cam_temp := "101111001111";
            x_rel_temp := std_logic_vector(to_unsigned(to_integer(unsigned(x_abs)) - to_integer(unsigned(x_cam_temp)), 9));
            new_state <= right_end;

    end case;
	new_reg_x_cam_temp <= x_cam_temp;
	x_rel <= x_rel_temp;
	x_cam <= x_cam_temp;
    end process;

end behaviour;
