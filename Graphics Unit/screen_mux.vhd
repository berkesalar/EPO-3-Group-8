library IEEE;
use IEEE.std_logic_1164.ALL;

entity screen_mux is
   port(lose_lut   : in  std_logic;
        win_lut    : in  std_logic;
        start_lut  : in  std_logic;
	lose_sel   : in std_logic;
	win_sel   : in std_logic;
	start_sel   : in std_logic;
        screen : out std_logic);
end screen_mux;

architecture behaviour of screen_mux is
begin
	
	screen <=	lose_lut when (lose_sel = '1' AND win_sel = '0' AND start_sel = '0') else
			win_lut when (lose_sel = '0' AND win_sel = '1' AND start_sel = '0') else 
			 start_lut when (lose_sel = '0' AND win_sel = '0' AND start_sel = '1') else
		     '0'; 
end behaviour;

--start_sel is sent to physics so startscreen remains
