library IEEE;
use IEEE.std_logic_1164.ALL;

entity move_multiplex is
   port(sel_move   : in  std_logic;
        walk_forw  : in  std_logic_vector(1 downto 0);
        stand_norm : in  std_logic_vector(1 downto 0);
        anim_frame : out std_logic_vector(1 downto 0));
end move_multiplex;

architecture behaviour of move_multiplex is
begin      
        anim_frame <= walk_forw when sel_move = '0' else
                     stand_norm when sel_move = '1' else
							"00";
end behaviour;

