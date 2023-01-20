library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--component to add volume control
entity volume is
    port(
        active: in std_logic;
        volume: in std_logic_vector(3 downto 0);
        amplitude: out std_logic_vector(3 downto 0));
end entity;

architecture behaviour of volume is
begin
    --just some AND gates, it is really that simple
    amplitude(0) <= volume(0) and active;
    amplitude(1) <= volume(1) and active;
    amplitude(2) <= volume(2) and active;
    amplitude(3) <= volume(3) and active;

end architecture;