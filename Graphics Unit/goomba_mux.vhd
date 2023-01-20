library IEEE;
use IEEE.std_logic_1164.ALL;

entity goomba_mux is
   port(sel_goomba        : in  std_logic_vector(1 downto 0);
        goomba_1        : in  std_logic_vector(1 downto 0);
        goomba_2        : in  std_logic_vector(1 downto 0);
        goomba_dead     : in std_logic_vector(1 downto 0);
	r		: in std_logic;
        goomba_out      : out std_logic_vector(1 downto 0));
end goomba_mux;

architecture behaviour of goomba_mux is
begin      
        goomba_out <= goomba_1 when sel_goomba = "00" and r = '1' else
                    goomba_2 when sel_goomba = "01"  and r = '1' else
                    goomba_dead when sel_goomba = "10" and r = '1' else
                    "00";
end behaviour;
