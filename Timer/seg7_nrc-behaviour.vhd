library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behaviour of seg7_nrc is
type seg7_nrc_lut is array (0 to 9) of std_logic_vector(6 downto 0);
constant seg7_nrc_patterns : seg7_nrc_lut := (
    --active high signals
    "1111110", -- 0
    "0110000", -- 1
    "1101101", -- 2
    "1111001", -- 3
    "0110011", -- 4
    "1011011", -- 5
    "1011111", -- 6
    "1110000", -- 7
    "1111111", -- 8
    "1111011"  -- 9
);
begin
    Seven_Segment <= seg7_nrc_patterns(to_integer(unsigned(BCDin)));
end behaviour;