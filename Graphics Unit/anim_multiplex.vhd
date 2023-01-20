library IEEE;
use IEEE.std_logic_1164.ALL;

entity anim_multiplex is
   port(sel_anim    : in  std_logic;
        stand_still : in  std_logic_vector(1 downto 0);
        anim_frame  : in  std_logic_vector(1 downto 0);
        mario_frame : out std_logic_vector(1 downto 0));
end anim_multiplex;

architecture behaviour of anim_multiplex is
begin      
        mario_frame <= stand_still when sel_anim = '0' else
                    anim_frame when sel_anim = '1' else
                    "00";
end behaviour;

