library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

architecture behaviour of xy_calc is
    signal x_stored     : unsigned(19 downto 0);
    signal y_stored     : unsigned(15 downto 0);
    signal v_x_signed   : signed(10 downto 0);
    signal v_y_signed   : signed(11 downto 0);
    signal x_temp			: std_logic_vector(19 downto 0);
    signal y_temp			: std_logic_vector(15 downto 0);
    signal pre_ani 			: std_logic;
	 signal ani_compare		: std_logic;
    
begin

    v_x_signed <= signed(v_x);
    v_y_signed <= signed(v_y);

    process (clk, rst, enable_xy)
        begin
				if (rst = '1') then
						 x_stored <= "00000101000000000000"; --placeholders
						 y_stored <= "1100000000000000"; --placeholders
						 ani_compare <= '1';
				elsif(clk'event and clk = '1' and enable_xy='1') then
						 x_stored <= unsigned(signed(x_stored) + v_x_signed);
						 y_stored <= unsigned(signed(y_stored) + v_y_signed);
						 ani_compare <= pre_ani;
				end if;
    end process;

   process(v_x, ani_compare)
	begin

		if(ani_compare ='1') then
			if(v_x(10) = '1') then
				pre_ani <= '0';
			else
				pre_ani <= '1';
			end if;
		else
			if(v_x = "00000000000" or v_x(10)='1') then
				pre_ani <= '0';
			else
				pre_ani <= '1';
			end if;
		end if;

   end process;
	

    x_temp <= std_logic_vector(x_stored);
    y_temp <= std_logic_vector(y_stored);
    x_out <= x_temp(19 downto 8);
    y_out <= y_temp(15 downto 8);
	 Ani <= ani_compare;

end behaviour;

