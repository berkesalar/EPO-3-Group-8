library ieee;
use ieee.std_logic_1164.all;
 
entity seg7_rc is
    port (      BCDin                   : in std_logic_vector (3 downto 0);
                ripple                  : in std_logic;
                ripple_carry            : out std_logic;
                Seven_Segment           : out std_logic_vector (6 downto 0));
end seg7_rc;