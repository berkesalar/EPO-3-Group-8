library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

architecture behaviour of seg7_rc is
type seg7_rc_lut is array (0 to 9) of std_logic_vector(6 downto 0);
constant seg7_rc_patterns : seg7_rc_lut := (
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
    process(BCDin, ripple)
    begin
        if (BCDin = "0000" and ripple = '1') then
            Seven_Segment <= "0000000";
            ripple_carry <= '1';
        else
            Seven_Segment <= seg7_rc_patterns(to_integer(unsigned(BCDin)));
            ripple_carry <= '0';
        end if;
    end process;
end behaviour;