library IEEE;
use IEEE.std_logic_1164.ALL;
use ieee.numeric_std.all;

entity background_control is
   port(clk      : in  std_logic;
        reset    : in  std_logic;
        h_reg    : in  std_logic_vector(9 downto 0);
        v_reg    : in  std_logic_vector(9 downto 0);
        lut_data : in  std_logic_vector(3 downto 0);
        background_muxselect : out std_logic_vector(1 downto 0));
end background_control;

architecture behavioural of background_control is

type background_state is (resetstate, bluestate, block1state, block2state);
signal state, newstate : background_state;

begin

sequential: process (clk)
	begin
		if (rising_edge (clk)) then
			if (reset = '1') then
				state <= resetstate;
			else
				state <= newstate;
			end if;
		end if;
	end process;
	
combinatorial: process(state, lut_data, h_reg, v_reg)
begin
	case state is
	
	--agreed values from level-lut: 00-- = blue   01-- = block1    10-- = block2 (brick)
	
		when bluestate =>	
	
			background_muxselect <= "01";
			
			
			if ((to_integer(unsigned(h_reg))) > 638 or (to_integer(unsigned(v_reg)) > 478)) then
				newstate <= resetstate;
			elsif (lut_data(3)= '0' and lut_data(2)= '1') then
				newstate <= block1state;
			elsif (lut_data(3)= '1' and lut_data(2)= '0') then
				newstate <= block2state;
			else
				newstate <= bluestate;
			end if;
			
		when resetstate =>
			
			background_muxselect <= "00";
			
			if ((to_integer(unsigned(h_reg))) < 639 and (to_integer(unsigned(v_reg)) < 479)) then
					if (lut_data(3)= '0' and lut_data(2)= '1') then
						newstate <= block1state;
					elsif (lut_data(3)= '1' and lut_data(2)= '0') then
						newstate <= block2state;
					else	
						newstate <= bluestate;
					end if;
			else 
				newstate <= resetstate;
			end if;
		
		when block1state =>
		
			background_muxselect <= "10";
			
			if ((to_integer(unsigned(h_reg))) > 638 or (to_integer(unsigned(v_reg)) > 478)) then
				newstate <= resetstate;
			elsif (lut_data(3)= '0' and lut_data(2)= '1') then
				newstate <= block1state;
			elsif (lut_data(3)= '1' and lut_data(2)= '0') then
				newstate <= block2state;
			else
				newstate <= bluestate;
			end if;
			
		when block2state =>
		
			background_muxselect <= "11";
		
			if ((to_integer(unsigned(h_reg))) > 638 or (to_integer(unsigned(v_reg)) > 478)) then
				newstate <= resetstate;
			elsif (lut_data(3)= '0' and lut_data(2)= '1') then
				newstate <= block1state;
			elsif (lut_data(3)= '1' and lut_data(2)= '0') then
				newstate <= block2state;
			else
				newstate <= bluestate;
			end if;
		
	end case;
end process;

end behavioural;

