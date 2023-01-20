library IEEE;
use IEEE.std_logic_1164.ALL;

entity background_mux is
   port(background_select_bit : in  std_logic_vector(1 downto 0);
   
        block1 : in  std_logic_vector(1 downto 0);
        
		
        block2 : in  std_logic_vector(1 downto 0);
       
		
        lut_data_mux : out  std_logic_vector(1 downto 0));
end background_mux;

architecture behaviour of background_mux is
begin
	-- 11 is blue and 00 is black
	lut_data_mux <=	block2 when background_select_bit = "11" else
			block1 when background_select_bit = "10" else 
			"10" when background_select_bit = "00" else --will generate black when in reset state
			"11" when background_select_bit = "01" else --will generate blue when in blue state
		     (others => '0'); 
			 

	

end behaviour;
