library IEEE;
use IEEE.std_logic_1164.ALL;

entity direction_mux is
   port(sel_direction    : in  std_logic;
        ref_address : in  std_logic_vector(7 downto 0);
        norm_address  : in  std_logic_vector(7 downto 0);
        lut_address : out std_logic_vector(7 downto 0));
end direction_mux;

architecture behaviour of direction_mux is
begin      
        lut_address <= ref_address when sel_direction = '0' else
                    norm_address when sel_direction = '1' else
                    "00000000";
end behaviour;

