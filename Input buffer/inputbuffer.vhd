library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
    
entity inputbuffer is
    port (  clk             : in    std_logic;
            reset           : in    std_logic;
            left            : in    std_logic;
            right           : in    std_logic;
            a               : in    std_logic;
            b               : in    std_logic;
	    disable_camera: in std_logic;
	    always_win: in std_logic;
	    collide_south: in std_logic;
	    never_lose: in std_logic;
            data_out        : out   std_logic_vector(7 downto 0));
            
end entity inputbuffer;
