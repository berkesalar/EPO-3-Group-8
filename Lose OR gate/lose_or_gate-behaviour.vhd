library IEEE;
use IEEE.std_logic_1164.ALL;

architecture behaviour of lose_or_gate is
begin
	final_lose <= (lose1 or lose2) and (not(never_lose));
end behaviour;

