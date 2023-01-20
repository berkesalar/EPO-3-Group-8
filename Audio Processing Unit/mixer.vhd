library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--component for adding the input amplitudes
entity mixer is
    port(
        amp1: in std_logic_vector(3 downto 0);
        amp2: in std_logic_vector(3 downto 0);
        amp3: in std_logic_vector(3 downto 0);
        amp4: in std_logic_vector(3 downto 0);
        amp_out: out std_logic_vector(5 downto 0));
end entity;

architecture behaviour of mixer is
begin

    --the output is an addition of all the inputs
    amp_out <= std_logic_vector(resize(unsigned(amp1),6) + resize(unsigned(amp2),6) + resize(unsigned(amp3),6) + resize(unsigned(amp4),6));
    
end architecture;
