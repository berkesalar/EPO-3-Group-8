library IEEE;
use IEEE.std_logic_1164.ALL;

entity lose_or_gate is
   port(lose1      : in  std_logic;
        lose2      : in  std_logic;
	never_lose : in std_logic;
        final_lose : out std_logic);
end lose_or_gate;

