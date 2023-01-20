library IEEE;
use IEEE.std_logic_1164.ALL;

entity enemies_fsm is
   port(clk            : in  std_logic;
        reset          : in  std_logic;
        enemies_lut_data : in  std_logic_vector( 1 downto 0);
        red            : out std_logic_vector(3 downto 0);
        green          : out std_logic_vector(3 downto 0);
        blue           : out std_logic_vector(3 downto 0);
        enemies_sel_bit  : out std_logic);
end enemies_fsm;

