library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behaviour of dabble is
begin
    with A_in select A_out <=
    --0 to 4 follows input
    "0000" when "0000", --0
    "0001" when "0001", --1
    "0010" when "0010", --2
    "0011" when "0011", --3
    "0100" when "0100", --4
     --5 to 9 has add 3   
    "1000" when "0101", --5
    "1001" when "0110", --6
    "1010" when "0111", --7
    "1011" when "1000", --8
    "1100" when "1001", --9
    -- no number greater than 9 can exist as an input, hence the rest are dont cares.
    "0000" when others; --others
end behaviour;